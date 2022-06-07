//
//  CharacterDefinitionView.swift
//  RadicalAlchemist
//
//  Created by James Ryan Chen on 23/4/22.
//

import SwiftUI

struct CharacterDefinitionView: View {
    let hanZiDictionaryManager: HanZiDictionaryManager
    @Binding var character: String

    let entry: HanZiDictionaryEntry?
    
    init(hanZiDictionaryManager: HanZiDictionaryManager, character: Binding<String>) {
        self.hanZiDictionaryManager = hanZiDictionaryManager
        self._character = character
        
        self.entry = hanZiDictionaryManager.entries[character.wrappedValue]
        
    }
    
    var body: some View {
        
        HStack {
            VStack {
                Text(character)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 75))
                
                Text(entry?.definition ?? "")
                Text(entry?.decomposition ?? "")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
            if let etymology = entry?.etymology {
                Divider().frame(height:50)
                VStack {
                    Text(etymology.type ?? "")
                        .multilineTextAlignment(.center)
                        .font(.bold(.body)())
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    if let phonetic = etymology.phonetic {
                        Text("\(phonetic) provides the pronunciation")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if let semantic = etymology.semantic {
                        Text("\(semantic) provides the meaning")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if let hint = etymology.hint {
                        Text("("+hint+")")
                            .multilineTextAlignment(.center)
                            .font(.italic(.body)())
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
        }
        
    }
}
