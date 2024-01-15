//
//  Card.swift
//  Pairs
//
//  Created by Christopher Endress on 1/15/24.
//

import Foundation

struct Card {
  var city: String
  var country: String
  var isFaceUp: Bool = false
  var isMatched: Bool = false
  
  func matches(with otherCard: Card) -> Bool {
    return (city == otherCard.country) || (country == otherCard.city)
  }
}
