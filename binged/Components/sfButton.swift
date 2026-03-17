//
//  sfButton.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct sfButton: View {
    
    var icon: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
        }
                .padding(8)
                .background(.orange)
                .cornerRadius(20)
                .foregroundColor(.white)
    }
}

#Preview {
    sfButton(icon: "play.fill")
}
