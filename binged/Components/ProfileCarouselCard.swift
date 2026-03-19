import SwiftUI

struct ProfileCarouselCard: View {
    let serie: Serie
    let isCenter: Bool
    let isLeft: Bool
    
    var body: some View {
        ZStack {
            if let url = serie.cover?.first?.thumbnails?.large?.url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Rectangle().fill(Color.gray.opacity(0.3))
            }
            
            if !isCenter {
                Color.black.opacity(0.4)
                
                Image(systemName: isLeft ? "chevron.left" : "chevron.right")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white.opacity(0.8))
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
        }
        .frame(width: isCenter ? 220 : 160, height: isCenter ? 320 : 240)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: isCenter ? 15 : 5)
        .zIndex(isCenter ? 1 : 0)
    }
}
