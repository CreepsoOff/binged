//
//  SFButton.swift
//  binged
//
//  Created by Apprenant 105 on 17/03/2026.
//

import SwiftUI

struct SFButton: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .padding(8)
            .background(.orange, in: .rect(cornerRadius: 20))
            .foregroundStyle(Color.background)
    }
}

#Preview {
    SFButton(icon: "play.fill")
}
