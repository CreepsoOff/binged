//
//  searchBar.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Recherche...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchBar(text: .constant("Genre"))
}
