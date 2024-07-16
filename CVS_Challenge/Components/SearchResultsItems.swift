//
//  SearchResultsItems.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/15/24.
//

import SwiftUI

struct SearchResultsItems: View {
    var imageList: [Item]
    var toggle: Bool
    @Binding var path: NavigationPath
    
    
    var body: some View {
        if toggle {
            List(imageList, id: \.self) { image in
                HStack {
                    Spacer()
                    
                    FlickerImage(imageURL: image.mediaURL)
                        .onTapGesture {
                            withAnimation {
                                path.append(image)
                            }
                        }
                    
                    Spacer()
                }
            }
            .padding(.top, 20)
        } else {
            ScrollView {
                LazyVGrid(columns: gridViewColumns, spacing: 20) {
                    ForEach(imageList, id:\.self) {image in
                        FlickerImage(imageURL: image.mediaURL, dimensions: gridImageDimension)
                            .onTapGesture {
                                path.append(image)
                            }
                    }
                }
                .padding(.vertical, 20)
                .background(content: {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color(UIColor.secondarySystemBackground))
                })
            }
            .padding(20)
        }
    }
}


#Preview {
    SearchResultsItems(imageList: [Item.mock, Item.mock], toggle: true, path: .constant(NavigationPath()))
}
