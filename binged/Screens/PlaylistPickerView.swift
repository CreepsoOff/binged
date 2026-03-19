import SwiftUI

struct PlaylistPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(PlayListViewModel.self) private var vmplaylist
    @Environment(SerieViewModels.self) private var vmSerie
    @Environment(UserViewModel.self) private var userVM
    
    let serie: Serie
    @Binding var user: User
    
    @State private var listPlRecords: [PlaylistRecord] = []
    @State private var currentSerieRecordId: String? = nil
    @State private var isLoading = true
    @State private var showNewPlaylistAlert = false
    @State private var newPlaylistName = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fond principal
                Design.bgColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    if isLoading {
                        VStack(spacing: 12) {
                            ProgressView()
                                .tint(Design.accentColor)
                            Text("Chargement...")
                                .foregroundStyle(.white.opacity(0.7))
                        }
                    } else {
                        List {
                            Section {
                                Button {
                                    showNewPlaylistAlert = true
                                } label: {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                        Text("Nouvelle Playlist")
                                            .bold()
                                    }
                                    .foregroundStyle(Design.accentColor)
                                }
                            }
                            .listRowBackground(Design.cardColor)
                            
                            Section {
                                ForEach(listPlRecords, id: \.id) { record in
                                    let isIncluded = record.fields.serieIDs?.contains(currentSerieRecordId ?? "") ?? false
                                    
                                    Button {
                                        togglePlaylist(record)
                                    } label: {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(record.fields.name)
                                                    .foregroundStyle(.white)
                                                    .font(.headline)
                                                Text("\(record.fields.serieIDs?.count ?? 0) séries")
                                                    .font(.caption)
                                                    .foregroundStyle(.white.opacity(0.5))
                                            }
                                            Spacer()
                                            if isIncluded {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .font(.title3)
                                                    .foregroundStyle(Design.accentColor) // Orange pur
                                            } else {
                                                Image(systemName: "circle")
                                                    .font(.title3)
                                                    .foregroundStyle(.white.opacity(0.2))
                                            }
                                        }
                                    }
                                }
                            } header: {
                                Text("Ajouter à...")
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .bold()
                                    .textCase(nil)
                            }
                            .listRowBackground(Design.cardColor)
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden) // Très important pour ne pas voir le gris système
                        .background(Design.bgColor) // Assure que le fond de la liste est le bon
                    }
                }
            }
            .navigationTitle("Gérer les Playlists")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Terminer") { dismiss() }
                        .foregroundStyle(Design.accentColor)
                        .bold()
                }
            }
            .alert("Nouvelle Playlist", isPresented: $showNewPlaylistAlert) {
                TextField("Nom de la playlist", text: $newPlaylistName)
                Button("Annuler", role: .cancel) { newPlaylistName = "" }
                Button("Créer") { createNewPlaylist() }
            } message: {
                Text("Donnez un titre à votre nouvelle sélection.")
            }
        }
        .preferredColorScheme(.dark) // Force le mode sombre pour éviter les variations de gris
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        isLoading = true
        self.currentSerieRecordId = await vmplaylist.fetchSerieRecordId(named: serie.name)
        
        if let playlistIDs = user.playlistIDs {
            var fetched: [PlaylistRecord] = []
            for plid in playlistIDs {
                if let p = try? await fetchPlaylistRecord(id: plid) {
                    fetched.append(p)
                }
            }
            self.listPlRecords = fetched
        }
        isLoading = false
    }
    
    private func fetchPlaylistRecord(id: String) async throws -> PlaylistRecord {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Playlist/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(Secrets.airtableAPIKey)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(PlaylistRecord.self, from: data)
    }
    
    private func togglePlaylist(_ record: PlaylistRecord) {
        guard let sid = currentSerieRecordId else { return }
        
        var serieIDs = record.fields.serieIDs ?? []
        if serieIDs.contains(sid) {
            serieIDs.removeAll { $0 == sid }
        } else {
            serieIDs.append(sid)
        }
        
        Task {
            do {
                try await vmplaylist.updatePlaylistSeries(playlistID: record.id, seriesIDs: serieIDs)
                await loadData()
            } catch {
                print("Erreur update: \(error)")
            }
        }
    }
    
    private func createNewPlaylist() {
        guard !newPlaylistName.isEmpty, let sid = currentSerieRecordId else { return }
        
        Task {
            do {
                try await vmplaylist.createPlaylist(name: newPlaylistName, creatorID: "rec279AxVMVJ5GrPQ", serieID: sid)
                newPlaylistName = ""
                await loadData()
            } catch {
                print("Erreur création: \(error)")
            }
        }
    }
}

#Preview {
    PlaylistPickerView(serie: MockData.breakingBad, user: .constant(MockData.magalie))
        .environment(PlayListViewModel())
        .environment(SerieViewModels())
        .environment(UserViewModel())
}
