//
//  JournalListView.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//
import SwiftUI

// MARK: - 🗒 JournalListView (Main page)
struct JournalListView: View {
    @EnvironmentObject var vm: JournalViewModel
    @State private var showNew = false
    @State private var search = ""

    // Sketch accent color
    private let lavender = Color(red: 0.74, green: 0.69, blue: 1.0)

    // Search filtering
    private var filtered: [JournalEntry] {
        let q = search.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return vm.entries }
        return vm.entries.filter { e in
            e.title.lowercased().contains(q) || e.body.lowercased().contains(q)
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // ===== TOP BAR =====
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Spacer()

                    LiquidGlassPill(
                        onFilter: {},                    // hook up later
                        onAdd: { showNew = true }        // open editor
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 8)

                // ===== CONTENT =====
                if filtered.isEmpty {
                    Spacer(minLength: 24)
                    VStack(spacing: 16) {
                        Image("emptyBook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)

                        Text("Begin Your Journal")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(lavender)

                        Text("Craft your personal diary, tap the\nplus icon to begin")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)
                    }
                    .padding(.horizontal, 32)
                    Spacer(minLength: 24)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 14) {
                            ForEach(filtered) { entry in
                                JournalRowView(
                                    entry: entry,
                                    onBookmark: { vm.toggleBookmark(for: entry) }
                                )
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        vm.delete(entry)
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 80) // room for the search bar
                        }
                    }
                }
            }

            // ===== BOTTOM SEARCH =====
            VStack {
                Spacer()
                LiquidGlassSearchBar(text: $search)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
            }
        }
        // ===== NEW ENTRY SHEET =====
        .sheet(isPresented: $showNew) {
            let draft = JournalEntry(title: "", body: "")
            EditorView(entry: draft) { updated in
                vm.add(title: updated.title, body: updated.body)
            }
            .presentationDetents([.large])
        }
    }
}

#Preview {
    // Preview with a few sample cards
    let vm = JournalViewModel()
    vm.loadMock([
        JournalEntry(date: .now, title: "My Birthday", body: lorem, bookmarked: true),
        JournalEntry(date: .now, title: "Today’s Journal", body: lorem, bookmarked: false),
        JournalEntry(date: .now, title: "Great Day", body: lorem, bookmarked: false),
    ])
    return JournalListView().environmentObject(vm)
}

private let lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non.
"""
