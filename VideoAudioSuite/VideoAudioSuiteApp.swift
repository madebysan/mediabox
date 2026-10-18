import Sparkle
import SwiftUI

@main
struct VideoAudioSuiteApp: App {
    @StateObject private var appState = AppState()

    init() {
        Updates.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .frame(minWidth: 500, minHeight: 400)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(after: .appInfo) {
                Button("Check for Updates…") {
                    Updates.controller.checkForUpdates(nil)
                }
            }
        }
    }
}

// In-app updates. The feed lives on the repo's GitHub Releases (Info.plist
// SUFeedURL). Started only from a bundle that has a feed URL.
enum Updates {
    static let controller = SPUStandardUpdaterController(
        startingUpdater: false, updaterDelegate: nil, userDriverDelegate: nil
    )

    static func start() {
        if Bundle.main.object(forInfoDictionaryKey: "SUFeedURL") != nil {
            controller.startUpdater()
        }
    }
}
