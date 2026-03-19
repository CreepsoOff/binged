//
//  searchActor.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct SearchActorView: View {
    @State private var searchText = ""
    @Environment(ActorViewModel.self) private var vmActor
    
    @State private var listActors: [CastMember] = []
    
    var user: User
    
    var filteredActors: [CastMember] {
        if searchText.isEmpty {
            return listActors
        }
        return listActors.filter { actor in
            actor.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            
            ScrollView(showsIndicators: false) {
                let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
                
                LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                    ForEach(filteredActors, id: \.id) { actor in
                        NavigationLink {
                            ActorProfileView(actor: actor)
                        } label: {
                            ActorBar(actor: actor)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .task {
            // 1. On synchronise d'abord avec les données locales du User
            self.listActors = user.favoriteActorsSafe
            
            // 2. Si la liste est vide mais qu'on a des IDs, on charge le reste
            if self.listActors.isEmpty, let ids = user.favoriteActorIDs {
                for actorID in ids {
                    do {
                        let fetchedActor = try await vmActor.getActorById(actorID)
                        // On vérifie qu'on ne l'ajoute pas deux fois
                        if !listActors.contains(where: { $0.name == fetchedActor.name }) {
                            self.listActors.append(fetchedActor)
                        }
                    } catch {
                        print("Erreur Airtable Actor: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    SearchActorView(user: MockData.magalie)
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
