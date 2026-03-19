//
//  PlaylistBar.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct PlaylistBar: View {
    
    @State private var isAdd = false
    var playlist: Playlist
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Titre de la Playlist
            HStack {
                Text(playlist.name)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .padding(.horizontal, 16)
                
                Spacer()
                
                Button(action: {
                    isAdd.toggle()
                }) {
                    Image(systemName: isAdd ? "minus" : "plus")
                        .font(.system(size: 14, weight: .bold))
                        .padding(8)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.trailing, 16)
            }
            
            // ScrollView des Séries
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    if let series = playlist.series, !series.isEmpty {
                        ForEach(series) { serie in
                            NavigationLink {
                                SeriesDetailView(serie: serie)
                            } label: {
                                VStack(alignment: .leading) {
                                    if let url = serie.cover?.first?.thumbnails?.large?.url {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ZStack {
                                                Color.gray.opacity(0.2)
                                                ProgressView().tint(.white)
                                            }
                                        }
                                        .frame(width: 110, height: 160)
                                        .clipped()
                                        .cornerRadius(12)
                                    } else {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 110, height: 160)
                                            .overlay(
                                                Text(serie.name)
                                                    .font(.caption2)
                                                    .bold()
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .padding(4)
                                            )
                                    }
                                }
                                .contentShape(Rectangle()) // Force la zone de clic
                            }
                            .buttonStyle(PlainButtonStyle()) // Évite les effets de sélection bleus par défaut
                        }
                    } else {
                        // Placeholder si la playlist est vide ou en cours de chargement
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.05))
                                .frame(width: 110, height: 160)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
