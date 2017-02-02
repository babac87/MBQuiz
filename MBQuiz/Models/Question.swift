//
//  Question.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/2/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

struct Question {

  private var question: String
  private var answers: [Answer]
  private var correctAnswers: [Answer]
  private var type: QuestionType
  private var id: Int
  private var points: Double
  private var correctAnswerDescription: String?
  
  
  init(question: String, answers: [Answer], correctAnswers: [Answer], type: QuestionType, id: Int, points: Double, correctAnswerDescription: String?) {
    self.question = question
    self.answers = answers
    self.correctAnswers = correctAnswers
    self.type = type
    self.id = id
    self.points = points
    self.correctAnswerDescription = correctAnswerDescription
  }
  
}
