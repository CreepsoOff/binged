//
//  sfButton.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct SFButton: View {
    
    var icon: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
        }
                .padding(8)
                .background(.orange)
                .cornerRadius(20)
                .foregroundColor(.background)
    }
}

#Preview {
    SFButton(icon: "play.fill")
}
