//
//  FirstAppApp.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 03.12.2022.
//

import SwiftUI

@main
struct FirstAppApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
