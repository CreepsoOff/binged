//
//  actorBar.swift
//  binged
//
//  Created by Apprenant 92 on 06/03/2026.
//

import SwiftUI

struct ActorBar: View {
    var actor: CastMember
    
    var body: some View {
        HStack{
            VStack{
                if let url = actor.imageName.first??.thumbnails?.large?.url {
                    AsyncImage(url: url) { image in
                        image
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
                    } placeholder: {
                        ProgressView()
                    }
//                    .frame(width: 200, height: 100)
                }else {
                    Image(systemName : "person.crop.circle")
                        .font(.system(size: 100))
                }
                
                    
                Text(actor.name)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
        }
    }
}

#Preview {
    ActorBar(actor: MockData.bryanCranston)
}
