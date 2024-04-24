import SwiftUI
import Swinject

extension StatConfig {
    struct RootView: BaseView {
        let resolver: Resolver
        @StateObject var state = StateModel()

        @Environment(\.colorScheme) var colorScheme
        var color: LinearGradient {
            colorScheme == .dark ? LinearGradient(
                gradient: Gradient(colors: [
                    Color.bgDarkBlue,
                    Color.bgDarkerDarkBlue
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
                :
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
        }

        private var glucoseFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            if state.units == .mmolL {
                formatter.maximumFractionDigits = 1
            }
            formatter.roundingMode = .halfUp
            return formatter
        }

        private var carbsFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            return formatter
        }

        var body: some View {
            Form {
                Section {
                    Toggle("Display Chart X - Grid lines", isOn: $state.xGridLines)
                    Toggle("Display Chart Y - Grid lines", isOn: $state.yGridLines)
                    Toggle("Display Chart Threshold lines for Low and High", isOn: $state.rulerMarks)
                    Toggle("Standing / Laying TIR Chart", isOn: $state.oneDimensionalGraph)
                    Toggle("Enable total insulin in scope", isOn: $state.tins)
                    Picker(
                        selection: $state.loopStatusStyle,
                        label: Text("Loop Status Style")
                    ) {
                        ForEach(LoopStatusStyle.allCases) { selection in
                            Text(selection.displayName).tag(selection)
                        }
                    }
                } header: { Text("Home Chart settings ") }

                Section {
                    HStack {
                        Text("Low")
                        Spacer()
                        DecimalTextField("0", value: $state.low, formatter: glucoseFormatter)
                        Text(state.units.rawValue).foregroundColor(.secondary)
                    }
                    HStack {
                        Text("High")
                        Spacer()
                        DecimalTextField("0", value: $state.high, formatter: glucoseFormatter)
                        Text(state.units.rawValue).foregroundColor(.secondary)
                    }
                    Toggle("Override HbA1c Unit", isOn: $state.overrideHbA1cUnit)

                } header: { Text("Statistics settings ") }

                Section {
                    Toggle("Skip Bolus screen after carbs", isOn: $state.skipBolusScreenAfterCarbs)
                    Toggle("Display and allow Fat and Protein entries", isOn: $state.useFPUconversion)
                } header: { Text("Add Meal View settings ") }

                Section {
                    Picker(
                        selection: $state.historyLayout,
                        label: Text("History Layout")
                    ) {
                        ForEach(HistoryLayout.allCases) { selection in
                            Text(selection.displayName).tag(selection)
                        }
                    }
                } header: { Text("History Settings") }
            }
            .scrollContentBackground(.hidden).background(color)
            .onAppear(perform: configureView)
            .navigationBarTitle("UI/UX")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
