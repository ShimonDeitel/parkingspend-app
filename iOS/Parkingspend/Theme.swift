import SwiftUI

enum Theme {
    static let background = Color(red: 0.051, green: 0.090, blue: 0.090)
    static let accent = Color(red: 0.243, green: 0.486, blue: 0.486)
    static let accent2 = Color(red: 0.851, green: 0.482, blue: 0.290)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
