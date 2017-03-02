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
    quiz = DummyQuiz.createDummyQuiz()
    collectionView.reloadData()
    nextQuestion()
  }
  
  func nextQuestion() {
    guard let question = quiz.popQuestion() else {
      // TODO: Display results
      return
    }
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
    return quiz.getCurrentQuestion()!.answers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let answer = quiz.getCurrentQuestion()!.answers[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AnswerTableViewCell
    
    cell.answerLabel.text = answer.answer
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let question = quiz.getCurrentQuestion()!
    let answer = question.answers[indexPath.row]
    question.select(answer: answer)
    tableView.reloadData()
    if question.selectedAnswers.count > 0 {
      (currentCell as! QuestionCollectionViewCell).rightButton.isEnabled = true
    } else {
      (currentCell as! QuestionCollectionViewCell).rightButton.isEnabled = false
    }
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
