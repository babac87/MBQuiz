//
//  QuestionCollectionViewCell.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/3/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

protocol NavigationButtonsCollectionViewCellDelegate {
  func leftButtonPressed()
  func rightButtonPressed()
}

class QuestionCollectionViewCell: UICollectionViewCell {
  
  var delegate: NavigationButtonsCollectionViewCellDelegate?
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var leftButton: UIButton!
  @IBOutlet weak var rightButton: UIButton!
  
  @IBAction func leftButtonPressed(_ sender: UIButton) {
    delegate?.leftButtonPressed()
  }
  
  @IBAction func rightButtonPressed(_ sender: UIButton) {
    delegate?.rightButtonPressed()
  }
  
}
