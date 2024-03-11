//
//  IconItem.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import UIKit
import Parchment

struct IconItem: PagingItem, Hashable, Comparable {
  
    let icon: String
    let selectedIcon: String
    let index: Int
  
    init(icon: String, selectedIcon: String, index: Int) {
        self.icon = icon
        self.selectedIcon = selectedIcon
        self.index = index
  }
  
  static func <(lhs: IconItem, rhs: IconItem) -> Bool {
        return lhs.index < rhs.index
  }
}
