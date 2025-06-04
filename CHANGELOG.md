# Changelog

All notable changes to VibeMeter will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0-beta1] - 2025-06-04

### 🎯 Major Changes
- **Multi-provider architecture** - Ready for future AI service integrations beyond Cursor
- **Advanced settings section** - New dedicated tab for power user features
- **Editable spending limits** - Customize warning and upper limit thresholds directly in settings

### ✨ New Features
- **Update channels** - Choose between stable releases or beta/pre-release versions
- **Spending limits editor** - Set custom warning ($150.50) and upper limit ($800.75) thresholds
- **Reset to defaults** - Quick reset button for spending limits
- **Improved organization** - Settings reorganized with new Advanced tab

### 🐛 Bug Fixes
- **Fixed Cursor API compatibility** - Updated to handle both camelCase and snake_case field formats
- **Fixed cached data on account switch** - Spending data now properly clears when logging out
- **Fixed decimal spending limits** - Proper support for non-integer limit values
- **Fixed build warnings** - Resolved all compilation warnings and improved code quality

### 🔧 Technical Improvements
- **Swift 6 compliance** - Full compatibility with strict concurrency checking
- **Component-based architecture** - Improved separation of concerns with specialized managers
- **Enhanced error handling** - Better resilience for API format changes
- **Improved settings persistence** - More reliable storage of user preferences

### 📝 Known Issues
- Team accounts may show individual pricing instead of team-specific rates
- Usage limits are retrieved from Cursor API but spending limits are user-defined

## [0.9.1] - 2025-06-04

### 🐛 Bug Fixes
- **Fixed Sparkle EdDSA signature generation** - Corrected update-appcast.sh script to properly embed signatures
- **Improved release automation** - Fixed GitHub release creation workflow

### 🔧 Technical Improvements
- **Build scripts** - Enhanced error handling and reliability in release scripts
- **Sparkle integration** - Ensured proper EdDSA signature format in appcast.xml

## [0.9.0] - 2025-06-04

### 🎉 Initial Release

Vibe Meter is a beautiful, native macOS menu bar app that helps you track your monthly AI spending.

### ✨ Features
- **Real-time spending tracking** for Cursor AI
- **Multi-currency support** with 20+ currencies
- **Smart notifications** when approaching spending limits
- **Animated gauge icon** showing spending progress
- **Secure authentication** via official web login
- **Auto-updates** with EdDSA signature verification

### 🏗️ Built With
- Swift 6 with strict concurrency
- Modern SwiftUI and AppKit
- Multi-provider architecture (ready for future AI services)
- Notarized by Apple for security

---

## 🚀 Getting Started

1. **Download** VibeMeter from [GitHub Releases](https://github.com/steipete/VibeMeter/releases)
2. **Install** by dragging to your Applications folder
3. **Launch** and follow the setup guide
4. **Configure** your spending preferences in Settings

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/steipete/VibeMeter/issues)
- **Twitter**: [@steipete](https://twitter.com/steipete)
- **Blog**: [Development Story](https://steipete.com/posts/vibemeter/)

---

**Thank you for using VibeMeter! 🎉**

We're excited to help you track your AI spending efficiently and beautifully. If you enjoy the app, please consider starring the repository and sharing it with others who might find it useful.

**Made with ❤️ in Vienna, Austria**