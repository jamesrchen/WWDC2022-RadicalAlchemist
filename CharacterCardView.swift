//
//  File.swift
//  RadicalAlchemist
//
//  Created by James Ryan Chen on 23/4/22.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct CharacterCardView: View {
    @Binding var selectedCharacter: String
    
    let character: String
    let pinyin: String
    let definition: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .circular)
                .fill(Color(selectedCharacter == character ? UIColor.systemGray4 : UIColor.systemGray6))
            VStack {
                Text(character + " " + pinyin)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(definition)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
        }
        .background(.clear)
        .contentShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .onDrag {
            return NSItemProvider(object: character as NSString)
        }
    }
    
}
