//
//  AppModel.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit

struct ChooseApps: Decodable {
    let apps: [AppModel]
}

struct AppModel: Decodable {
   
    let id: Int
    let name: String
    let image_name: String
    let url_scheme: String
}

extension AppModel {
    static func == (lhs: AppModel, rhs: AppModel) -> Bool {
        if lhs.id != rhs.id {return false}
        if lhs.name != rhs.name {return false}
        if lhs.image_name != rhs.image_name {return false}
        if lhs.url_scheme != rhs.url_scheme {return false}
        return true
    }
}
