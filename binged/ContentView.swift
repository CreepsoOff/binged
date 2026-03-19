//
//  ContentView.swift
//  binged
//

import SwiftUI

struct ContentView: View {
    @State private var userVM = UserViewModel()
    @State private var serieVM = SerieViewModels()
    @State private var playlistVM = PlayListViewModel()
    @State private var actorVM = ActorViewModel()
    
    @State private var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        Group {
            if !hasCompletedOnboarding {
                OnboardingView {
                    withAnimation {
                        hasCompletedOnboarding = true
                    }
                }
            } else if let user = userVM.currentUser {
                TabView {
                    SeriesListView()
                        .tabItem {
                            Label("Séries", systemImage: "tv")
                        }
                    
                    GlobalSearchView()
                        .tabItem {
                            Label("Recherche", systemImage: "magnifyingglass")
                        }
                    
                    CalendarView()
                        .tabItem {
                            Label("Calendrier", systemImage: "calendar")
                        }
                    
                    MyProfile(userConnected: user)
                        .tabItem {
                            Label("Profil", systemImage: "person.fill")
                        }
                }
                .environment(serieVM)
                .environment(userVM)
                .environment(playlistVM)
                .environment(actorVM)
            } else {
                ProgressView("Chargement de votre session...")
                    .task {
                        do {
                            // On récupère l'utilisateur par défaut (Magalie Piquet) et on l'assigne au ViewModel
                            userVM.currentUser = try await userVM.getUserById("rec279AxVMVJ5GrPQ")
                        } catch {
                            print("Erreur initialisation session: \(error)")
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
