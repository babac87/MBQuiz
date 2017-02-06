//
//  QuizViewController.swift
//  MBQuiz
//
//  Created by Mirko Babic on 2/2/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  var quiz: Quiz!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    quiz = createDummyQuiz()
    nextQuestion()
  }
  
  func nextQuestion() {
    guard let question = quiz.popQuestion() else {
      return
    }
    collectionView.reloadData()
  }
  
  private func createDummyQuiz() -> Quiz{
    let questions = createDummyQuestions()
    return Quiz(questions: questions, id: nil)
  }
  
  private func createDummyQuestions() -> [Question] {
    let answers = createDummyAnswers()
    return [Question(question: "How many legs tarantula has?", answers: answers, correctAnswers: [answers[1]], id: nil)]
  }
  
  private func createDummyAnswers() -> [Answer] {
    let answer1 = Answer(answer: "6", correct: false)
    let answer2 = Answer(answer: "8", correct: true)
    let answer3 = Answer(answer: "10", correct: false)
    return [answer1, answer2, answer3]
  }
}

extension QuizViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as! QuestionCollectionViewCell
    cell.questionLabel.text = quiz.getCurrentQuestion()!.question
    
    cell.tableView.dataSource = self
    cell.tableView.delegate = self
    cell.delegate = self
    cell.tableView.reloadData()
    
    return cell
  }
}

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quiz.getCurrentQuestion()!.getAnswers().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let answer = quiz.getCurrentQuestion()!.getAnswers()[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AnswerTableViewCell
    
    cell.answerLabel.text = answer.answer
    
    return cell
  }
}

extension QuizViewController: QuestionCollectionViewCellDelegate {
  func rightButtonPressed() {
    nextQuestion()
  }
  
  func leftButtonPressed() {
    dismiss(animated: true, completion: nil)
  }
}
