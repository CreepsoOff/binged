import SwiftUI

struct RangeSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>
    
    @State private var sliderWidth: CGFloat = 0
    
    init(range: Binding<ClosedRange<Double>>, in bounds: ClosedRange<Double>) {
        self._range = range
        self.bounds = bounds
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(.white.opacity(0.15))
                .frame(height: 6)
            
            Capsule()
                .fill(Design.accentColor)
                .frame(width: max(0, maxX - minX), height: 6)
                .offset(x: minX)
            
            // Curseur Gauche
            SliderThumbView(
                offsetX: minX,
                triggerValue: Int(range.lowerBound),
                onDrag: { location in updateRange(x: location.x, isLeft: true) }
            )
            
            // Curseur Droit
            SliderThumbView(
                offsetX: maxX,
                triggerValue: Int(range.upperBound),
                onDrag: { location in updateRange(x: location.x, isLeft: false) }
            )
        }
        .frame(height: 30)
        .onGeometryChange(for: CGFloat.self) { proxy in
            proxy.size.width
        } action: { width in
            sliderWidth = width
        }
    }
    
    
    private var minX: CGFloat {
        guard sliderWidth > 0 else { return 0 }
        let pct = (range.lowerBound - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
        return sliderWidth * CGFloat(pct)
    }
    
    private var maxX: CGFloat {
        guard sliderWidth > 0 else { return 0 }
        let pct = (range.upperBound - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
        return sliderWidth * CGFloat(pct)
    }
    
    private func updateRange(x: CGFloat, isLeft: Bool) {
        guard sliderWidth > 0 else { return }
        let pct = max(0, min(1, x / sliderWidth))
        let newValue = bounds.lowerBound + (Double(pct) * (bounds.upperBound - bounds.lowerBound))
        
        if isLeft {
            range = min(newValue, range.upperBound - 1)...range.upperBound
        } else {
            range = range.lowerBound...max(newValue, range.lowerBound + 1)
        }
    }
}
