//
//  JournalViewModel.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//
import Foundation
import SwiftUI
import Combine

@MainActor
final class JournalViewModel: ObservableObject {
    @Published private(set) var entries: [JournalEntry] = []
    @Published var searchText: String = ""
    @Published var sort: Sort = .byDateDesc

    enum Sort: String, CaseIterable, Identifiable {
        case byDateDesc, bookmarked
        var id: String { rawValue }
    }

    private let saveURL: URL = {
        let fm = FileManager.default
        let docs = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent("journali.json")
    }()

    init() { load() }

    // MARK: - CRUD (public surface)
    func insert(_ entry: JournalEntry) {
        entries.insert(entry, at: 0)
        save()
    }

    func add(title: String = "", body: String = "") {
        insert(JournalEntry(title: title, body: body))
    }

    func update(_ entry: JournalEntry) {
        guard let i = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[i] = entry
        save()
    }

    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        save()
    }

    func delete(_ entry: JournalEntry) {
        guard let i = entries.firstIndex(of: entry) else { return }
        delete(at: IndexSet(integer: i))
    }

    func toggleBookmark(for entry: JournalEntry) {
        guard let i = entries.firstIndex(of: entry) else { return }
        entries[i].isBookmarked.toggle()
        save()
    }

    // MARK: - Persistence
    private func load() {
        do {
            let data = try Data(contentsOf: saveURL)
            entries = try JSONDecoder().decode([JournalEntry].self, from: data)
        } catch {
            entries = [] // first run or load error → start empty
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: saveURL, options: .atomic)
        } catch {
            print("Journali save error:", error)
        }
    }

    // MARK: - Derived+Search
    var filtered: [JournalEntry] {
        let base: [JournalEntry] = (sort == .byDateDesc)
            ? entries.sorted { $0.date > $1.date }
            : entries.filter { $0.isBookmarked }

        guard !searchText.isEmpty else { return base }
        let q = searchText.lowercased()
        return base.filter { $0.title.lowercased().contains(q) || $0.body.lowercased().contains(q) }
    }
}

// MARK: - Previews helpers (same file to access private(set))
#if DEBUG
extension JournalViewModel {
    func loadMock(_ items: [JournalEntry]) { self.entries = items }

    static var mock: JournalViewModel {
        let vm = JournalViewModel()
        vm.loadMock([
            JournalEntry(title: "My Birthday", body: "Cake and friends.", isBookmarked: true),
            JournalEntry(date: .now.addingTimeInterval(-86_400), title: "Today's Journal", body: "Built the list."),
            JournalEntry(date: .now.addingTimeInterval(-172_800), title: "Great Day", body: "Walk + draw.", isBookmarked: true)
        ])
        return vm
    }
}
#endif
