//
//  ZeroResultsDisplay.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/15/24.
//

import SwiftUI

struct ZeroResultsDisplay: View {
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            SFSymbols.exclamation.fill(colorScheme == .light)
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            Text("Sorry, no results found.")
                .font(.custom("Georgia", size: 30, relativeTo: .headline))
            
            Spacer()
        }
    }
}


#Preview {
    ZeroResultsDisplay()
}
