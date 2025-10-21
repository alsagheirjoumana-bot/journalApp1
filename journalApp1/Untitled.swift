//
//  Untitled.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 21/10/2025.
//
import SwiftUI

// Inner shadow helper for molded glass edges
struct InnerShadow<S: Shape>: View {
    var shape: S
    var color: Color = .black
    var lineWidth: CGFloat = 3
    var radius: CGFloat = 4
    var y: CGFloat = 2

    var body: some View {
        shape
            .stroke(color.opacity(0.55), lineWidth: lineWidth)
            .blur(radius: radius)
            .offset(y: y)
            .mask(shape)
    }
}

// Top-right control: Filter + Add inside a sculpted liquid-glass capsule
struct LiquidGlassPill: View {
    var onFilter: () -> Void
    var onAdd: () -> Void

    var body: some View {
        let cap = Capsule(style: .continuous)

        HStack(spacing: 0) {
            Button(action: onFilter) {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.9), radius: 1, y: 1)
                    .frame(width: 56, height: 36)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 1, height: 22)

            Button(action: onAdd) {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.9), radius: 1, y: 1)
                    .frame(width: 56, height: 36)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 4)
        .background(
            ZStack {
                cap.fill(Color.black.opacity(0.40)) // base dark glass
                cap.fill(
                    LinearGradient(
                        colors: [.white.opacity(0.08), .white.opacity(0.02)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                cap.stroke(Color.white.opacity(0.07), lineWidth: 1) // outer rim
                InnerShadow(shape: cap, color: .black, lineWidth: 3, radius: 4, y: 2) // inner depth
                cap
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.17), .clear],
                            startPoint: .top, endPoint: .center
                        ),
                        lineWidth: 1.2
                    )
                    .blur(radius: 0.7) // top glare band
            }
        )
        .clipShape(cap)
        .shadow(color: .black.opacity(0.55), radius: 12, x: 0, y: 8)
    }
}

// Bottom liquid-glass search bar (brightens on focus)
struct LiquidGlassSearchBar: View {
    @Binding var text: String
    @FocusState private var focused: Bool

    var body: some View {
        let cap = Capsule(style: .continuous)

        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundStyle(.white.opacity(0.85))

            TextField("Search", text: $text)
                .foregroundStyle(.white)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($focused)

            Spacer(minLength: 4)

            Image(systemName: "mic.fill")
                .font(.system(size: 16))
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding(.horizontal, 16)
        .frame(height: 46)
        .background(
            ZStack {
                cap.fill(Color.black.opacity(0.36))
                cap.fill(
                    LinearGradient(
                        colors: [
                            .white.opacity(focused ? 0.10 : 0.07),
                            .white.opacity(0.02)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                cap.stroke(Color.white.opacity(0.08), lineWidth: 0.7)
                InnerShadow(shape: cap, color: .black, lineWidth: 3, radius: 4, y: 2)
                cap
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.14), .clear],
                            startPoint: .top, endPoint: .center
                        ),
                        lineWidth: 1.1
                    )
                    .blur(radius: 0.6)
            }
        )
        .clipShape(cap)
        .shadow(color: .black.opacity(0.45), radius: 9, x: 0, y: 6)
        .animation(.easeInOut(duration: 0.22), value: focused)
    }
}

