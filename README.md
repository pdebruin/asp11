# ASP11

A new version of .NET has been released, and so here is a new repo with source code, commands and links to create ASP.NET container images on Ubuntu and Azure Linux. Only Docker is needed, no .NET SDK on the host.

| | Ubuntu | Azure Linux 3.0 |
|---|---|---|
| default | 390 MB | 350 MB |
| chiseled / distroless | 189 MB | 212 MB |
| native AOT | 48 MB | 71 MB |

The app itself is about 100 KB, so the default and chiseled/distroless sizes are the base images. Chiseled and distroless remove the shell, the package manager and other OS packages that .NET doesn't need. Native AOT compiles the app to a single native executable of about 23 MB, so it needs no .NET runtime and runs on the `runtime-deps` base images: 25 MB on Ubuntu and 47 MB on Azure Linux. The Azure Linux distroless images include time zone data and locales, while the Ubuntu chiseled images leave them out.

```
docker build --pull -t pdebruin/asp11:default .

docker build --pull -t pdebruin/asp11:chiseled -f Dockerfile.chiseled .

docker build --pull -t pdebruin/asp11:aot -f Dockerfile.aot .

docker build --pull -t pdebruin/asp11:azurelinux -f Dockerfile.azurelinux .

docker build --pull -t pdebruin/asp11:azurelinux-distroless -f Dockerfile.azurelinux-distroless .

docker build --pull -t pdebruin/asp11:azurelinux-aot -f Dockerfile.azurelinux-aot .
```

```
docker run --rm -it -p 8080:8080 pdebruin/asp11:aot
```

The app in `web/` was created with:

```
docker run --rm -u "$(id -u):$(id -g)" -v "$PWD:/app" -w /app \
  mcr.microsoft.com/dotnet/sdk:11.0 dotnet new web -o web
```

Sources:

[dotnet-docker ASP.NET Core sample](https://github.com/dotnet/dotnet-docker/tree/main/samples/AspNetCoreRazorApp)

[dotnet-docker Native AOT sample](https://github.com/dotnet/dotnet-docker/tree/main/samples/AspNetCoreNativeAot)

[Ubuntu chiseled images](https://github.com/dotnet/dotnet-docker/blob/main/documentation/ubuntu-chiseled.md)

[Azure Linux images](https://github.com/dotnet/dotnet-docker/blob/main/documentation/azurelinux.md)

[my asp11 images at Docker Hub](https://hub.docker.com/r/pdebruin/asp11/tags)
