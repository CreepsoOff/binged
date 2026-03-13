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
                    .frame(width: 75, height: 75)
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
                    .font(.system(size: 16))
                Text(actor.actorLastName)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
        }
    }
}

#Preview {
    actorBar(actor: actors[0])
}
