import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 15

    @Published var items: [ParkingCharge] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("parkingspend_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: ParkingCharge) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: ParkingCharge) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: ParkingCharge) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([ParkingCharge].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [ParkingCharge] {
        [
        ParkingCharge(date: Date().addingTimeInterval(-86400), location: "Downtown Garage", amount: "12.00", note: "Meeting"),
        ParkingCharge(date: Date().addingTimeInterval(-172800), location: "Airport Lot", amount: "45.00", note: "Weekend trip"),
        ParkingCharge(date: Date().addingTimeInterval(-259200), location: "Bridge Toll", amount: "6.50", note: "Commute")
        ]
    }
}
