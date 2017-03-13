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
  public private(set) var answers: [Answer]
  public private(set) var selectedAnswers = Set<Answer>()
  public private(set) var correctAnswers: Set<Answer>
  private var type: QuestionType
  private var id: Int
  private var points: Double
  public private(set) var correctAnswerDescription: String?
  var answeredCorrectly: Bool {
    get {
      return correctAnswers == selectedAnswers
    }
  }
  
  init(question: String, answers: [Answer], correctAnswers: Set<Answer>, type: QuestionType, correctAnswerDescription: String?, id: Int?, points: Double) {
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
  
  convenience init(question: String, answers: [Answer], correctAnswers: Set<Answer>, id: Int?) {
    self.init(question: question, answers: answers, correctAnswers: correctAnswers, type: .singleAnswer, correctAnswerDescription: nil, id: id, points: 0.0)
  }
  
  func select(answer: Answer) {
    if selectedAnswers.contains(answer) {
      selectedAnswers.remove(answer)
      return
    }
    switch type {
    case .multipleAnswer:
      selectedAnswers.insert(answer)
    default:
      selectedAnswers = Set<Answer>([answer])
    }
  }  
}
