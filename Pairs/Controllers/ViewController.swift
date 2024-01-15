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
    
    initializeCards()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
  }
  
  // MARK: - Collection view methods
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else {
      fatalError("Unable to dequeue CardCell")
    }
    
    let card = cards[indexPath.row]
    
    if cards[indexPath.row].isFaceUp {
      cell.cardLabel.text = card.content
      cell.backgroundColor = .systemGray
    } else {
      cell.cardLabel.text = ""
      cell.backgroundColor = .systemPurple
    }
    
    configureCard(cell: cell)
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard !cards[indexPath.row].isMatched,
          cards.filter({ $0.isFaceUp && !$0.isMatched }).count < 2 else {
      return
    }
    
    let cell = collectionView.cellForItem(at: indexPath) as? CardCell
    let card = cards[indexPath.row]
    
    UIView.transition(with: cell!, duration: 0.3, options: [.transitionFlipFromLeft], animations: {
      if card.isFaceUp {
        cell?.cardLabel.text = ""
        cell?.backgroundColor = .systemPurple
      } else {
        cell?.cardLabel.text = card.content
        cell?.backgroundColor = .systemGray
      }
    }, completion: { finished in
      self.cards[indexPath.row].isFaceUp.toggle()
      
      let faceUpCards = self.cards.indices.filter { self.cards[$0].isFaceUp && !self.cards[$0].isMatched }
      if faceUpCards.count == 2 {
        if self.cards[faceUpCards[0]].content == self.cards[faceUpCards[1]].content {
          UIView.animate(withDuration: 0.5, animations: {
            if let firstMatchedCell = collectionView.cellForItem(at: IndexPath(item: faceUpCards[0], section: 0)) as? CardCell {
              firstMatchedCell.alpha = 0
            }
            if let secondMatchedCell = collectionView.cellForItem(at: IndexPath(item: faceUpCards[1], section: 0)) as? CardCell {
              secondMatchedCell.alpha = 0
            }
          }, completion: { _ in
            self.cards[faceUpCards[0]].isMatched = true
            self.cards[faceUpCards[1]].isMatched = true
            self.checkForGameCompletion()
          })
        } else {
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            for index in faceUpCards {
              self.cards[index].isFaceUp = false
              if let cellToFlipBack = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CardCell {
                UIView.transition(with: cellToFlipBack, duration: 0.3, options: [.transitionFlipFromRight], animations: {
                  cellToFlipBack.cardLabel.text = ""
                  cellToFlipBack.backgroundColor = .systemPurple
                })
              }
            }
          }
        }
      }
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
      cards.append(contentsOf: [cardOne, cardTwo, cardOne, cardTwo])
    }
    
    cards.shuffle()
  }
  
  private func checkForGameCompletion() {
    if cards.allSatisfy({ $0.isMatched }) {
      showGameCompletionAlert()
    }
  }
  
  private func showGameCompletionAlert() {
    let ac = UIAlertController(title: "Congratulations!", message: "You won the game!", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  @objc private func restartGame() {
    initializeCards()
    collectionView.reloadData()
  }
  
  private func configureCard(cell: CardCell) {
    cell.layer.cornerRadius = 20
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.black.cgColor
    cell.layer.shadowOpacity = 0.5
    cell.layer.shadowRadius = 5
    cell.layer.shadowOffset = CGSize(width: 5, height: 5)
    cell.layer.shadowColor = UIColor.black.cgColor
  }
}
