//
//  DetailsView.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: DetailsViewModel
    
    init(item: Item) {
        viewModel = DetailsViewModel(item: item)
    }
    
    
    var body: some View {
        VStack {
            HStack {
                SFSymbols.backArrow
                    .onTapGesture {
                        dismiss()
                    }
                    .accessibilityLabel(Text("Return to Search Page"))
                
                Spacer()
                
                if let url = viewModel.link {
                    ShareLink(item: url) {
                        SFSymbols.shareButton
                    }
                } else {
                    SFSymbols.shareError
                }
            }
            
            ScrollView {
                VStack (alignment: .leading, spacing: 20) {
                    VStack(alignment: .center, spacing: 10) {
                        HStack(alignment: .bottom) {
                            Text(viewModel.showTitleBool ? viewModel.longTitle : viewModel.shortTitle)
                                .font(.custom("Georgia", size: 40, relativeTo: .headline))
                            
                            Spacer()
                        }
                        
                        HStack() {
                            Spacer()
                            
                            if (viewModel.shortTitle != viewModel.longTitle) {
                                Text(viewModel.showTitleBool ? "Less" : "More")
                                    .font(.custom("Georgia", size: 18, relativeTo: .headline))
                                    .foregroundStyle(.blue)
                                    .onTapGesture {
                                        withAnimation {
                                            viewModel.showTitleBool.toggle()
                                        }
                                    }
                            }
                        }
                        
                        FlickerImage(imageURL: viewModel.imageUrl)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Picture Dimensions:")
                            .fontWeight(.bold)
                        
                        if (viewModel.pictureWidth > 0) {
                            Text("\(viewModel.pictureWidth)w X \(viewModel.pictureHeight)h")
                                .accessibilityLabel(Text("\(viewModel.pictureWidth) Width by \(viewModel.pictureHeight) Height"))
                        } else {
                            Text("Dimensions Unavailable")
                        }
                    }
                    .font(.custom("Georgia", size: 20, relativeTo: .headline))
                    
                    VStack(alignment: .leading) {
                        Text("Time Published:")
                            .fontWeight(.bold)
                        
                        Text(viewModel.publishedDate)
                    }
                    .font(.custom("Georgia", size: 20, relativeTo: .headline))
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
        .toolbar(.hidden, for: .navigationBar)
    }
}


#Preview {
    DetailsView(item: Item.mock)
}
