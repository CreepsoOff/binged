import SwiftUI

struct LiveSeriesListPreview: View {
    @State private var viewModel = SerieViewModels()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                        Text("Récupération séries")
                            .foregroundStyle(.secondary)
                    }
                } else if viewModel.series.isEmpty {
                    Text("Aucune série trouvée")
                        .foregroundStyle(.secondary)
                } else {
                    List(viewModel.series) { serie in
                        NavigationLink {
                            SeriesDetailView(serie: serie)
                        } label: {
                            HStack(spacing: 12) {
                                if let url = serie.cover?.first?.thumbnails?.large?.url {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 45, height: 65)
                                    .clipShape(.rect(cornerRadius: 6))
                                } else {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Design.cardColor)
                                        .frame(width: 45, height: 65)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(serie.name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)

                                    Text("\(String(serie.year)) • \(serie.genre.rawValue)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Séries")
        }
        .environment(viewModel) // ✅ Super important pour la preview du DetailView
        .task {
            do {
                try await viewModel.fetchLightSeries() // 💡 J'ai mis fetchLightSeries pour que la Preview aille plus vite !
            } catch {
                print("Erreur Preview Séries: \(error)")
            }
        }
    }
}
