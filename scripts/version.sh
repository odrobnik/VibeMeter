#!/bin/bash

# Version Management Script for VibeMeter
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Usage function
usage() {
    echo "Usage: $0 [OPTIONS] [VERSION]"
    echo ""
    echo "Manage VibeMeter version numbers and prepare releases"
    echo ""
    echo "OPTIONS:"
    echo "  --major              Bump major version (e.g., 0.9.1 -> 1.0.0)"
    echo "  --minor              Bump minor version (e.g., 0.9.1 -> 0.10.0)"
    echo "  --patch              Bump patch version (e.g., 0.9.1 -> 0.9.2)"
    echo "  --prerelease TYPE    Create pre-release version (TYPE: alpha, beta, rc)"
    echo "  --build              Bump build number only"
    echo "  --set VERSION        Set specific version (e.g., 1.0.0)"
    echo "  --current            Show current version"
    echo "  --help               Show this help message"
    echo ""
    echo "EXAMPLES:"
    echo "  $0 --current                 # Show current version"
    echo "  $0 --patch                   # 0.9.1 -> 0.9.2"
    echo "  $0 --minor                   # 0.9.1 -> 0.10.0"
    echo "  $0 --major                   # 0.9.1 -> 1.0.0"
    echo "  $0 --prerelease beta         # 0.9.2 -> 0.9.2-beta.1"
    echo "  $0 --build                   # Increment build number"
    echo "  $0 --set 1.0.0               # Set to specific version"
    echo ""
    echo "WORKFLOW:"
    echo "  1. Use this script to bump version"
    echo "  2. Commit the version changes"
    echo "  3. Use ./scripts/release.sh to create the release"
    echo ""
}

# Get current version from Project.swift
get_current_version() {
    grep 'MARKETING_VERSION' "$PROJECT_ROOT/Project.swift" | sed 's/.*"MARKETING_VERSION": "\(.*\)".*/\1/'
}

# Get current build number from Project.swift
get_current_build() {
    grep 'CURRENT_PROJECT_VERSION' "$PROJECT_ROOT/Project.swift" | sed 's/.*"CURRENT_PROJECT_VERSION": "\(.*\)".*/\1/'
}

# Update version in Project.swift
update_project_version() {
    local new_version="$1"
    local new_build="$2"
    
    # Create backup
    cp "$PROJECT_ROOT/Project.swift" "$PROJECT_ROOT/Project.swift.bak"
    
    # Update marketing version
    sed -i '' "s/\"MARKETING_VERSION\": \".*\"/\"MARKETING_VERSION\": \"$new_version\"/" "$PROJECT_ROOT/Project.swift"
    
    # Update build number
    sed -i '' "s/\"CURRENT_PROJECT_VERSION\": \".*\"/\"CURRENT_PROJECT_VERSION\": \"$new_build\"/" "$PROJECT_ROOT/Project.swift"
    
    echo "✅ Updated Project.swift:"
    echo "   Version: $new_version"
    echo "   Build: $new_build"
}

# Parse semantic version
parse_version() {
    local version="$1"
    echo "$version" | grep -oE '^[0-9]+\.[0-9]+\.[0-9]+' || {
        echo "❌ Invalid version format: $version"
        echo "Expected format: X.Y.Z (e.g., 1.0.0)"
        exit 1
    }
}

# Increment version component
increment_version() {
    local version="$1"
    local component="$2"  # major, minor, patch
    
    local major minor patch
    IFS='.' read -r major minor patch <<< "$version"
    
    case "$component" in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
        *)
            echo "❌ Invalid component: $component"
            exit 1
            ;;
    esac
    
    echo "$major.$minor.$patch"
}

