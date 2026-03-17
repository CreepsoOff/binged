//
//  actorBar.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct actorBar: View {
    var actor: CastMember
    
    var body: some View {
        HStack{
            VStack{
                Image(actor.imageName ?? "netflix_icon")
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
                Text(actor.name)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
        }
    }
}
