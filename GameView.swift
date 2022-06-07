//
//  GameView.swift
//  RadicalAlchemist
//
//  Created by James Ryan Chen on 23/4/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct GameView: View {
    let hanZiDictionaryManager: HanZiDictionaryManager
    
    
    @State var selectionMode = 1
    @State var searchText = ""
    @State var characterList: [String]
    @State var selectedCharacter = "扌"
    
    @State var hasCraftedBefore = false
    @State var discoveredCharacters: [String] = ["扌", "戈", "礻", "一", "口", "田", "人"]
    
    @State var crafting = true
    
    @State var workingCharacters: [String] = []
    
    @State var newCharacters: [String] = []
    
    init(hanZiDictionaryManager: HanZiDictionaryManager) {
        self.hanZiDictionaryManager = hanZiDictionaryManager
        self.characterList = ["扌", "戈", "礻", "一", "口", "田", "人"]
    }
    
    func updateCharacterList() {
        switch selectionMode {
        case 0:
            characterList = hanZiDictionaryManager.radicals
        case 1:
            characterList = discoveredCharacters
        case 2:
            characterList = hanZiDictionaryManager.characters
        default:
            characterList = hanZiDictionaryManager.radicals
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Picker("Mode", selection: $selectionMode) {
                        Text("All (\(hanZiDictionaryManager.characters.count))").tag(2)
                        Text("Radicals (\(hanZiDictionaryManager.radicals.count))").tag(0)
                        Text("Discovered (\(discoveredCharacters.count))").tag(1)
                    }
                    .onChange(of: selectionMode) { _ in updateCharacterList() }
                    .onChange(of: discoveredCharacters) { _ in updateCharacterList() }
                    .pickerStyle(.segmented)
                    .padding(.top)
                    .padding(.horizontal)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(UIColor.systemGray6))
                        HStack {
                            Image(systemName: "magnifyingglass").padding(.leading)
                            TextField("Search", text: $searchText)
                                .autocapitalization(.none)
                        }
                        .foregroundColor(.gray)
                    }
                    .frame(height:40)
                    .cornerRadius(10)
                    .padding(.horizontal, 18)
                    
                    ScrollView(.vertical) {
                        VStack {
                            
                            if selectionMode == 2 {
                                Text("Results have been truncated to 500 characters. Search to find specific characters")
                                    .font(.caption)
                                    .padding()
                            }
                            
                            let suitableCharacters = characterList.filter { character in
                                if let pinyin = hanZiDictionaryManager.entries[character]?.pinyin {
                                    for i in 0..<pinyin.count {
                                        return pinyin[i].applyingTransform(.stripDiacritics, reverse: false)?.lowercased().contains(searchText.lowercased()) ?? false
                                    }
                                }
                                return hanZiDictionaryManager.entries[character]?.definition?.contains(searchText) ?? false
                            }
                            
                            ForEach((searchText.isEmpty ? characterList : suitableCharacters).prefix(500), id: \.self) { character in
                                CharacterCardView(selectedCharacter: $selectedCharacter,
                                                  character: character,
                                                  pinyin: hanZiDictionaryManager.entries[character]?.pinyin.joined(separator: " / ") ?? "",
                                                  definition: hanZiDictionaryManager.entries[character]?.definition ?? "")
                                    .gesture(TapGesture(count: 2).onEnded {
                                        withAnimation() {
                                            crafting = true
                                            workingCharacters.append(character)
                                        }
                                    })
                                    .simultaneousGesture(TapGesture().onEnded {
                                        withAnimation(.easeInOut(duration: 0.25)) {
                                            selectedCharacter = character
                                        }
                                    })
                            }
                        }
                        .padding(.horizontal, 50)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Divider()
                    
                    
                    CharacterDefinitionView(hanZiDictionaryManager: hanZiDictionaryManager, character: $selectedCharacter)
                    
                }

                Divider()
                
                // Alchemising Area
                AlchemiseView(
                    hanZiDictionaryManager: hanZiDictionaryManager,
                    hasAlchemisedBefore: $hasCraftedBefore,
                    discoveredCharacters: $discoveredCharacters,
                    crafting: $crafting,
                    workingCharacters: $workingCharacters,
                    newCharacters: $newCharacters
                )
            }
            
            if !newCharacters.isEmpty {
                RoundedRectangle(cornerRadius: 2)
                    .fill(.gray.opacity(0.8))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .onTapGesture() {
                        withAnimation {
                            newCharacters = []
                        }
                    }
                
                VStack {
                    Spacer()
                    
                    Text("Discovered new character(s)!")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .font(.bold(.system(size: 32))())
                        .minimumScaleFactor(0.2)
                        .padding()
                    
                    Text(newCharacters.joined(separator: " / "))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 75))
                        .minimumScaleFactor(0.2)
                        .padding()
                    
                    Spacer()
                        
                    Text("Tap anywhere on the background to continue")
                        .font(.italic(.system(size: 20))())
                        .foregroundColor(.black.opacity(0.8))
                        .padding()
                    
                }
                
                
            }
            
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(hanZiDictionaryManager: HanZiDictionaryManager())
    }
}
