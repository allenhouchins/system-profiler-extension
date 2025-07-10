.PHONY: build clean test deps all

# Build the extension
build:
	go mod tidy
	go build -o system_profiler.ext

# Clean build artifacts
clean:
	rm -f system_profiler.ext

# Run tests
test:
	go test ./...

# Test the extension
test-extension:
	./test_extension.sh

# Install dependencies
deps:
	go mod download
	go mod tidy

# Build for macOS (default)
build-darwin-amd64:
	GOOS=darwin GOARCH=amd64 go build -o system_profiler.ext

build-darwin-arm64:
	GOOS=darwin GOARCH=arm64 go build -o system_profiler.ext

# Build for different architectures
build-linux-amd64:
	GOOS=linux GOARCH=amd64 go build -o system_profiler.ext

build-linux-arm64:
	GOOS=linux GOARCH=arm64 go build -o system_profiler.ext

# Default target
all: deps build 