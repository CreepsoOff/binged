//
//  IconButton.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//

import SwiftUI

struct IconButton: View {
    var text: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 16))
        .padding(8)
        .background(.orange)
        .clipShape(.rect(cornerRadius: 20))
        .foregroundStyle(Color.background)
    }
}

#Preview {
    IconButton(text: "trailer", icon: "play.fill")
}
