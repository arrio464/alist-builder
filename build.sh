#! /bin/bash
set -e
echo "Building alist modified version..."
echo "Version: $1"

builtAt="$(date +'%F %T %z')"
goVersion=$(go version | sed 's/go version //')
version="${1}_modified"
webVersion="${1}_modified"
ldflags="-w -s \
-X 'github.com/alist-org/alist/v3/internal/conf.BuiltAt=$builtAt' \
-X 'github.com/alist-org/alist/v3/internal/conf.GoVersion=$goVersion' \
-X 'github.com/alist-org/alist/v3/internal/conf.Version=$version' \
-X 'github.com/alist-org/alist/v3/internal/conf.WebVersion=$webVersion'"

# Build for Windows x64
GOOS=windows GOARCH=amd64 go build -ldflags="$ldflags" -o alist-windows-amd64.exe

# Build for Linux x64
GOOS=linux GOARCH=amd64 go build -ldflags="$ldflags" -o alist-linux-amd64

# Build for Linux ARM64
GOOS=linux GOARCH=arm64 go build -ldflags="$ldflags" -o alist-linux-arm64

# Build for Linux ARMv7
GOOS=linux GOARCH=arm GOARM=7 go build -ldflags="$ldflags" -o alist-linux-armv7

echo "Build completed."