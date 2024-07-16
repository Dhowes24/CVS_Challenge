//
//  SearchView.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel = SearchViewModel()
    
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack {
                SearchHeader(
                    textInput: $viewModel.textInput,
                    toggle: $viewModel.toggle
                ).padding(.top, viewModel.orientation.isLandscape ? 20 : 0)
                
                if viewModel.imageList.isEmpty && viewModel.loadComplete {
                    ZeroResultsDisplay()
                } else {
                    SearchResultsItems(
                        imageList: viewModel.imageList,
                        toggle: viewModel.toggle,
                        path: $viewModel.path
                    )
                }
            }
            .navigationDestination(for: Item.self) { item in
                    DetailsView(item: item)
            }
            .onRotate { newOrientation in
                viewModel.orientation = newOrientation
            }
        }
    }
}


#Preview {
    SearchView()
}
