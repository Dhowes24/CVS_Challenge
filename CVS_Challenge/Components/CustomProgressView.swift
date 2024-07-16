//
//  CustomProgressView.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import SwiftUI


struct CustomProgressView: View {
    let width: CGFloat
    let height: CGFloat
    
    init(width: CGFloat = 300, height: CGFloat = 300) {
        self.width = width
        self.height = height
    }
    
    
    var body: some View {
        ProgressView()
            .frame(width: width, height: height)
            .clipped()
            .background(.gray)
    }
}


#Preview {
    CustomProgressView()
}
