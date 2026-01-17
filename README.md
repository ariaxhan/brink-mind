# Brink Mind

iOS app blending journaling, private AI conversation, and biometric insights.

## Overview

Brink Mind is a mental health app that helps users understand themselves through:

- **Smart Journaling** — AI-powered prompts that adjust to your mood and habits
- **Health & Mood Tracking** — Apple Watch integration for biometric insights
- **AI-Powered Reflection** — Private conversations with AI that understands your journal entries and health data

## Tech Stack

- **Framework**: SwiftUI + Swift 5
- **Data**: Core Data + SwiftKeychainWrapper
- **Health**: HealthKit integration
- **Architecture**: MVVM

## Project Structure

```
brink/
├── Models/              # Data models
├── Views/
│   ├── Journal/         # Journal entry views
│   ├── Chat/            # AI conversation interface
│   └── Settings/        # App settings
├── ViewModels/
│   ├── Journal/         # Journal logic
│   └── Settings/        # Settings logic
├── Services/
│   ├── API/             # Backend communication
│   ├── Chat/            # AI chat service
│   ├── HealthKit/       # Apple Health integration
│   ├── Journal/         # Core Data persistence
│   ├── Messaging/       # Push notifications
│   └── Permissions/     # Permission handling
├── Managers/            # App-wide managers
├── Navigation/          # Navigation coordination
└── Extensions/          # Swift extensions
```

## Features

- Journal entries with AI-powered prompts
- Private AI conversations about your entries
- HealthKit integration for biometric data
- Mood tracking and insights
- Privacy-focused (data stays on device)

## Note

This is the open-sourced iOS frontend. Backend is not included.

## Author

Aria Han — [github.com/ariaxhan](https://github.com/ariaxhan)

Originally created at Brink Labs.

## License

MIT
