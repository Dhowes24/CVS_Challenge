//
//  CVS_ChallengeTests.swift
//  CVS_ChallengeTests
//
//  Created by Derek Howes on 7/13/24.
//

import XCTest
@testable import CVS_Challenge

final class SearchViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequestSuccess() async throws {
        let jsonData = """
        {
            "items": [
                {
                    "title": "Whitsunday spiny anteater Echidna Tachyglossus sp aff aculeatus Tachyglossidae Mandalay rainforest Airlie Beach",
                    "link": "https://www.flickr.com/photos/72842252@N04/53849534118/",
                    "media": {"m": "https://live.staticflickr.com/65535/53849534118_9e3fe73e8f_m.jpg"},
                    "description": "Mock Description",
                    "published": "2024-07-11T06:47:56Z"
                },
                {
                    "title": "Have You Ever Watched a Porcupine Yawn?",
                    "link": "https://www.flickr.com/photos/mtsofan/53807460358/",
                    "media": {"m": "https://live.staticflickr.com/65535/53807460358_8f3f7bdbb1_m.jpg"},
                    "description": "Mock Description",
                    "published": "2024-06-22T01:31:00Z"
                }
            ]
        }
        """.data(using: .utf8)!

        
        let mockNetworkManager = MockNetworkManager(data: jsonData)
        let searchViewModel =  await SearchViewModel(networkManager: mockNetworkManager)
        
        try await searchViewModel.fetchImages()
        
        let images = await searchViewModel.imageList
        XCTAssertEqual(images.count, 2)
        XCTAssertEqual(images[0].published, "2024-07-11T06:47:56Z")
        XCTAssertEqual(images[1].published, "2024-06-22T01:31:00Z")
    }
    
    
    func testRquestError() async throws {
        let mockNetworkManager = MockNetworkManager(error: NetworkError.invalidResponse)
        
        let searchViewModel =  await SearchViewModel(networkManager: mockNetworkManager)

        do {
            _ = try await searchViewModel.fetchImages()
            XCTFail("Expected request to throw an error")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        }
    }
}
