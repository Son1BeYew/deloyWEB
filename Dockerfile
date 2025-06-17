# ---- BUILD ----
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# ---- RUNTIME ----
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:${PORT}
ENV DOTNET_ENVIRONMENT=Production
ENTRYPOINT ["dotnet", "VAYTIEN.dll"]
