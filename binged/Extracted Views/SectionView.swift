import SwiftUI

struct SectionView: View {
    let title: String
    let isEmpty: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .bold()
                .foregroundStyle(.white)
                .padding(.horizontal)
            
            if isEmpty {
                Text("Rien à afficher pour le moment.")
                    .font(.caption)
                    .italic()
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack {
        Design.bgColor.ignoresSafeArea()
        
        VStack(spacing: 40) {
            SectionView(title: "Section Vide", isEmpty: true)
            
            VStack(alignment: .leading) {
                SectionView(title: "Séries en cours", isEmpty: false)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Design.accentColor)
                            .frame(width: 120, height: 160)
                            .overlay(Text("Série 1").bold())
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Design.innerCardColor)
                            .frame(width: 120, height: 160)
                            .overlay(Text("Série 2").bold())
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
