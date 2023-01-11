//
//  MemoryGame.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 08.12.2022.
//

// Model?

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards = [Card]()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    var score: Int = 0
    
    private var firstCardChosen: Date?
    
    mutating func choose(_ card: Card) {
        if firstCardChosen == nil {
            firstCardChosen = Date()
        }
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                                //если контент на двух карточках совпал
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    let secondCardChosen = Date()
                    let timeInterval = firstCardChosen?.distance(to: secondCardChosen)
                    
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2 * max((10 - Int(timeInterval!)), 1)
                } else {        //если контент на двух карточках не совпал
                
                    //если первая открытая карточка уже переворачивалась до этого, то -1 балл
                    if cards[chosenIndex].wasShown {
                        score -= 1
                    }
                    //если вторая открытая карточка уже переворачивалась до этого, то -1 балл
                    if cards[potentialMatchIndex].wasShown {
                        score -= 1
                    }
                }
                firstCardChosen = nil
                cards[chosenIndex].wasShown = true             //эта карточка переворачивалась
                cards[potentialMatchIndex].wasShown = true     //эта карточка переворачивалась
                
                cards[chosenIndex].isFaceUp = true
            } else {
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        
        cards = [Card]()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int
        var wasShown = false
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 10
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
//      Это либо 0, либо ТаймЛимит - время, которое карточка лежала вверх лицом
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
//      Это дробь - нынешний кусок пирога по форме как х/10, которую съели от целой части
        var bonusRemaning: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
