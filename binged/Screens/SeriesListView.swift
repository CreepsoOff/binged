import SwiftUI

struct SeriesListView: View {
    @State var vm = SerieViewModels()
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    VStack {
                        ProgressView("Chargement des séries...")
                            .controlSize(.large)
                            .tint(.orange)
                    }
                } else {
                     List(vm.series, id: \.name) { serie in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(serie.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            if !serie.actors.isEmpty {
                                Text("Acteurs :")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                ForEach(serie.actors.compactMap { $0 }) { role in
                                    Text("🎭 \(role.actor?.name ?? "Inconnu") (rôle : \(role.roleName))")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            } else {
                                Text("Aucun acteur trouvé")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Mes Séries")
            .task {
                do {
                    if vm.series.isEmpty {
                        try await vm.fetchSeries()
                    }
                } catch {
                    print("Erreur de chargement : \(error)")
                }
            }
        }
    }
}

#Preview {
    SeriesListView()
}
