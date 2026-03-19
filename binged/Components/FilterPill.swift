import SwiftUI

struct FilterPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(isSelected ? Color("background") : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.white : Color.white.opacity(0.1))
                .clipShape(Capsule())
                .overlay(Capsule().stroke(isSelected ? Color.white : Color.gray.opacity(0.3), lineWidth: 1))
        }
    }
}
