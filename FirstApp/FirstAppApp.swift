//
//  FirstAppApp.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 03.12.2022.
//

import SwiftUI

@main
struct FirstAppApp: App {
    var body: some Scene {
        WindowGroup {
            let phasesOfMoon = ["🌚", "🌕", "🌖", "🌗",
                                "🌑", "🌒", "🌓", "🌔"].shuffled()
            ContentView(currentArray: phasesOfMoon)
        }
    }
}
