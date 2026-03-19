//
//  CalendarView.swift
//  binged
//
//  Created by apprenant85 on 16/03/2026.
//


import SwiftUI

struct CalendarView: View {
    @Environment(SerieViewModels.self) private var viewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Design.bgColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        SectionView(title: "Prochaines Sorties", isEmpty: viewModel.events.isEmpty)
                        
                        if viewModel.isLoading && viewModel.events.isEmpty {
                            ProgressView("Chargement du calendrier...")
                                .tint(.white)
                                .foregroundStyle(.white)
                                .padding()
                        } else {
                            ForEach(viewModel.events) { event in
                                NavigationLink {
                                    if let serie = event.serie {
                                        SeriesDetailView(serie: serie)
                                    }
                                } label: {
                                    CalendarRow(event: event)
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                .refreshable {
                    do {
                        try await viewModel.fetchCalendarEvents()
                    } catch {
                        print("Erreur refresh calendrier: \(error)")
                    }
                }
            }
            .navigationTitle("Calendrier")
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
        .task {
            do {
                try await viewModel.fetchCalendarEvents()
            } catch {
                print("Erreur chargement calendrier: \(error)")
            }
        }
    }
}

#Preview {
    CalendarView()
        .environment(SerieViewModels())
        .environment(UserViewModel())
        .environment(PlayListViewModel())
        .environment(ActorViewModel())
}
