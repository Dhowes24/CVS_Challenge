//
//  Constants.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Foundation
import SwiftUI


enum SFSymbols {
    static let backArrow = Image(systemName: "arrow.backward")
    static let gridToggle = Image(systemName: "rectangle.grid.2x2")
    static let listToggle = Image(systemName: "list.dash")
    static let magnifyingGlass = Image(systemName: "magnifyingglass")
    static let shareButton = Image(systemName: "square.and.arrow.up")
    static let shareError = Image(systemName: "square.and.arrow.up.trianglebadge.exclamationmark")
    
    enum exclamation {
        static func fill(_ filled: Bool) -> Image {
            return Image(systemName: filled ? "exclamationmark.triangle.fill" : "exclamationmark.triangle")
        }
    }
}


let gridImageDimension: CGFloat = 150
let gridViewColumns = [
    GridItem(.adaptive(minimum: gridImageDimension))
]
