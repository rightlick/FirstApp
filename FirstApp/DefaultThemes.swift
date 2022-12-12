//
//  DefaultThemes.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 10.12.2022.
//

import Foundation

struct DefaultThemes {
    
     static var moons = MemoryGame<String>.Theme(name: "Phases of Moon",
                                                emojiKit: ThemeContent.phasesOfMoon,
                                                numberOfPairs: 8,
                                                color: .black)
    
    static var hearts = MemoryGame<String>.Theme(name: "Hearts",
                                                 emojiKit: ThemeContent.hearts,
                                                 numberOfPairs: 8,
                                                 color: .pink)
    
    static var animals = MemoryGame<String>.Theme(name: "Animals",
                                                  emojiKit: ThemeContent.animals,
                                                  numberOfPairs: 3,
                                                  color: .yellow)
    
    static var clouds = MemoryGame<String>.Theme(name: "Clouds",
                                                 emojiKit: ThemeContent.clouds,
                                                 numberOfPairs: 8,
                                                 color: .gray)
    
    static var fruits = MemoryGame<String>.Theme(name: "Fruits",
                                                 emojiKit: ThemeContent.fruits,
                                                 numberOfPairs: 8,
                                                 color: .green)
    
    static var zodiac = MemoryGame<String>.Theme(name: "Zodiac Signs",
                                                 emojiKit: ThemeContent.zodiacSigns,
                                                 numberOfPairs: 8,
                                                 color: .purple)
}
