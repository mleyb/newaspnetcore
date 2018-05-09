FROM microsoft/dotnet:2.1-sdk-alpine AS builder
WORKDIR /
COPY . .
RUN dotnet restore newaspnetcore.csproj
RUN dotnet publish newaspnetcore.csproj -o /dockerout/ -c Release

FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine
WORKDIR /app
EXPOSE 80 5000

COPY --from=builder /dockerout .

ENTRYPOINT ["dotnet", "newaspnetcore.dll"]