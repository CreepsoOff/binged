//
//  actorBar.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct actorBar: View {
    var actor: Actor
    
    var body: some View {
        HStack{
            VStack{
                Image(actor.actorImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(
                        radius: 3,
                        x: 5,
                        y: 5
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.white, lineWidth: 1)
                    )
                Text(actor.actorFirstName)
                    .foregroundColor(.white)
                Text(actor.actorLastName)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    actorBar(actor: actors[0])
}
