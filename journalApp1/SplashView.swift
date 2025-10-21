//
//  SplashView.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var showHome = false
    @State private var appear = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 0.04, green: 0.04, blue: 0.08),
                    Color(red: 0.09, green: 0.09, blue: 0.12)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Logo + titles
            VStack(spacing: 12) {
                Image("book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .opacity(appear ? 1 : 0)
                    .scaleEffect(appear ? 1 : 0.92)
                    .animation(.easeOut(duration: 0.55), value: appear)

                Text("Journali")
                    .font(.system(.largeTitle, design: .rounded).bold())
                    .foregroundColor(.white)
                    .opacity(appear ? 1 : 0)
                    .offset(y: appear ? 0 : 8)
                    .animation(.easeOut(duration: 0.6).delay(0.08), value: appear)

                Text("Your thoughts, your story")
                    .font(.subheadline)
                    .foregroundColor(.white) // pure white text
                    .opacity(appear ? 1 : 0)
                    .offset(y: appear ? 0 : 10)
                    .animation(.easeOut(duration: 0.6).delay(0.16), value: appear)
            }
        }
        .statusBar(hidden: true)
        .task {
            appear = true
            try? await Task.sleep(nanoseconds: 1_200_000_000) // 1.2s
            withAnimation(.easeInOut(duration: 0.45)) { showHome = true }
        }
        .fullScreenCover(isPresented: $showHome) {
            JournalListView()
        }
    }
}

#if DEBUG
#Preview {
    SplashView()
        .environmentObject(JournalViewModel.mock)
}
#endif
