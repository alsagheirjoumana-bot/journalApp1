//
//  Untitled.swift.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//
import SwiftUI

struct EditorView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var working: JournalEntry
    var onSave: (JournalEntry) -> Void
    @State private var showDiscardConfirm = false

    init(entry: JournalEntry, onSave: @escaping (JournalEntry) -> Void) {
        _working = State(initialValue: entry)
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                TextField("Title", text: $working.title)
                    .font(.title2.bold())
                    .padding(.horizontal)
                    .padding(.top)

                Text(working.date.shortString)
                    .font(.caption).foregroundStyle(.gray)
                    .padding(.horizontal)

                Divider().background(Color.white.opacity(0.1))

                TextEditor(text: $working.body)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal)
                    .frame(minHeight: 240)

                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { showDiscardConfirm = true } label: { Image(systemName: "xmark") }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        onSave(working)
                        dismiss()
                    } label: { Image(systemName: "checkmark") }
                }
            }
            .confirmationDialog(
                "Are you sure you want to discard changes on this journal?",
                isPresented: $showDiscardConfirm,
                titleVisibility: .visible
            ) {
                Button("Discard Changes", role: .destructive) { dismiss() }
                Button("Keep Editing", role: .cancel) { }
            }
            .navigationTitle(working.title.isEmpty ? "New Journal" : "Edit Journal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#if DEBUG
#Preview { EditorView(entry: JournalEntry(title: "", body: "")) { _ in } }
#endif
