.PHONY: help \
	dev dev-macos dev-ios dev-android dev-web dev-linux dev-windows \
	build build-macos build-ios build-android build-web build-apk build-appbundle \
	clean clean-all \
	format lint analyze test \
	pub pub-upgrade pub-outdated \
	doctor devices

FLUTTER := flutter
DART := dart

help:
	@echo "Available commands:"
	@echo ""
	@echo "  Development:"
	@echo "    dev           - Run on macOS (default)"
	@echo "    dev-macos     - Run on macOS"
	@echo "    dev-ios       - Run on iOS simulator"
	@echo "    dev-android   - Run on Android emulator"
	@echo "    dev-linux     - Run on Linux"
	@echo "    dev-windows   - Run on Windows"
	@echo ""
	@echo "  Build:"
	@echo "    build         - Build for macOS (default)"
	@echo "    build-macos   - Build for macOS"
	@echo "    build-ios     - Build for iOS"
	@echo "    build-android - Build for Android"
	@echo "    build-apk     - Build Android APK"
	@echo "    build-appbundle - Build Android App Bundle"
	@echo "    build-web     - Build for web"
	@echo ""
	@echo "  Code Quality:"
	@echo "    format        - Format Dart code"
	@echo "    lint          - Analyze code (strict)"
	@echo "    analyze       - Analyze code"
	@echo "    test          - Run tests"
	@echo ""
	@echo "  Dependencies:"
	@echo "    pub           - Get dependencies"
	@echo "    pub-upgrade   - Upgrade dependencies"
	@echo "    pub-outdated  - Check outdated packages"
	@echo ""
	@echo "  Utilities:"
	@echo "    clean         - Clean build artifacts"
	@echo "    clean-all     - Deep clean (clean + pub get)"
	@echo "    doctor        - Run Flutter doctor"
	@echo "    devices       - List available devices"

dev: dev-macos

dev-macos:
	$(FLUTTER) run -d macos

dev-ios:
	$(FLUTTER) run -d ios

dev-android:
	$(FLUTTER) run -d android

dev-linux:
	$(FLUTTER) run -d linux

dev-windows:
	$(FLUTTER) run -d windows

build: build-macos

build-macos:
	$(FLUTTER) build macos

build-ios:
	$(FLUTTER) build ios --no-codesign

build-android:
	$(FLUTTER) build apk

build-apk:
	$(FLUTTER) build apk --release

build-appbundle:
	$(FLUTTER) build appbundle --release

format:
	$(DART) format lib/ test/ --set-exit-if-changed

lint:
	$(FLUTTER) analyze --fatal-infos --fatal-warnings

analyze:
	$(FLUTTER) analyze

test:
	$(FLUTTER) test

test-e2e:
	$(FLUTTER) test test/e2e/editor_test.dart

test-e2e-macos:
	patrol test test/e2e/editor_test.dart --target macos

test-e2e-android:
	patrol test test/e2e/editor_test.dart --target android

test-e2e-all:
	patrol test test/e2e/editor_test.dart

pub:
	$(FLUTTER) pub get

pub-upgrade:
	$(FLUTTER) pub upgrade

pub-outdated:
	$(FLUTTER) pub outdated

clean:
	$(FLUTTER) clean

clean-all:
	$(FLUTTER) clean && $(FLUTTER) pub get

doctor:
	$(FLUTTER) doctor -v

devices:
	$(FLUTTER) devices
