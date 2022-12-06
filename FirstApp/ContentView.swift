//
//  ContentView.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 03.12.2022.
//

import SwiftUI

struct ContentView : View {
    var phasesOfMoon = ["🌚", "🌕", "🌖", "🌗",
                        "🌑", "🌒", "🌓", "🌔"]
    
    var hearts = ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍",
                  "🤎", "💔", "❤️‍🔥", "❤️‍🩹", "💖", "💝", "💘", "💞"]
    
    var animals = ["🦊", "🐼", "🐷", "🐻", "🐶", "🐱", "🐭", "🐹",
                   "🐰", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐸", "🐥",
                   "🐔", "🐧", "🦄", "🦉"]
    
    @State var currentCards: [String]
    
    @State var arrayCount = 3
    
    init(currentArray: [String]) {
        self.currentCards = currentArray
    }
    
    var body : some View {
        VStack {
            Text("Memorize!").font(.title).fontWeight(.black).foregroundColor(Color.green)
            
            let items = [GridItem(.adaptive(minimum: 100))]
            
            ScrollView {
                LazyVGrid(columns: items, spacing: 10) {
                    ForEach(currentCards[0..<arrayCount], id: \.self) { card in
                        CardView(content: card).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                remove
                Spacer()
                buttonMoon
                Spacer()
                buttonHearts
                Spacer()
                buttonAnimals
                Spacer()
                add
            }
            .font(.largeTitle)
        }
        .padding(.all)
        .foregroundColor(.green)
    }
    
    var buttonMoon: some View {
        VStack {
            Button(action: {
                if arrayCount > phasesOfMoon.count {
                    arrayCount = phasesOfMoon.count
                }
                currentCards = phasesOfMoon.shuffled()
            }, label: {
                Image(systemName: "moon.circle.fill")
            })
            
            Text("Moons")
                .font(.subheadline)
        }
    }
    
    var buttonHearts: some View {
        VStack {
            Button(action: {
                if arrayCount > hearts.count {
                    arrayCount = hearts.count
                }
                currentCards = hearts.shuffled()
            }, label: {
                Image(systemName: "heart.circle.fill")
            })
            
            Text("Hearts")
                .font(.subheadline)
        }
    }
    
    var buttonAnimals: some View {
        VStack {
            Button(action: {
                if arrayCount > animals.count {
                    arrayCount = animals.count
                }
                currentCards = animals.shuffled()
            }, label: {
                Image(systemName: "pawprint.circle.fill")
            })
            
            Text("Animals")
                .font(.subheadline)
        }
    }
    
    var remove: some View {
        Button(action: {
            if arrayCount > 1 {
                arrayCount -= 1
            }
        }, label: {
            Image(systemName: "minus.rectangle.portrait")
        })
    }
    
    var add: some View {
        Button(action: {
            if arrayCount < currentCards.count {
                arrayCount += 1
            }
        }, label: {
            Image(systemName: "plus.rectangle.portrait")
        })
    }
}


struct CardView : View {
    
    @State var isFaceUp: Bool = true
    var content : String
    
    var body : some View {
        return ZStack(content: {
            let shape = RoundedRectangle(cornerRadius: 15)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 5)
                
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        })
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let phasesOfMoon = ["🌚", "🌕", "🌖", "🌗",
                            "🌑", "🌒", "🌓", "🌔"].shuffled()
        ContentView(currentArray: phasesOfMoon)
    }
}
