//
//  Quiz.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/2/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import Foundation

class Quiz: NSObject {

  static private var currentId = 0
  
  private var questions: [Question]
  private var result = 0.0
  private var answered = false
  private var attempted = false
  private var id: Int
  
  init(questions: [Question], startingResult result: Double, id: Int) {
    self.questions = questions
    self.result = result
    self.id = id
  }
}
