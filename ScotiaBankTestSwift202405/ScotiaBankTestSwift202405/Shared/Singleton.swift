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

enum Language {
    case all
    case english
    case francaise
}

enum Average {
    case all
    case lessThan5K
    case moreThan5K
}

class Singleton {
    static let shared = Singleton()
    
    var adult = Adult.all
    var language = Language.all
    var average = Average.all
    var main: TMDBViewController?
    
    func research() {
        main?.reloadTable()
    }
}

