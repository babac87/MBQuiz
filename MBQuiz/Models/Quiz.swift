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
  public private(set) var answeredQuestions: [Question]
  public private(set) var currentQuestion: Question?
  private var result: Double
  private var answered = false
  private var attempted = false
  private var id: Int
  public private(set) var questionSequel: [QuestionSequelType]
  public private(set) var currentSequelIndex = 0
//  public private(set) var numberOfQuestions: Int
  
  init(questions: [Question], startingResult result: Double = 0.0, id: Int?) {
    self.questions = questions.reversed()
    self.answeredQuestions = [Question]()
    self.result = result
    if let id = id {
      self.id = id
    } else {
      Quiz.currentId += 1
      self.id = Quiz.currentId
    }
    questionSequel = [QuestionSequelType]()
    for question in questions {
      questionSequel.append(.question)
      if question.correctAnswerDescription != nil {
        questionSequel.append(.description)
      }
    }
    if questionSequel.count > 0 {
      questionSequel.append(.result)
    }
//    numberOfQuestions = questions.count + answeredQuestions.count + 1 // current question
  }
  
  func popQuestion() -> Question? {
    if questions.count > 0 {
      currentQuestion = questions.removeLast()
      return currentQuestion
    } else {
      return nil
    }
  }
  
  func questionAnswered() {
    answeredQuestions.append(currentQuestion!)
    currentQuestion = nil
  }
  
  /// Returns next SequelType.
  /// Helps in choosing next CollectionViewCell
  func nextInSequel() -> QuestionSequelType {
    if currentSequelIndex < questionSequel.count - 1{
      currentSequelIndex += 1
    }
    return questionSequel[currentSequelIndex]
  }
}
