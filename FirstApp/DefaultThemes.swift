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
                             color: [.black, .red],
                             isRandomNumberOfPairs: true)
    
    static var hearts = Theme(name: "Hearts",
                              emojiKit: ThemeContent.hearts,
                              color: [.pink, .purple])
    
    static var animals = Theme(name: "Animals",
                               emojiKit: ThemeContent.animals,
                               color: [.yellow, .orange])
    
    static var clouds = Theme(name: "Clouds",
                              emojiKit: ThemeContent.clouds,
                              color: [.gray, .blue])
    
    static var fruits = Theme(name: "Fruits",
                              emojiKit: ThemeContent.fruits,
                              color: [.green, .pink])
    
    static var zodiac = Theme(name: "Zodiac Signs",
                              emojiKit: ThemeContent.zodiacSigns,
                              color: [.purple, .yellow])
}
