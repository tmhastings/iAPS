import Foundation

enum LoopStatusStyle: String, JSON, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    case bar
    case circle

    var displayName: String {
        switch self {
        case .bar:
            return NSLocalizedString("Bar", comment: "")
        case .circle:
            return NSLocalizedString("Circle", comment: "")
        }
    }
}
