//
//  GlassBackground.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//
import SwiftUI

struct GlassBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)                 // current SDK-safe
                    .overlay(                                  // subtle rim highlight
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.white.opacity(0.10), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 6)
            )
    }
}

extension View {
    func glassCard() -> some View { modifier(GlassBackground()) }
}
