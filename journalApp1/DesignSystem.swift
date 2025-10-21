//
//  DesignSystem.swift
//  journalApp1
//
//  Created by Joumana Alsagheir on 19/10/2025.
//
import SwiftUI

enum DS {
    static let corner: CGFloat = 20
    static let padding: CGFloat = 16
    static let accent: Color = .purple
}

extension Date {
    var shortString: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f.string(from: self)
    }
}

extension View {
    func titleStyle() -> some View {
        font(.system(.largeTitle, design: .rounded).bold())
            .foregroundStyle(.white)
    }
}

