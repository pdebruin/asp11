FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:11.0 AS build
ARG TARGETARCH
WORKDIR /source

COPY --link web/*.csproj .
RUN dotnet restore -a $TARGETARCH

COPY --link web/. .
RUN dotnet publish -a $TARGETARCH --no-restore -o /app


FROM mcr.microsoft.com/dotnet/aspnet:11.0
EXPOSE 8080
WORKDIR /app
COPY --link --from=build /app .
USER $APP_UID
ENTRYPOINT ["./web"]
