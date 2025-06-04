# Vibe Meter

A beautiful, native macOS menu bar application that helps you track your monthly AI spending with real-time monitoring and smart notifications.

<!-- CI Status: Build and Test -->


## ✨ Features

- **📊 Real-time Spending Tracking** - Monitor your AI service costs directly from your menu bar
- **🔄 Multi-Provider Support** - Currently supports Cursor AI with extensible architecture for future services
- **💰 Multi-Currency Support** - View spending in USD, EUR, GBP, JPY, and 20+ other currencies
- **🔔 Smart Notifications** - Customizable spending limit alerts to keep you on budget
- **🎨 Animated Gauge Display** - Beautiful visual indicator showing spending progress
- **🔐 Secure Authentication** - Safe login via provider's official web authentication
- **⚡ Lightweight & Native** - Built with Swift 6, optimized for performance and battery life
- **🔄 Auto-Updates** - Secure automatic updates with EdDSA signature verification
- **🌓 Dark Mode Support** - Seamlessly adapts to your system appearance
- **🖱️ Right-Click Menu** - Quick access to settings and actions via context menu
- **📊 Enhanced UI** - Professional cost table with centered icons and full-width progress bars

## 🚀 Quick Start

1. **Download Vibe Meter** from the [latest release](https://github.com/steipete/VibeMeter/releases)
2. **Install** by dragging Vibe Meter.app to your Applications folder
3. **Launch** and click the menu bar icon to get started
4. **Login** to your Cursor AI account when prompted
5. **Configure** spending limits and currency preferences in Settings

## 📋 Requirements

- **macOS 15.0** or later (Sequoia)
- **Cursor AI account** (free or paid)
- **Internet connection** for real-time data sync

## 🎯 How It Works

Vibe Meter connects securely to your Cursor AI account and monitors your monthly usage:

- **Automatic Sync** - Updates spending data every 5 minutes
- **Visual Indicators** - Gauge fills up as you approach your spending limits
- **Progress Notifications** - Alerts at 80% and 100% of your warning threshold
- **Currency Conversion** - Real-time exchange rates for accurate international tracking

## ⚙️ Configuration

### Spending Limits
- **Warning Limit** - Get notified when you reach 80% (default: $20)
- **Upper Limit** - Maximum threshold for visual indicators (default: $30)

### Display Options
- **Show Cost in Menu Bar** - Toggle cost display next to the icon
- **Currency Selection** - Choose from 20+ supported currencies
- **Notification Preferences** - Customize alert frequency and triggers

## 🛠️ Development

Want to contribute? Vibe Meter is built with modern Swift technologies:

### Tech Stack
- **Swift 6** with strict concurrency
- **SwiftUI** for settings and UI components
- **AppKit** for menu bar integration
- **@Observable** for reactive data flow
- **Tuist** for project generation

### Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/steipete/VibeMeter.git
   cd VibeMeter
   ```

2. **Install Tuist:**
   ```bash
   curl -Ls https://install.tuist.io | bash
   ```

3. **Generate and open project:**
   ```bash
   ./scripts/generate-xcproj.sh
   ```

4. **Build and run:**
   - Open `VibeMeter.xcworkspace` in Xcode
   - Select the VibeMeter scheme and press ⌘R

### Key Commands

```bash
# Code formatting
./scripts/format.sh

# Linting
./scripts/lint.sh

# Run tests
xcodebuild -workspace VibeMeter.xcworkspace -scheme VibeMeter -configuration Debug test

# Build release
./scripts/build.sh
```

## 🚀 Release Management

VibeMeter uses a sophisticated release system supporting both stable and pre-release versions with automatic updates.

### Release Types

- **🟢 Stable Releases** - Production-ready versions for all users
- **🟡 Pre-releases** - Beta, alpha, and release candidate versions for early testing
- **⚙️ Update Channels** - Users can choose between stable-only or include pre-releases

### Creating Releases

#### Version Management

Use the version management script to bump versions:

```bash
# Show current version
./scripts/version.sh --current

# Bump version types
./scripts/version.sh --patch        # 0.9.1 -> 0.9.2
./scripts/version.sh --minor        # 0.9.1 -> 0.10.0  
./scripts/version.sh --major        # 0.9.1 -> 1.0.0

# Create pre-release versions
./scripts/version.sh --prerelease beta    # 0.9.2 -> 0.9.2-beta.1
./scripts/version.sh --prerelease alpha   # 0.9.2 -> 0.9.2-alpha.1
./scripts/version.sh --prerelease rc      # 0.9.2 -> 0.9.2-rc.1

# Set specific version
./scripts/version.sh --set 1.0.0

# Bump build number only
./scripts/version.sh --build
```

#### Creating Releases

Use the universal release script:

```bash
# Create stable release
./scripts/release.sh --stable

# Create pre-releases  
./scripts/release.sh --prerelease beta 1     # Creates 0.9.2-beta.1
./scripts/release.sh --prerelease alpha 2    # Creates 0.9.2-alpha.2
./scripts/release.sh --prerelease rc 1       # Creates 0.9.2-rc.1
```

#### Complete Release Workflow

1. **Prepare Release:**
   ```bash
   # Bump version (choose appropriate type)
   ./scripts/version.sh --patch
   
   # Review changes
   git diff Project.swift
   
   # Commit version bump
   git add Project.swift
   git commit -m "Bump version to 0.9.2"
   ```

2. **Create Release:**
   ```bash
   # For stable release
   ./scripts/release.sh --stable
   
   # For pre-release
   ./scripts/release.sh --prerelease beta 1
   ```

3. **Post-Release:**
   ```bash
   # Commit updated appcast files
   git add appcast*.xml
   git commit -m "Update appcast for v0.9.2"
   git push origin main
   ```

### Update Channels

VibeMeter supports two update channels via Sparkle:

- **Stable Only**: Users receive only production-ready releases
- **Include Pre-releases**: Users receive both stable and pre-release versions

Users can switch channels in **Settings → General → Update Channel**.

### Pre-release Testing

Pre-releases are perfect for:

- **🧪 Beta Testing** - Get early access to new features
- **🐛 Bug Reporting** - Help identify issues before stable release  
- **📝 Feedback** - Provide input on new functionality
- **⚡ Early Adoption** - Stay on the cutting edge

To participate:
1. Download VibeMeter
2. Go to Settings → General → Update Channel
3. Select "Include Pre-releases"
4. Check for updates to get the latest pre-release

### Release Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `version.sh` | Version management | `./scripts/version.sh --patch` |
| `release.sh` | Universal release creation | `./scripts/release.sh --stable` |
| `create-github-release.sh` | Stable releases only | `./scripts/create-github-release.sh` |
| `create-prerelease.sh` | Pre-releases only | `./scripts/create-prerelease.sh beta 1` |
| `update-appcast.sh` | Update stable appcast | `./scripts/update-appcast.sh 0.9.2 3 dmg-path` |
| `update-prerelease-appcast.sh` | Update pre-release appcast | `./scripts/update-prerelease-appcast.sh 0.9.2-beta.1 3 dmg-path` |

## 🏗️ Architecture

Vibe Meter follows clean architecture principles:

- **Multi-Provider System** - Extensible design for supporting multiple AI services
- **Reactive State Management** - Modern `@Observable` data flow with SwiftUI integration
- **Service Layer** - Modular services for API clients, authentication, and notifications
- **Protocol-Oriented Design** - Extensive use of protocols for testability and flexibility

## 🔐 Privacy & Security

- **Local Authentication** - Login credentials never stored, uses secure web authentication
- **Encrypted Storage** - Sensitive data protected using macOS Keychain
- **No Tracking** - Vibe Meter doesn't collect any analytics or usage data
- **Secure Updates** - All updates cryptographically signed and verified

## 🤝 Contributing

We welcome contributions! When contributing to Vibe Meter:

- Follow Swift 6 best practices with strict concurrency
- Use the provided formatting script: `./scripts/format.sh`
- Ensure all tests pass before submitting
- Update documentation for significant changes

## 📖 Documentation

- [Architecture Overview](docs/MODERN-ARCHITECTURE.md)
- [Release Process](docs/RELEASE.md)
- [Code Signing Setup](docs/SIGNING-AND-NOTARIZATION.md)
- [CI/CD Pipeline](docs/CI-SETUP.md)

## 🐛 Support

Found a bug or have a feature request?

1. Check [existing issues](https://github.com/steipete/VibeMeter/issues)
2. Create a [new issue](https://github.com/steipete/VibeMeter/issues/new) with details
3. For urgent issues, mention [@steipete](https://twitter.com/steipete) on Twitter

## 🎉 Roadmap

**Current Status (v0.9.x):** Feature-complete beta with Cursor AI support, preparing for v1.0 release

**Version 1.0:**
- Production-ready release with full Cursor AI integration
- Comprehensive testing and stability improvements
- Enhanced error handling and user feedback

**Version 1.x:**
- Additional AI service providers (OpenAI, Anthropic, etc.)
- Enhanced analytics and spending insights
- Team usage tracking for organizations
- Export functionality for financial records

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 👨‍💻 About

Created by [Peter Steinberger](https://steipete.com) ([@steipete](https://twitter.com/steipete))

Read about the development process: [Building a native macOS app with AI](https://steipete.com/posts/vibemeter/)

**Made with ❤️ in Vienna, Austria**