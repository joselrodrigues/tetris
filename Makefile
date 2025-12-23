.PHONY: build run web web-run clean kill-emrun help

# Variables
PROJECT_NAME = tetris

# Default target
help:
	@echo "Makefile for $(PROJECT_NAME)"
	@echo ""
	@echo "Available commands:"
	@echo "  make build       - Build native version"
	@echo "  make run         - Build and run native version"
	@echo "  make web         - Build web version (WASM)"
	@echo "  make web-run     - Build and run web version with emrun"
	@echo "  make clean       - Clean build artifacts"
	@echo "  make kill-emrun  - Kill active emrun processes"
	@echo "  make help        - Show this help"

# Build native version
build:
	zig build

# Build and run native version
run:
	zig build run

# Build web version
web:
	zig build -Dtarget=wasm32-emscripten

# Build and run web version with emrun
web-run:
	@echo "Building and running web version..."
	@make kill-emrun 2>/dev/null || true
	zig build -Dtarget=wasm32-emscripten run

# Clean build artifacts
clean:
	rm -rf zig-out .zig-cache

# Kill active emrun processes
kill-emrun:
	@pkill -f emrun || echo "No active emrun processes"
