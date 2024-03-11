//
//  Image.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit

extension UIImage {
    func toBase64() -> String? {
        return self.pngData()!
            .base64EncodedString()
    }
}
