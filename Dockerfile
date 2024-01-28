FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet Restore
# Build and publish a release
RUN dotnet publish App.sln -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]