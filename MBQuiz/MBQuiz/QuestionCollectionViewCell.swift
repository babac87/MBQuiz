//
//  QuestionCollectionViewCell.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/3/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit



class QuestionCollectionViewCell: QuizCollectionViewCell {
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    questionImageView.round()
  }
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var questionImageView: UIImageView!
}