# Create pre-release version
create_prerelease_version() {
    local base_version="$1"
    local prerelease_type="$2"
    
    # Validate pre-release type
    case "$prerelease_type" in
        alpha|beta|rc)
            ;;
        *)
            echo "❌ Invalid pre-release type: $prerelease_type"
            echo "Valid types: alpha, beta, rc"
            exit 1
            ;;
    esac
    
    # Check if base version already has pre-release suffix
    if [[ "$base_version" =~ -[a-z]+\.[0-9]+$ ]]; then
        # Extract the pre-release number and increment it
        local base_part="${base_version%-*}"
        local prerelease_part="${base_version##*-}"
        local current_type="${prerelease_part%.*}"
        local current_number="${prerelease_part##*.}"
        
        if [[ "$current_type" == "$prerelease_type" ]]; then
            # Same type, increment number
            local new_number=$((current_number + 1))
            echo "$base_part-$prerelease_type.$new_number"
        else
            # Different type, start at 1
            echo "$base_part-$prerelease_type.1"
        fi
    else
        # No pre-release suffix, add one
        echo "$base_version-$prerelease_type.1"
    fi
}

# Main script logic
main() {
    local action=""
    local prerelease_type=""
    local new_version=""
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --major|--minor|--patch|--build)
                action="${1#--}"
                shift
                ;;
            --prerelease)
                action="prerelease"
                if [[ $# -lt 2 ]]; then
                    echo "❌ --prerelease requires TYPE argument"
                    usage
                    exit 1
                fi
                prerelease_type="$2"
                shift 2
                ;;
            --set)
                action="set"
                if [[ $# -lt 2 ]]; then
                    echo "❌ --set requires VERSION argument"
                    usage
                    exit 1
                fi
                new_version="$2"
                shift 2
                ;;
            --current)
                action="current"
                shift
                ;;
            --help)
                usage
                exit 0
                ;;
            *)
                echo "❌ Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Get current version info
    local current_version
    local current_build
    current_version=$(get_current_version)
    current_build=$(get_current_build)
    
    echo "🏷️  VibeMeter Version Management"
    echo "📦 Current version: $current_version"
    echo "🔢 Current build: $current_build"
    echo ""
    
    # Handle actions
    case "$action" in
        current)
            echo "✅ Current version: $current_version (build $current_build)"
            exit 0
            ;;
        major|minor|patch)
            # Parse current version (remove any pre-release suffix)
            local base_version
            base_version=$(parse_version "$current_version")
            new_version=$(increment_version "$base_version" "$action")
            local new_build=$((current_build + 1))
            ;;
        prerelease)
            new_version=$(create_prerelease_version "$current_version" "$prerelease_type")
            local new_build=$((current_build + 1))
            ;;
        build)
            new_version="$current_version"
            local new_build=$((current_build + 1))
            ;;
        set)
            # Validate the provided version
            parse_version "$new_version" > /dev/null
            local new_build=$((current_build + 1))
            ;;
        "")
            echo "❌ No action specified"
            usage
            exit 1
            ;;
        *)
            echo "❌ Unknown action: $action"
            usage
            exit 1
            ;;
    esac
    
    # Confirm the change
    echo "📝 Proposed changes:"
    echo "   Version: $current_version -> $new_version"
    echo "   Build: $current_build -> $new_build"
    echo ""
    read -p "Continue? (y/N): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Aborted"
        exit 1
    fi
    
    # Apply the changes
    update_project_version "$new_version" "$new_build"
    
    echo ""
    echo "✅ Version updated successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Review the changes: git diff Project.swift"
    echo "   2. Commit the version bump: git add Project.swift && git commit -m \"Bump version to $new_version\""
    echo "   3. Create the release: ./scripts/release.sh --stable"
    if [[ "$new_version" =~ -[a-z]+\.[0-9]+$ ]]; then
        echo "   3. Create the pre-release: ./scripts/release.sh --prerelease ${prerelease_type} ${new_version##*.}"
    fi
    echo ""
}

# Validate Project.swift exists
if [[ ! -f "$PROJECT_ROOT/Project.swift" ]]; then
    echo "❌ Project.swift not found in $PROJECT_ROOT"
    exit 1
fi

# Run main function
main "$@"