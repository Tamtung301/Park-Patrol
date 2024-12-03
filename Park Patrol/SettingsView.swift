import SwiftUI

struct SettingsView: View {
    @State private var theme: Theme = .system
    @State private var notificationsEnabled = true
    @State private var soundEnabled = true
    @State private var vibrationEnabled = true

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Form {
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $theme) {
                        Text("Light").tag(Theme.light)
                        Text("Dark").tag(Theme.dark)
                        Text("System Default").tag(Theme.system)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: theme) { newTheme, _ in
                        applyTheme(newTheme)
                    }
                }

                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Toggle("Sound", isOn: $soundEnabled)
                    Toggle("Vibration", isOn: $vibrationEnabled)
                }
            }
        }
    }

    private func applyTheme(_ theme: Theme) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            switch theme {
            case .light:
                keyWindow.overrideUserInterfaceStyle = .light  // Fixed
            case .dark:
                keyWindow.overrideUserInterfaceStyle = .dark   // Fixed
            case .system:
                keyWindow.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}

enum Theme: String, CaseIterable, Identifiable {
    case light, dark, system

    var id: String { rawValue }
}
