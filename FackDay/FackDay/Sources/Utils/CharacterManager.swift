//
//  CharacterManager.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit

//MARK: Model
struct CharacterInfo: Decodable {
    let image: String
    let title: String
    let details: String
}


//MARK: Managers
class CharacterManager: NSObject {
    static let shared: CharacterManager = CharacterManager()
    
    var characters: [CharacterInfo]!
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "CharacterData", withExtension: "plist") else { return}
        
        do {
            let data = try? Data(contentsOf: url)
            let decode = PropertyListDecoder()
            self.characters  = try decode.decode([CharacterInfo].self, from: data!)
            
            print("load data success")
        }
        catch {
            print("cannot read character data")
        }
        
        
    }
}

