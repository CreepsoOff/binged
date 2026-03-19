import SwiftUI

struct SerieRowCard: View {
    let serie: Serie
    
    var body: some View {
        HStack(spacing: 15) {
            // Affiche
            if let url = serie.cover?.first?.thumbnails?.large?.url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 70, height: 100)
                .clipShape(.rect(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Design.cardColor)
                    .frame(width: 70, height: 100)
                    .overlay(Image(systemName: "tv").foregroundStyle(.gray))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(serie.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .lineLimit(2)

                Text("\(String(serie.year)) • \(serie.genre.rawValue)")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
                
                if serie.inProgress == true {
                    Text("EN COURS")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(Design.accentColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Design.accentColor.opacity(0.15))
                        .clipShape(Capsule())
                }
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .padding(10)
        .background(Design.cardColor)
        .clipShape(.rect(cornerRadius: 12))
    }
}
