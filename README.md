# Brink Mind

A native iOS app for journaling, AI conversation, and biometric insights.

## Screenshots

*Coming soon*

## Features

### Five Core Tabs

| Tab | View | Purpose |
|-----|------|---------|
| Chat | `MainChatView` | AI-powered conversations about your journal and health |
| Journal | `JournalView` | Daily entries with prompts and tagging |
| Home | `HomeView` | Dashboard overview |
| Health | `DashboardView` | Biometric data visualization |
| Settings | `SettingsView` | Themes, privacy, notifications, profile |

### Journaling System

- **Prompt-driven entries** — CSV-loaded prompts or defaults like "What made you smile today?"
- **Rich tagging** — Categories: Mood, Sleep, Activity, Health, Custom
- **Health metrics attached** — Each entry can include biometric data from the time of writing
- **Core Data persistence** — Entries stored locally with full offline support

### HealthKit Integration

Fetches and analyzes five biometric categories:

| Metric | Fetcher | Analysis |
|--------|---------|----------|
| Heart Rate | `HeartRateFetcher` | Resting, active, trends |
| Steps | `StepCountFetcher` | Daily totals, patterns |
| Exercise Minutes | `ExerciseMinutesFetcher` | Activity tracking |
| HRV | `HRVFetcher` | Heart rate variability for stress/recovery |
| Sleep | `SleepFetcher` | Duration, quality analysis |

### Theming

9 built-in themes with full color system:

- **System** — Follows device setting
- **Light / Dark** — Standard modes
- **Harper** — Sage green
- **Darcy** — Soft lavender
- **Shay** — Ocean blue
- **Kit** — Warm rose
- **Zephyr** — Mint teal
- **Aspen** — Earthy tan

Each theme defines: primary, secondary, tertiary, quaternary, quinary colors + computed background gradients.

### Privacy & Security

- **Keychain storage** — API keys stored via `SwiftKeychainWrapper`
- **Local-first** — Journal data stays on device (Core Data)
- **Permission managers** — Granular control for Health, Audio, Calendar, Notifications

## Architecture

```
brink/
├── brinkApp.swift              # App entry, environment setup
├── Models/
│   ├── JournalModels.swift     # JournalEntry, Tag, PersistenceController
│   ├── ChatModels.swift        # Message types, animation config
│   ├── ThemeModels.swift       # BrinkThemeColors, 9 theme definitions
│   ├── HealthModels.swift      # Health data structures
│   └── UserModel.swift         # User state
├── Views/
│   ├── Journal/                # JournalView, entry creation
│   ├── Chat/                   # AI conversation UI
│   └── Settings/               # Settings rows, theme picker
├── ViewModels/
│   ├── Journal/                # JournalViewModel, NewJournalEntryViewModel
│   └── Settings/               # Theme, Privacy, Notification, Profile VMs
├── Services/
│   ├── API/                    # APIKeyManager (Keychain)
│   ├── Chat/                   # ChatInteractorProtocol, KeyboardObserver
│   ├── HealthKit/              # HealthDataManager, fetchers, analysis
│   ├── Journal/                # Core Data model, voice service
│   ├── Messaging/              # ResponseParser
│   └── Permissions/            # Health, Audio, Calendar, Notification managers
├── Managers/
│   └── PromptManager.swift     # CSV-loaded journal prompts
├── Navigation/
│   └── MainTabView.swift       # Tab bar with 5 tabs
└── Extensions/
    ├── Color+Extension.swift   # Hex color init
    └── View+Extension.swift    # View modifiers
```

## Tech Stack

| Layer | Technology |
|-------|------------|
| UI | SwiftUI |
| Data | Core Data |
| Health | HealthKit |
| Security | SwiftKeychainWrapper |
| Chat | ExyteChat |
| Architecture | MVVM |
| Min iOS | 17.0 |

## Setup

1. Clone the repo
2. Open `brink.xcodeproj` in Xcode
3. Configure signing team
4. Build and run

### HealthKit Entitlements

The app requires HealthKit capabilities. Ensure your provisioning profile includes:
- `com.apple.developer.healthkit`
- `com.apple.developer.healthkit.background-delivery`

## Stats

- **39 Swift files**
- **~3,400 lines of code**
- **5 HealthKit fetchers**
- **9 color themes**
- **4 permission managers**

## Note

This is the open-sourced iOS frontend. Backend is not included.

## Author

**Aria Han** — [github.com/ariaxhan](https://github.com/ariaxhan)

Originally created at Brink Labs (2024).

## License

MIT
