//
//  DummyQuiz.swift
//  MBQuiz
//
//  Created by Mirko Babic on 3/1/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

class DummyQuiz: NSObject {

  static func createDummyQuiz() -> Quiz{
    let questions = createDummyQuestions()
    return Quiz(questions: questions, id: nil)
  }
  
  static private func createDummyQuestions() -> [Question] {
    let answers = createDummyAnswers()
    let question1 = Question(question: "How many legs tarantula has?", answers: answers, correctAnswers: [answers[1]], type: .singleAnswer, correctAnswerDescription: "Tarantula has many legs :)", id: nil, points: 5)
    let question2 = Question(question: "What number is 2 to the power of 3?", answers: answers, correctAnswers: [answers[1]], id: nil)
    let question3 = Question(question: "What is the Capital of Austria?", answers: capitalAnswers(), correctAnswers: [answers[0]], id: nil)
    return [question1, question2, question3]
  }
  
  static private func createDummyAnswers() -> [Answer] {
    let answer1 = Answer(answer: "6", correct: false)
    let answer2 = Answer(answer: "8", correct: true)
    let answer3 = Answer(answer: "10", correct: false)
    return [answer1, answer2, answer3]
  }
  
  static private func capitalAnswers() -> [Answer] {
    let answer1 = Answer(answer: "Graz", correct: false)
    let answer2 = Answer(answer: "Ljubljana", correct: false)
    let answer3 = Answer(answer: "Tirol", correct: false)
    let answer4 = Answer(answer: "Vienna", correct: true)
    return [answer1, answer2, answer3, answer4]
  }
}
