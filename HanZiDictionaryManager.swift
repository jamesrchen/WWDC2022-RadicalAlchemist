//
//  HanZiDictionaryManager.swift
//  RadicalAlchemist
//
//  Created by James Ryan Chen on 23/4/22.
//

import Foundation

class HanZiDictionaryManager {
    var radicals: [String] = []
    var characters: [String] = []
    var entries: [String: HanZiDictionaryEntry] = [:]
    var entriesByDecomposition: [[String]: [HanZiDictionaryEntry]] = [:]
    
    init() {
        let streamReader = StreamReader(path: Bundle.main.path(forResource: "newDictionary", ofType: "jsonl")!)!
        while !streamReader.atEof {
            do {
                if let data = streamReader.nextLine()?.data(using: .utf8) {
                    //print(String(decoding: data, as: UTF8.self))
                    let entry = try JSONDecoder().decode(HanZiDictionaryEntry.self, from: data)
                    entries[entry.character] = entry
                    characters.append(entry.character)
                    
                    let decomposition = Array(entry.decomposition).filter() { char in
                        return !["⿰", "⿱", "⿲", "⿳", "⿴", "⿵", "⿶", "⿷", "⿸", "⿹", "⿺", "⿻", "？"].contains(char)
                    }.map { char in
                        return String(char)
                    }
                    
                    if let _ = entriesByDecomposition[decomposition.sorted()] {
                        entriesByDecomposition[decomposition.sorted()]?.append(entry)
                    } else {
                        entriesByDecomposition[decomposition.sorted()] = [entry]
                    }
                    
                    if entry.character == "页" {
                        print(decomposition)
                    }
                    
                    // Adding radicals if not already existent
                    if !radicals.contains(entry.radical) {
                        radicals.append(entry.radical)
                    }
                }
            } catch let error {
                print(error)
            }
        }
        streamReader.close()
    }
    
}

struct HanZiDictionaryEntry: Decodable {
    let character: String
    let definition: String?
    let pinyin: [String]
    let decomposition: String
    let etymology: HanZiDictionaryEtymology?
    let radical: String
    let matches: [[Int?]?]
}

struct HanZiDictionaryEtymology: Decodable {
    let type: String?
    let phonetic: String?
    let semantic: String?
    let hint: String?
}
