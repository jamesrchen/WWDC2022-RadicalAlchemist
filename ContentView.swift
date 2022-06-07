import SwiftUI

struct ContentView: View {
    @State var introFinished = false
    let hanZiDictionaryManager = HanZiDictionaryManager()
    
    var body: some View {
        Group {
            if !introFinished {
                IntroView(introFinished: $introFinished)
            }
            else {
                GameView(hanZiDictionaryManager: hanZiDictionaryManager)
            }
        }
    }
}
