import Foundation

struct ParkingCharge: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var location: String
    var amount: String
    var note: String
}
