//
//  AutoAlignWordCardsView.swift
//  RadicalAlchemist
//
//  Created by James Ryan Chen on 24/4/22.
//

import SwiftUI

struct AutoAlignWordCardsView: View {
    var hanZiDictionaryManager: HanZiDictionaryManager
    @Binding var words: [String]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(150)), GridItem(.fixed(150))]) {
                
                ForEach(0..<words.count, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.systemGray6))
                            .aspectRatio(1, contentMode: .fit)
                        VStack {
                            Text(hanZiDictionaryManager.entries[words[index]]?.pinyin.joined(separator: " / ") ?? "")
                                .font(.headline)
                            Text(words[index])
                                .font(.system(size: 50))
                        }
                    }
                }
            }
            .padding()
            .padding(.top, 50)

        }
    }
}
