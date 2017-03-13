//
//  Answer.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/2/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import Foundation
import Unbox

class Answer: NSObject, Unboxable {
  
  var answer: String
  var correct: Bool
  
  required init(unboxer: Unboxer) throws {
    answer = try unboxer.unbox(key: "text")
    correct = try unboxer.unbox(key: "is_correct")
  }
  
  init(answer: String, correct: Bool) {
    self.answer = answer
    self.correct = correct
  }
  
}
