# Establecer la imagen base de .NET Core SDK para construir la aplicación
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

# Copiar csproj y restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar todo el contenido y compilar la aplicación
COPY . ./
RUN dotnet publish -c Release -o out

# Construir la imagen de tiempo de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
EXPOSE 80

# Copiar la aplicación compilada desde la etapa de construcción
COPY --from=build-env /app/out .

# Definir el comando de entrada para ejecutar la aplicación
ENTRYPOINT ["dotnet", "utbapp.dll"]

