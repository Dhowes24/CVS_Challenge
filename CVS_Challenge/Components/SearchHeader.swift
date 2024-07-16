//
//  SearchHeader.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import SwiftUI

struct SearchHeader: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var textInput: String
    @Binding var toggle: Bool
    
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text("Search Page")
                    .font(.custom("Georgia", size: 30, relativeTo: .headline))
                    .padding(.bottom, 12)
                
                Spacer()
                
                HStack {
                    SFSymbols.gridToggle
                        .onTapGesture {
                            toggle = false
                        }
                    
                    Toggle("", isOn: $toggle)
                        .frame(width: 50)
                        .padding(.horizontal, 0)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    SFSymbols.listToggle
                        .onTapGesture {
                            toggle = true
                        }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Switch from list to grid view. Current setting: \(toggle ? "List" : "Grid")")
                
            }
            .padding(.horizontal, 30)
            
            HStack {
                SFSymbols.magnifyingGlass
                    .padding(.trailing, 8)
                
                TextField("Enter pictures for search", text: $textInput)
                    .font(.custom("Georgia", size: 18, relativeTo: .headline))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 180.0)
                            .stroke(
                                colorScheme == .light ? .black : .white, lineWidth: 1)
                    )
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(Text("Search for images using this input. Current input: \(textInput)"))
            .padding(.horizontal, 30)
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State var toggle = false
        
        var body: some View {
            SearchHeader(textInput: .constant("Test String"), toggle: $toggle)
        }
    }

    return PreviewWrapper()
}
