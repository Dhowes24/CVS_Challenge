//
//  DetailsViewModel.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Foundation
import SwiftUI

@MainActor class DetailsViewModel: ObservableObject {
    var imageUrl: String
    var link: URL?
    
    var publishedDate: String = ""
    
    var shortTitle: String!
    var longTitle: String!
    @Published var showTitleBool: Bool = false
    
    var pictureWidth: Int!
    var pictureHeight: Int!
    
    
    init(item: Item) {
        self.imageUrl = item.mediaURL
        
        if let url = URL(string: item.link) {
            self.link = url
        } else {
            print("Invalid URL")
        }
        
        self.publishedDate = self.convertDateString(item.published)
        
        let titles = self.trimTitle(item.title)
        self.shortTitle = titles.short
        self.longTitle = titles.long
        
        let dimensions = self.extractDimensions(item.description)
        self.pictureWidth = dimensions.width
        self.pictureHeight = dimensions.height
    }
    
    
    func convertDateString(_ rawDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: rawDate) {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            
            let readableDate = dateFormatter.string(from: date)
            return (readableDate)
        }
        return ("Invalid date format.")
    }
    
    
    func extractDimensions(_ description: String) -> (width: Int, height: Int) {
        let pattern = #"width="(\d+)" height="(\d+)""#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let nsString = description as NSString
            let results = regex.matches(in: description, range: NSRange(location: 0, length: nsString.length))
            
            for match in results {
                if let widthRange = Range(match.range(at: 1), in: description),
                   let heightRange = Range(match.range(at: 2), in: description) {
                    let width = Int(description[widthRange]) ?? -1
                    let height = Int(description[heightRange]) ?? -1
                    return (width, height)
                }
            }
        } catch let error {
            print("Invalid regex: \(error.localizedDescription)")
        }
        
        return (-1, -1)
    }
    
    
    func trimTitle(_ originalTitle: String) -> (long: String, short: String) {
        let originalTitle = originalTitle.trimmingCharacters(in: .whitespaces)
        
        if originalTitle.isEmpty {
            return ("Untitled", "Untitled")
        }
        
        if originalTitle.count > 25 {
            let shortTitle = String(originalTitle.prefix(22)) + "..."
            return (originalTitle, shortTitle)
        }
        
        return (originalTitle, originalTitle )
    }
}
