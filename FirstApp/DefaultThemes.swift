//
//  DefaultThemes.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 10.12.2022.
//

import Foundation

struct DefaultThemes {
    
    static var moons = Theme(name: "Phases of Moon",
                             emojiKit: ThemeContent.phasesOfMoon,
                             color: .black,
                             isRandomNumberOfPairs: true)
    
    static var hearts = Theme(name: "Hearts",
                              emojiKit: ThemeContent.hearts,
                              color: .pink)
    
    static var animals = Theme(name: "Animals",
                               emojiKit: ThemeContent.animals,
                               color: .yellow)
    
    static var clouds = Theme(name: "Clouds",
                              emojiKit: ThemeContent.clouds,
                              color: .gray)
    
    static var fruits = Theme(name: "Fruits",
                              emojiKit: ThemeContent.fruits,
                              color: .green)
    
    static var zodiac = Theme(name: "Zodiac Signs",
                              emojiKit: ThemeContent.zodiacSigns,
                              color: .purple)
}
