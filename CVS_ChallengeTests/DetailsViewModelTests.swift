//
//  DetailsViewModelTests.swift
//  CVS_ChallengeTests
//
//  Created by Derek Howes on 7/14/24.
//

import XCTest
@testable import CVS_Challenge

final class DetailsViewModelTests: XCTestCase {
    
    var testViewModel: DetailsViewModel!
    
    
    @MainActor override func setUpWithError() throws {
        super.setUp()
        testViewModel = DetailsViewModel(item: Item.mock)
    }

    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    @MainActor func testConvertDateString_Success() {
        // Given
        let rawString = "2024-07-11T06:47:56Z"
        
        // When
        let convertedString = testViewModel.convertDateString(rawString)
        
        // Then
        XCTAssertTrue(convertedString == "Jul 11, 2024 at 2:47:56 AM")
    }
    
    
    @MainActor func testConvertDateString_Invalid() {
        // Given
        let rawString = "2024-07-11T06:47:5000Z"
        
        // When
        let convertedString = testViewModel.convertDateString(rawString)
        
        // Then
        XCTAssertTrue(convertedString == "Invalid date format.")
    }
    
    
    @MainActor func testExtractDimensions_Success() {
        
        for _ in 1...5 {
            // Given
            let width = Int.random(in: 100..<1000)
            let height = Int.random(in: 100..<1000)
            let description =
        """
        data with full dimensions width="\(width)" height="\(height)"
        """
            
            // When
            let extractedDimensions = testViewModel.extractDimensions(description)
            
            // Then
            XCTAssertTrue(extractedDimensions == (width, height))
        }
    }
    
    
    @MainActor func testExtractDimensions_NoData() {
        // Given
        let description =
            """
            Data without dimensions
            """
        
        // When
        let extractedDimensions = testViewModel.extractDimensions(description)
        
        // Then
        print(extractedDimensions)
        XCTAssertTrue(extractedDimensions == (-1, -1))
    }
    
    
    @MainActor func testExtractDimensions_PartialData() {
        // Given
        let width = Int.random(in: 100..<1000)
        let description =
            """
            Data with partial dimensions width="\(width)"
            """
        
        // When
        let extractedDimensions = testViewModel.extractDimensions(description)
        
        // Then
        XCTAssertTrue(extractedDimensions == (-1, -1))
    }
    
    
    @MainActor func testTrimTitle_LongString() {
        //Given
        let originalString = "Long string that is over 20 chars"
        
        //When
        let titles = testViewModel.trimTitle(originalString)
        
        //Then
        XCTAssertFalse(titles.short == titles.long)
        XCTAssertTrue(titles.short.count == 20)
    }
    
    
    @MainActor func testTrimTitle_ShortString() {
        //Given
        let originalString = "Short Title String"
        let originalStringWithWhitespace = "Short Title String                              "
        
        //When
        let titles = testViewModel.trimTitle(originalString)
        let whitespaceTitles = testViewModel.trimTitle(originalStringWithWhitespace)

        
        //Then
        XCTAssertTrue(titles.short == titles.long)
        XCTAssertTrue(titles.short.count < 20)
        
        XCTAssertTrue(whitespaceTitles.short == whitespaceTitles.long)
        XCTAssertTrue(whitespaceTitles.short.count < 20)
    }
    
    
    @MainActor func testTrimTitle_EmptyString() {
        //Given
        let originalString = "  "
        let LongWhitespaceString = "                     "

        //When
        let titles = testViewModel.trimTitle(originalString)
        let longWhitespaceTitles = testViewModel.trimTitle(LongWhitespaceString)
        
        //Then
        XCTAssertTrue(titles.short == "Untitled")
        XCTAssertTrue(titles.short == titles.long)
        
        XCTAssertTrue(longWhitespaceTitles.short == "Untitled")
        XCTAssertTrue(longWhitespaceTitles.short == longWhitespaceTitles.long)
    }
}
