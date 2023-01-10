//
//  FirstAppApp.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 03.12.2022.
//

import SwiftUI

@main
struct FirstAppApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
