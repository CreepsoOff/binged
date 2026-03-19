import SwiftUI

struct SliderThumbView: View {
    let offsetX: CGFloat
    let triggerValue: Int
    let onDrag: (CGPoint) -> Void
    
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 28, height: 28)
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            .offset(x: offsetX - 14)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        onDrag(value.location)
                    }
            )
            // Vibration légère quand on change l'année
            .sensoryFeedback(.selection, trigger: triggerValue)
    }
}
