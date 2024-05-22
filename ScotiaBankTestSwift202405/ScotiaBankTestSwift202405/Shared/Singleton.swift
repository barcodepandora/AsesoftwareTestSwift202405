//
//  Shared.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 22/05/24.
//

import Foundation

enum Adult {
    case allMinusAdult
    case all
    case adult
}

class Singleton {
    static let shared = Singleton()
    
    var adult = Adult.all
    var main: TMDBViewController?
    
    func research() {
        main?.reactToChange()
    }
}

