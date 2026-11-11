# ASP11 requirements

Annual ASP.NET container project, following the asp7/8/9/10 pattern:
one minimal ASP.NET app, published three ways, sizes compared.

## Scope

Three publish outputs:

1. Default (framework-dependent, normal base image)
2. Chiseled
3. Chiseled, trimmed, self-contained

## Target

- TFM: net11.0
- Source: https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core

## Base images

Verified present in MCR:

    mcr.microsoft.com/dotnet/sdk:11.0-preview           (11.0.100-rc.1)
    mcr.microsoft.com/dotnet/aspnet:11.0-preview        (11.0.0-rc.1)
    mcr.microsoft.com/dotnet/runtime:11.0-preview       (11.0.0-rc.1)
    mcr.microsoft.com/dotnet/runtime-deps:11.0-preview  (11.0.0-rc.1)

Source: https://documentation.ubuntu.com/release-notes/26.04/

## Publish commands

Intended commands:

    dotnet publish -p:PublishProfile=DefaultContainer

    dotnet publish -p:PublishProfile=DefaultContainer \
      -p:ContainerFamily=resolute-chiseled

    dotnet publish -p:PublishProfile=DefaultContainer \
      -p:ContainerFamily=resolute-chiseled \
      -p:PublishTrimmed=true --self-contained true

`-p PublishProfile=DefaultContainer` is equivalent to `/t:PublishContainer`.
Source: https://learn.microsoft.com/dotnet/core/containers/publish-configuration

## Build environment

Documented SDK container pattern, volume mount only:

    docker run --rm -v $(pwd):/app -w /app \
      mcr.microsoft.com/dotnet/sdk:11.0-preview \
      dotnet publish -c Release -o out

Source: https://github.com/dotnet/dotnet-docker/blob/main/samples/build-in-sdk-container.md

