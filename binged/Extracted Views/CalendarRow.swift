//
//  CalendarRow.swift
//  binged
//
//  Created by apprenant85 on 16/03/2026.
//

import SwiftUI

struct CalendarRow: View{
    
    let event: CalendarEvent
    var body: some View {
        HStack(spacing: 15) {
            VStack {
                Text(event.date.formatTo("dd"))
                    .font(.title2)
                    .bold()
                Text(event.date.formatTo("MMM").uppercased())
                    .font(.caption2)
                    .fontWeight(.heavy)
            }
            .foregroundStyle(.black)
            .frame(width: 60, height: 60)
            .background(Design.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.serie?.name ?? "Série inconnue")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(event.episodeName)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.6))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.3))
        }
        .padding()
        .background(Design.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

#Preview {
    CalendarRow(event: CalendarEvent(episodeName: "S01E02 - La bagarre", date: Date()))
}
