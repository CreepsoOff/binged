//
//  ContentView.swift
//  binged
//
//  Created by apprenant85 on 04/03/2026.
//

import SwiftUI

struct ContentView: View {
    let comedy = GenreType.comedy
//    comedy.isFavorite? = true
    var body: some View {
        VStack {
            Image(systemName: GenreType.sf.iconName)
                .font(.system(size: 120))
                .foregroundStyle(.tint)
            Text(GenreType.sf.rawValue)
                .font(.system(size: 80))
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
