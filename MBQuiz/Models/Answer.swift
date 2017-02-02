//
//  Answer.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/2/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import Foundation

struct Answer {
  
  private var answer: String
  private var correct: Bool
  
  init(answer: String, correct: Bool) {
    self.answer = answer
    self.correct = correct
  }
  
}
