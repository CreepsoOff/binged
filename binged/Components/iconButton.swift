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
            HStack{
                Image(systemName: icon)
                Text(text)
            }
                    .padding(8)
                    .background(.orange)
                    .cornerRadius(20)
                    .foregroundColor(.white)
        }
    }

#Preview {
    iconButton(text: "trailer", icon: "play.fill")
}
