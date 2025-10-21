//
//  EmptyStateView.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//

import SwiftUI

struct EmptyStateView: View {
    @EnvironmentObject var vm: JournalViewModel
    @State private var showingNew = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                HStack { Text("Journal").titleStyle(); Spacer() }
                    .padding(.horizontal)

                Spacer()

                Image("emptyBook")
                    .resizable().scaledToFit()
                    .frame(width: 140, height: 140)

                VStack(spacing: 6) {
                    Text("Begin Your Journal").font(.headline).foregroundStyle(DS.accent)
                    Text("Craft your personal diary, tap the plus icon to begin")
                        .font(.subheadline).foregroundStyle(.gray)
                }

                Spacer()
            }

            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search").foregroundStyle(.gray)
                    Spacer()
                    Image(systemName: "mic")
                }
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .padding(.leading)

                Button { showingNew = true } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .padding(.trailing)
            }
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $showingNew) {
            var draft = JournalEntry(title: "", body: "")
            EditorView(entry: draft) { updated in
                vm.insert(updated)
            }
            .presentationDetents([.large])
        }
    }
}

#if DEBUG
#Preview { EmptyStateView().environmentObject(JournalViewModel()) }
#endif
