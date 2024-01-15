//
//  ViewController.swift
//  Pairs
//
//  Created by Christopher Endress on 1/15/24.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  var cards = [Card]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Collection view methods
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
    cell.layer.cornerRadius = 20
    cell.backgroundColor = .systemPurple
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromLeft, animations: {
      cell.contentView.backgroundColor = cell.contentView.backgroundColor == .systemGray ? .systemPurple : .systemGray
    })
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout methods
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 160, height: 260)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
  
  //MARK: - Other methods
  
  private func initializeCards() {
    let pairs = [("Paris", "France"), ("London", "England"), ("Bangkok", "Thailand"), ("Beijing", "China"), ("Mexico City", "Mexico"), ("Geneva", "Switzerland"), ("Berlin", "Germany"), ("Tokyo", "Japan")]
    
    for pair in pairs {
      let cardOne = Card(content: pair.0)
      let cardTwo = Card(content: pair.1)
      cards.append(contentsOf: [cardOne, cardTwo]) //duplicate the cards if needed
    }
    
    cards.shuffle()
  }
  
  //create cards
  //create a collection view containing the cards
  //create an onTap method that determines whats done once the card is tapped
  //only allow two cards to be flipped at a time for a new action is done
  
  //cards must come in pairs of two (dictionary)
  //create a dictionary of pairing values that contain the same key or index?
  
  //if two cards match remove them and update the score
  //if both cards don't match then flip them over again
}

