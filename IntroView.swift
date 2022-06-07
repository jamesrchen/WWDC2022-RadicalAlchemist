//
//  IntroView.swift
//  RadicalAlchemist
//
//  Created by James Ryan Chen on 23/4/22.
//

import SwiftUI
import MapKit

struct IntroView: View {
    @Binding var introFinished: Bool
    @State var introSteps = 0
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.554345, longitude: 127.049405),
        span: MKCoordinateSpan(latitudeDelta: 23, longitudeDelta: 23)
    )
    
    var body: some View {
        if introSteps == 0 {
            Text("Welcome to Radical Alchemist")
                .font(.bold(.largeTitle)())
                .multilineTextAlignment(.center)
                .padding()
            Divider().padding(.horizontal).padding(.bottom)
            ScrollView {
                VStack {
                    Image("IntroIcon")
                        .resizable()
                        .frame(width: 450, height: 450)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("In this short experience, you will be able to learn a little more about the Chinese Language, as well as a bit about CJK (Chinese, Japanese and Korean) language and culture")
                        .font(.headline)
                        .padding()
                    Button("Continue") {
                        introSteps += 1
                    }
                    Spacer()
                }.padding()
            }
        }
        
        if introSteps == 1 {
            Text("What is CJK?")
                .font(.bold(.largeTitle)())
                .multilineTextAlignment(.center)
                .padding()
            Divider().padding(.horizontal).padding(.bottom)
            
            ScrollView {
                VStack {
                    Map(coordinateRegion: $region)
                        .frame(width: 450, height: 450)
                    HStack {
                        Divider().frame(width: 10).background(.yellow)
                        Text("CJK characters, is a collective term for Chinese, Japanese, and Korean languages, all of which include Chinese characters and derivatives in their writing systems.")
                            .font(.headline)
                    }.padding(.horizontal, 50).frame(height: 85)
                    Text("Across these regions, there have many cultural exchanges and parts of these languages also bear similarities to each other.").padding()
                    Button("Continue") {
                        introSteps += 1
                    }
                    Spacer()
                }.padding()
            }
        }
        
        if introSteps == 2 {
            Text("Chinese Character Radicals?")
                .font(.bold(.largeTitle)())
                .multilineTextAlignment(.center)
                .padding()
            Divider().padding(.horizontal).padding(.bottom)
            
            ScrollView {
                VStack {
                    Image("WhatIsRadical")
                        .resizable()
                        .frame(width: 450, height: 450)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    HStack {
                        Divider().frame(width: 10).background(.yellow)
                        Text("A Chinese radical or indexing component is a graphical component of a Chinese character under which the character is traditionally listed in a Chinese dictionary. This component is often a semantic indicator similar to a morpheme, though sometimes it may be a phonetic component or even an artificially extracted portion of the character. In some cases the original semantic or phonological connection has become obscure, owing to changes in character meaning or pronunciation over time. ")
                            .font(.headline)
                    }.padding(.horizontal, 50).frame(height: 85)
                    Text("Chinese radicals are the building blocks of Chinese words, they give Chinese words pronunciation and meaning.").padding()
                    Button("Continue") {
                        introSteps += 1
                    }
                    Spacer()
                }.padding()
            }
        }
        
        if introSteps == 3 {
            Text("What is this application, and how do I use it?")
                .font(.bold(.largeTitle)())
                .multilineTextAlignment(.center)
                .padding()
            Divider().padding(.horizontal).padding(.bottom)
            
            ScrollView {
                VStack {
                    Image("IntroDrag")
                        .resizable()
                        .frame(width: 650, height: 454)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("This app aims to be a linguistical experiment and demonstrate the fun in playing around with Chinese characters. You can drag and drop (or double click) part of a character into the right section to form other characters.").padding()
                    
                    Button("Continue") {
                        introSteps += 1
                    }
                    Spacer()
                }.padding()
            }
            
        }
        
        if introSteps == 4 {
            Text("What is this application, and how do I use it?")
                .font(.bold(.largeTitle)())
                .multilineTextAlignment(.center)
                .padding()
            Divider().padding(.horizontal).padding(.bottom)
            
            ScrollView {
                VStack {
                    Image("IntroAlchemise")
                        .resizable()
                        .frame(width: 650, height: 454)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("After dragging your characters, you can press \"Alchemise\" to form a new word!").padding()
                    
                    Button("Finish") {
                        introFinished = true
                    }
                    Spacer()
                }.padding()
            }
            
        }
        
    }
}

