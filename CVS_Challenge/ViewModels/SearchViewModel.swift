//
//  SearchViewModel.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Combine
import Foundation
import SwiftUI

@MainActor class SearchViewModel: ObservableObject {
    @Published var loadComplete: Bool = false
    @Published var imageList: [Item] = []
    @Published var orientation = UIDeviceOrientation.unknown
    @Published var path = NavigationPath()
    @Published var textInput: String = ""
    @Published var toggle: Bool = true

    private var cancellables = Set<AnyCancellable>()
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
        setupSubscribers()
        fetchImagesTask()
    }
    
    
    func fetchImages() async throws {
        loadComplete = false
        let baseUrl = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
        let searchString = baseUrl + textInput
        
        let responses = try await networkManager.request(searchString, resultType: Results.self)
        self.imageList = responses.items
        loadComplete = true
    }
    
    
    func fetchImagesTask() {
        Task {
            do {
                try await self.fetchImages()
            } catch {
                print("Error while fetching images: \(error)")
            }
        }
    }
    
    
    private func setupSubscribers() {
        $textInput
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                //Checking for loadComplete so fetch isn't run on initiation
                if loadComplete {
                    fetchImagesTask()
                }
            }
            .store(in: &cancellables)
    }
}
