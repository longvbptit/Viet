//
//  Constants.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit

//MARK: - Colors
struct Color {
    static let title = UIColor.white
    static let backgroundColor = UIColor.black
    static let normal = UIColor.white
    static let cusGreen = UIColor.from("1ed374")
    static let cusGray = UIColor.from("1c1c1e")
    static let cusTabbarBackground = UIColor.from("1c1c1e")
}

//MARK: - Font
struct Font {
    static let mainTitle = UIFont(name: "friday night", size: 39)
    static let title = UIFont(name: "friday night", size: 30)
    static let medium = UIFont(name: "VNI-Hobo", size: 20)
    static let normal = UIFont(name: "VNI-Hobo", size: 17)
    static let small = UIFont(name: "VNI-Hobo", size: 15)
    
}


//MARK: - Padding
struct Padding {
    static let top: CGFloat = 16.0
    static let leading: CGFloat = 16.0
    static let trailing: CGFloat = 16.0
    static let bottom: CGFloat = 16.0
    static let spacing: CGFloat = 8.0
}
