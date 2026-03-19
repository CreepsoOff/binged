//
//  Logo.swift
//  binged
//
//  Created by Apprenant 92 on 11/03/2026.
//

import SwiftUI

struct Logo: View {
    var attachments: [Attachment]?
    
    var body: some View {
        if let url = attachments?.first?.thumbnails?.large?.url {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 32, height: 32)
            .background(.white)
            .clipShape(Circle())
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.white, lineWidth: 1)
            )
        } else {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 32, height: 32)
        }
    }
}

#Preview {
    ZStack {
        Design.bgColor.ignoresSafeArea()
        Logo(attachments: [MockData.mockAttachment])
    }
}
