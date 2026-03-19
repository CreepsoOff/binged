import SwiftUI

struct SingleActorPreview: View {
    @State private var viewModel = SerieViewModels()
    @State private var liveActor: CastMember?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Design.bgColor.ignoresSafeArea()
                
                // 3. Affichage conditionnel
                if let actor = liveActor {
                    // On injecte l'environnement pour que la vue puisse faire ses propres fetchs (les séries de l'acteur)
                    ActorProfileView(actor: actor)
                        .environment(viewModel)
                } else {
                    VStack(spacing: 16) {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5)
                        Text("Téléchargement de l'acteur...")
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
            }
        }
        // 4. Le fameux .task pour le FetchByID !
        .task {
            do {
                // Remplace par n'importe quel ID "rec..." d'acteur de ta base Airtable (ici Aaron Paul)
                let targetID = "recNqCTo2Rdq9gzAT"
                self.liveActor = try await viewModel.getActorById(targetID)
            } catch {
                print("Erreur de chargement dans la Preview : \(error)")
            }
        }
    }
}
