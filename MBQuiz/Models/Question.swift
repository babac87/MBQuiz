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
  var question: String
  private var _answers: [Answer]
  private var _selectedAnswers = Set<Answer>()
  private var correctAnswers: Set<Answer>
  private var type: QuestionType
  private var id: Int
  private var points: Double
  private var correctAnswerDescription: String?
  
  var answers: [Answer] {
    get {
      return _answers
    }
  }
  var selectedAnswers: Set<Answer> {
    get {
      return _selectedAnswers
    }
  }
  
  init(question: String, answers: [Answer], correctAnswers: Set<Answer>, type: QuestionType, id: Int?, points: Double, correctAnswerDescription: String?) {
    self.question = question
    self._answers = answers
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
  
  convenience init(question: String, answers: [Answer], correctAnswers: Set<Answer>, id: Int?) {
    self.init(question: question, answers: answers, correctAnswers: correctAnswers, type: .singleAnswer, id: id, points: 0.0, correctAnswerDescription: nil)
  }
  
  func select(answer: Answer) {
    if _selectedAnswers.contains(answer) {
      _selectedAnswers.remove(answer)
      return
    }
    switch type {
    case .multipleAnswer:
      _selectedAnswers.insert(answer)
    default:
      _selectedAnswers = Set<Answer>([answer])
    }
  }  
}
