//
//  searchActor.swift
//  binged
//
//  Created by Apprenant 92 on 16/03/2026.
//

import SwiftUI

struct SearchActorView: View {
    @State private var searchActor = ""
    @State var vmActor = ActorViewModel()
    @State var listActors = [Actor]()
    var user: User
    
    var filteredActors: [Actor] {
        if searchActor.isEmpty {
            return listActors
        }
        return listActors.filter {
            $0.actorName.localizedCaseInsensitiveContains(searchActor)
        }
    }
    var body: some View {
        VStack{
        searchBar(text: $searchActor)
            ScrollView(showsIndicators: false) {
                    ForEach(filteredActors, id: \.actorName) { actor in
                        actorBar(actor: actor)
                    }
            }
        }.task {
            if !user.favoriteActor.isEmpty{
                for actorID in user.favoriteActor{
                    do {
                        self.listActors.append( try await vmActor.getActorById(actorID))
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    SearchActorView(user: magalie)
}
