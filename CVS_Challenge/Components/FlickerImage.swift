//
//  FlickerImage.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import SwiftUI


struct FlickerImage: View {
    let imageURL: String
    let dimensions: CGFloat
    
    init(imageURL: String, dimensions: CGFloat = 300) {
        self.imageURL = imageURL
        self.dimensions = dimensions
    }
    
    
    var body: some View {
        AsyncImage(
            url: URL(string: imageURL),
            content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: dimensions, height: dimensions)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25.0)
                    )
            },
            placeholder: {
                CustomProgressView(width: dimensions, height: dimensions)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25.0)
                    )
            }
        )
        .frame( height: dimensions)
    }
}


#Preview {
    FlickerImage(
        imageURL: "https://live.staticflickr.com//65535//53849534118_9e3fe73e8f_m.jpg"
    )
}
