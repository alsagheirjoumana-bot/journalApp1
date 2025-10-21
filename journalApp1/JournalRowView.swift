//
//  Untitled.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 20/10/2025.
//

import SwiftUI

/// A single journal card styled like the Sketch (glass card + bookmark).
struct JournalRowView: View {
    let entry: JournalEntry
    var onBookmark: () -> Void

    private let corner: CGFloat = 18
    private let lavender = Color(red: 0.74, green: 0.69, blue: 1.0)

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.title.isEmpty ? "Untitled" : entry.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(lavender)

                    Text(entry.dateFormatted)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }

                Text(entry.body.isEmpty ? " " : entry.body)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
            .background(GlassCard(cornerRadius: corner))

            // Bookmark
            Button(action: onBookmark) {
                Image(systemName: entry.bookmarked ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.95))
                    .padding(10)
            }
            .buttonStyle(.plain)
        }
    }
}

private extension JournalEntry {
    var dateFormatted: String {
        let f = DateFormatter()
        f.dateFormat = "dd/MM/yyyy"
        return f.string(from: date)
    }
}

/// Liquid-glass card background (matte glass + rim + inner shadow)
struct GlassCard: View {
    var cornerRadius: CGFloat

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        return ZStack {
            shape.fill(Color.black.opacity(0.40)) // base
            shape.fill(
                LinearGradient(
                    colors: [.white.opacity(0.06), .white.opacity(0.02)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            )
            shape.stroke(Color.white.opacity(0.08), lineWidth: 1) // outer rim

            // inner shadow at bottom
            shape
                .stroke(Color.black.opacity(0.55), lineWidth: 3)
                .blur(radius: 4)
                .offset(y: 2)
                .mask(shape)

            // soft top glare band
            shape
                .stroke(
                    LinearGradient(
                        colors: [Color.white.opacity(0.14), .clear],
                        startPoint: .top, endPoint: .center
                    ),
                    lineWidth: 1
                )
                .blur(radius: 0.6)
        }
        .shadow(color: .black.opacity(0.55), radius: 12, x: 0, y: 8)
    }
}
