//
//  QuizCollectionViewCell.swift
//  MBQuiz
//
//  Created by Mirko Babic on 3/3/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

protocol NavigationButtonsCollectionViewCellDelegate {
  func leftButtonPressed()
  func rightButtonPressed()
}

class QuizCollectionViewCell: UICollectionViewCell {
  
  var delegate: NavigationButtonsCollectionViewCellDelegate?

  @IBOutlet weak var whiteBackgroundView: UIView!
  @IBOutlet weak var whiteCircleView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    whiteBackgroundView.layer.cornerRadius = 15.0
    whiteCircleView.round()
    imageView.round()
  }
  
  @IBAction func leftButtonPressed(_ sender: UIButton) {
    delegate?.leftButtonPressed()
  }
  
  @IBAction func rightButtonPressed(_ sender: UIButton) {
    delegate?.rightButtonPressed()
  }
}
