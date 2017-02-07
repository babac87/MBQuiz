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
  
  var currentCell: UICollectionViewCell!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    quiz = createDummyQuiz()
    collectionView.reloadData()
    nextQuestion()
  }
  
  func nextQuestion() {
    guard let question = quiz.popQuestion() else {
      return
    }
  }
  
  private func createDummyQuiz() -> Quiz{
    let questions = createDummyQuestions()
    return Quiz(questions: questions, id: nil)
  }
  
  private func createDummyQuestions() -> [Question] {
    let answers = createDummyAnswers()
    let question1 = Question(question: "How many legs tarantula has?", answers: answers, correctAnswers: [answers[1]], id: nil)
    let question2 = Question(question: "What number is 2 to the power of 3?", answers: answers, correctAnswers: [answers[1]], id: nil)
    return [question1, question2]
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
    return quiz.numberOfQuestions
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as! QuestionCollectionViewCell
    
    cell.rightButton.isEnabled = false
    cell.questionLabel.text = quiz.getCurrentQuestion()!.question
    
    cell.tableView.dataSource = self
    cell.tableView.delegate = self
    cell.delegate = self
    cell.tableView.reloadData()
    
    currentCell = cell
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    (currentCell as! QuestionCollectionViewCell).rightButton.isEnabled = true
  }
}

extension QuizViewController: NavigationButtonsCollectionViewCellDelegate {
  func rightButtonPressed() {
    if currentCell is DescriptionCollectionViewCell {
      collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
      nextQuestion()
    } else if currentCell is QuestionCollectionViewCell {
      
    }
  }
  
  func leftButtonPressed() {
    dismiss(animated: true, completion: nil)
  }
}
