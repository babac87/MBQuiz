//
//  Question.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/2/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

class Question: NSObject {

  static private var currentId = 0
  private var question: String
  private var answers: [Answer]
  private var correctAnswers: [Answer]
  private var type: QuestionType
  private var id: Int
  private var points: Double
  private var correctAnswerDescription: String?
  
  init(question: String, answers: [Answer], correctAnswers: [Answer], type: QuestionType, id: Int?, points: Double, correctAnswerDescription: String?) {
    self.question = question
    self.answers = answers
    self.correctAnswers = correctAnswers
    self.type = type
    if let id = id {
      self.id = id
    } else {
      Question.currentId += 1
      self.id = Question.currentId
    }
    self.points = points
    self.correctAnswerDescription = correctAnswerDescription
  }
  
  convenience init(question: String, answers: [Answer], correctAnswers: [Answer], id: Int?) {
    self.init(question: question, answers: answers, correctAnswers: correctAnswers, type: .singleAnswer, id: id, points: 0.0, correctAnswerDescription: nil)
  }
  

  
}
