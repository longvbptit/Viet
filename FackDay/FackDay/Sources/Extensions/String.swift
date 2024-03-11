//
//  String.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation
import UIKit

extension String {
    var base64Encoded: String {
        return Data(self.utf8).base64EncodedString()
    }
}
