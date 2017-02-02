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
  private var result: Double
  private var answered = false
  private var attempted = false
  private var id: Int
  
  init(questions: [Question], startingResult result: Double = 0.0, id: Int?) {
    self.questions = questions
    self.result = result
    if let id = id {
      self.id = id
    } else {
      Quiz.currentId += 1
      self.id = Quiz.currentId
    }
  }
}
