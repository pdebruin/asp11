# ASP11 plan

## 1. Scaffold

    docker run --rm -u "$(id -u):$(id -g)" \
      -v "$PWD:/app" -w /app \
      mcr.microsoft.com/dotnet/sdk:11.0.100-rc.1 \
      dotnet new web -o web

## 2. Build mechanism

SDK container, volume mount, archive out, load on host.

    docker run --rm -u "$(id -u):$(id -g)" \
      -v "$PWD:/app" -w /app/web \
      mcr.microsoft.com/dotnet/sdk:11.0.100-rc.1 \
      dotnet publish -t:PublishContainer \
        -p:ContainerRepository=asp11 \
        -p:ContainerImageTag=<tag> \
        -p:ContainerArchiveOutputPath=/app/out/<tag>.tar.gz

    docker load -i out/<tag>.tar.gz

## 3. build.sh

Runs the three publishes, loads the archives, prints sizes.

    default    no extra flags
    chiseled   -p:ContainerFamily=resolute-chiseled
    trimmed    -p:ContainerFamily=resolute-chiseled -p:PublishTrimmed=true --self-contained true

Tags: asp11:default, asp11:chiseled, asp11:trimmed

## 4. Build

Run build.sh. Capture `docker images` sizes. Curl each image to confirm it serves.

## 5. Eval

Three sizes, and what the delta between them costs.

## 6. README

Intro, three commands, sizes, docker run line, links.
