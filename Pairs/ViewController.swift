//
//  ViewController.swift
//  Pairs
//
//  Created by Christopher Endress on 1/15/24.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var capitalCities: [String: String] = ["Paris": "France", "London": "England", "Bangkok": "Thailand", "Beijing": "China", "Mexico City": "Mexico", "Geneva": "Switzerland", "Berlin": "Germany", "Tokyo": "Japan"]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  //MARK: - Collection view methods
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return capitalCities.count / 2
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
    cell.layer.cornerRadius = 20
    cell.backgroundColor = .systemPurple
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //what happens when a card is tapped
  }
  
  //MARK: - UICollectionViewDelegateFlowLayout method
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 128, height: 200)
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

