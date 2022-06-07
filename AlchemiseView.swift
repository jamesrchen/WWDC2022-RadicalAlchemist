//
//  CraftView.swift
//  RadicalAlchemist
//
//  Created by James Ryan Chen on 24/4/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct AlchemiseView: View {
    var hanZiDictionaryManager: HanZiDictionaryManager
    
    @Binding var hasAlchemisedBefore: Bool
    @Binding var discoveredCharacters: [String]
    
    @State var isTargeted = false
    @State var darkened = false
    
    @Binding var crafting: Bool
    @State var displayCharacters: [String] = []
    @Binding var workingCharacters: [String]
    @Binding var newCharacters: [String]
    
    var body: some View {
        ZStack {
            
            VStack {
                
                // Screen to show in the process of crafting
                if crafting {
                    if !workingCharacters.isEmpty {
                        VStack {
                            
                            AutoAlignWordCardsView(
                                hanZiDictionaryManager: hanZiDictionaryManager,
                                words: $workingCharacters
                            )
                            
                            Spacer()
                            
                            Text(workingCharacters.joined(separator: "+"))
                                .minimumScaleFactor(0.01)
                            
                            Button {
                                if let entries = hanZiDictionaryManager.entriesByDecomposition[workingCharacters.sorted()] {
                                    displayCharacters = entries.map() { $0.character }
                                    workingCharacters = []
                                    crafting = false
                                    hasAlchemisedBefore = true
                                    
                                    entries.forEach() { entry in
                                        if !discoveredCharacters.contains(entry.character) {
                                            withAnimation() {
                                                newCharacters.append(entry.character)
                                            }
                                            discoveredCharacters.append(entry.character)
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Text("Alchemise!")
                                    Image(systemName: "flame")
                                }
                            }
                            .padding()
                            .tint(.blue)
                            .buttonStyle(.bordered)
                            
                        }
                    }
                    
                    if workingCharacters.isEmpty{
                        VStack {
                            Text("To begin alchemising, drag some characters here!")
                                .padding()
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            if !hasAlchemisedBefore {
                                Text("Try dragging 扌and 戈!")
                                    .padding()
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                        
                    }
                    
                    Spacer()
                }
                
                if !crafting {
                    // Screen to show once crafting is done
                    VStack {
                        Text(displayCharacters.joined(separator: " / "))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 400)
                            .font(.system(size: 100))
                            .minimumScaleFactor(0.2)
                        
                        Divider()
                        
                        ScrollView {
                            VStack {
                                ForEach(displayCharacters, id: \.self) { char in
                                    
                                    if let entry = hanZiDictionaryManager.entries[char] {
                                        HStack {
                                            VStack {
                                                Text(entry.pinyin.joined(separator: " / "))
                                                Text(char)
                                            }
                                            .padding(.trailing)
                                            
                                            Text(entry.definition ?? "no definition")
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Divider().frame(width: 100)
                                    }
                                    
                                }
                            }.padding()
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation() {
                            workingCharacters = []
                            crafting = true
                            displayCharacters = []
                        }
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25.0)
                            .foregroundColor(.gray)
                    }).padding().frame(alignment: .trailing)
                }
                Spacer()
            }
            
        }
        .contentShape(Rectangle())
        .background(.gray.opacity(darkened ? 0.2 : 0.01))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onDrop(of: [UTType.text], isTargeted: $isTargeted) { itemProvider in
            if let item = itemProvider.first {
                item.loadItem(forTypeIdentifier: "public.text") {(coding, err) in
                    if let data = coding as? Data {
                        let text = String(decoding: data, as: UTF8.self)
                        if hanZiDictionaryManager.characters.contains(text) && text.count == 1 {
                            withAnimation() {
                                crafting = true
                                workingCharacters.append(text)
                            }
                        }
                    }
                }
            }
            return true
        }
        .onChange(of: isTargeted) { _ in
            withAnimation() {
                darkened = isTargeted
            }
        }
        
    }
    
    
}
