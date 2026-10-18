# Developing Mediabox

Building, tests, project structure, adding an operation and contributing. The short version is the [README](../README.md).

## Building from source

Open in Xcode:

```bash
open VideoAudioSuite.xcodeproj
```

Then build and run with **Cmd+R**.

Or build from the command line:

```bash
xcodebuild build \
  -project VideoAudioSuite.xcodeproj \
  -scheme VideoAudioSuite \
  -configuration Debug \
  -destination 'platform=macOS'
```

The built app will be named "Mediabox".

## Running tests

The project includes unit tests and UI tests covering operation logic, state management, and UI flow.

Run all tests:

```bash
xcodebuild test \
  -project VideoAudioSuite.xcodeproj \
  -scheme VideoAudioSuite \
  -destination 'platform=macOS'
```

Run unit tests only:

```bash
xcodebuild test \
  -project VideoAudioSuite.xcodeproj \
  -scheme VideoAudioSuite \
  -destination 'platform=macOS' \
  -only-testing:VideoAudioSuiteTests
```

Run UI tests only:

```bash
xcodebuild test \
  -project VideoAudioSuite.xcodeproj \
  -scheme VideoAudioSuite \
  -destination 'platform=macOS' \
  -only-testing:VideoAudioSuiteUITests
```

## Project structure

```
VideoAudioSuite/
├── VideoAudioSuiteApp.swift       # App entry point
├── ContentView.swift              # Main view router
├── Models/
│   ├── AppState.swift             # App state, batch file management
│   ├── BatchFile.swift            # File with selection/status
│   ├── FavoritesStore.swift       # Favorites persistence
│   ├── MediaFile.swift            # File representation
│   └── Operation.swift            # Operations & categories
├── Views/
│   ├── MainWorkspaceView.swift    # Three-panel layout
│   ├── FileListPanel.swift        # Left: file list with checkboxes
│   ├── OperationPanel.swift       # Middle: operations + search
│   ├── OperationListView.swift    # Flat operation list with stars
│   ├── OperationConfigView.swift  # Config UI components
│   ├── QueueBarView.swift         # Bottom: queue status + Process
│   ├── BatchProcessingView.swift  # Progress during batch
│   ├── BatchCompletionView.swift  # Results summary
│   └── CompletionView.swift       # Legacy completion view
└── Services/
    ├── FFmpegService.swift        # ffmpeg execution
    ├── OperationExecutor.swift    # Operation logic & config
    └── BatchExecutor.swift        # Sequential batch processing
```

## Adding an operation

1. **`Operation.swift`**: Add a case to the `Operation` enum, update `name`, `description`, `outputSuffix`, `requiresSecondFile`, `requiresConfiguration`
2. **`OperationCategory`**: Add to the appropriate category's `operations(for:)` method
3. **`OperationExecutor.swift`**: Add config properties to `OperationConfig` if needed, add a case to `buildArguments`
4. **`OperationConfigView.swift`**: Add a case to the switch, create a config UI component

## Contributing

Contributions are welcome! Here's how:

1. Fork the repository
2. Create a feature branch (`git checkout -b my-feature`)
3. Make your changes
4. Run the tests to make sure nothing is broken
5. Commit and push to your fork
6. Open a pull request

Please keep changes focused: one feature or fix per PR.
