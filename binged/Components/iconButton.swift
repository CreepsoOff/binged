//
//  iconButton.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//

import SwiftUI

struct iconButton: View {
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
        .cornerRadius(20)
        .foregroundColor(.background)
    }
}

#Preview {
    iconButton(text: "trailer", icon: "play.fill")
}
