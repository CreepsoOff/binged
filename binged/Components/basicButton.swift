//
//  basicButton.swift
//  binged
//
//  Created by Apprenant 92 on 10/03/2026.
//

import SwiftUI

struct basicButton: View {
    var text: String
    
    var body: some View {
        HStack{
            Text(text)
        }
                .padding(8)
                .background(.orange)
                .cornerRadius(20)
                .foregroundColor(.background)
    }
}

#Preview {
    basicButton(text: "trailer")
}
