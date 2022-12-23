//
//  Theme.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 23.12.2022.
//

import Foundation
import SwiftUI

struct Theme {
    var name: String
    var emojiKit: [String]
    var color: Color
    private(set) var numberOfPairs: Int
    
    init(name: String,
         emojiKit: [String],
         numberOfPairs: Int? = nil,
         color: Color,
         isRandomNumberOfPairs: Bool = false) {
        self.name = name
        self.emojiKit = emojiKit
        
        if !isRandomNumberOfPairs {
            if let numberOfPairs = numberOfPairs {
                self.numberOfPairs = numberOfPairs
            } else {
                self.numberOfPairs = emojiKit.count
            }
        } else {
            self.numberOfPairs = Int.random(in: 1...emojiKit.count)
        }
        
        self.color = color
    }
    
    mutating func changeNumberOfPairs(pairs: Int) {
        if (pairs > 0) && (pairs <= emojiKit.count) {
            numberOfPairs = pairs
        } else {
            numberOfPairs = emojiKit.count
        }
    }
}
