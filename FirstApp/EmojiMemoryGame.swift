//
//  EmojiMemoryGame.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 08.12.2022.
//

//ViewModel?

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static var allThems = [DefaultThemes.animals,
                           DefaultThemes.moons,
                           DefaultThemes.hearts,
                           DefaultThemes.clouds,
                           DefaultThemes.fruits,
                           DefaultThemes.zodiac]
    
    static var currentTheme = allThems.randomElement()!
    
    static func makeArrayUnique(_ array: [String]) -> [String] {
        var localArray = [String]()
        for element in array {
            if !localArray.contains(element) {
                localArray.append(element)
            }
        }
        return localArray
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        currentTheme.emojiKit = makeArrayUnique(currentTheme.emojiKit.shuffled())

        return MemoryGame<String>(numberOfPairsOfCards: 2 /* currentTheme.numberOfPairs */)
        { pairIndex in
            currentTheme.emojiKit[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var score: Int {
        model.score
    }
    
    var cards: [Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        EmojiMemoryGame.currentTheme = EmojiMemoryGame.allThems.randomElement()!
        model = EmojiMemoryGame.createMemoryGame()
    }
}
