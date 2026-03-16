//
//  CalendarView.swift
//  binged
//
//  Created by apprenant85 on 16/03/2026.
//


import SwiftUI

struct CalendarView: View {
    let events: [CalendarEvent] = MockData.calendarMocks
    
    var body: some View {
        NavigationStack {
            ZStack {
                Design.bgColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        SectionView(title: "Prochaines Sorties", isEmpty: events.isEmpty)
                        
                        ForEach(events) { event in
                            NavigationLink {
                                if let serie = event.serie {
                                    SeriesDetailView(serie: serie)
                                }
                            } label: {
                                CalendarRow(event: event)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Calendrier")
                        .toolbarBackground(.hidden, for: .navigationBar)
                    }
                    .preferredColorScheme(.dark)
            
        
    }
    
 
}



#Preview {
    CalendarView()
        .environment(SerieViewModels())
}
