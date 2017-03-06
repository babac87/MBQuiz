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
    collectionView.reloadData()
  }
  
}

extension QuizViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return quiz.questionSequel.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch quiz.questionSequel[indexPath.row] {
    case .question:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as! QuestionCollectionViewCell
      
      cell.rightButton.isEnabled = false
      cell.topLabel.text = quiz.getCurrentQuestion()!.question
      
      cell.delegate = self
      cell.tableView.dataSource = self
      cell.tableView.delegate = self
      cell.tableView.reloadData()
      
      currentCell = cell
      return cell
    case .description:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCollectionViewCell
      cell.rightButton.isEnabled = true
      let currentQuestion = quiz.getCurrentQuestion()!
      cell.topLabel.text = currentQuestion.question
      cell.descriptionTextView.text = currentQuestion.correctAnswerDescription
      cell.delegate = self
      
      return cell
    case .result:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultsCell", for: indexPath) as! ResultsCollectionViewCell
      cell.rightButton.isEnabled = true
      cell.topLabel.text = "Results"
      cell.leftButton.isHidden = true
      cell.rightButton.setTitle("Finish", for: .normal)
      cell.delegate = self
      cell.tableView.dataSource = self
      cell.tableView.delegate = self
      cell.tableView.reloadData()
      return cell
    }
  }
}

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if currentCell is QuestionCollectionViewCell {
      return quiz.getCurrentQuestion()!.answers.count
    } else if currentCell is QuizCollectionViewCell {
      return quiz.answeredQuestions.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if currentCell is QuestionCollectionViewCell {
      let question = quiz.getCurrentQuestion()!
      let answer = question.answers[indexPath.row]
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! AnswerTableViewCell
      
      cell.answerLabel.text = answer.answer
      
      if question.selectedAnswers.contains(answer) {
        cell.checkImageView.image = #imageLiteral(resourceName: "answerbuttonselected_icon")
      } else {
        cell.checkImageView.image = #imageLiteral(resourceName: "answerbutton_icon")
      }
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell")
      cell?.textLabel?.text = quiz.answeredQuestions[indexPath.row].question
    }
    
    return UITableViewCell()
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let question = quiz.getCurrentQuestion()!
    let answer = question.answers[indexPath.row]
    question.select(answer: answer)
    tableView.reloadData()
    // FIXME: On different display sizes right button is used from next cell, so right button doesn't get enabled
    if question.selectedAnswers.count > 0 {
      (currentCell as! QuestionCollectionViewCell).rightButton.isEnabled = true
    } else {
      (currentCell as! QuestionCollectionViewCell).rightButton.isEnabled = false
    }
  }
}

extension QuizViewController: NavigationButtonsCollectionViewCellDelegate {
  func rightButtonPressed() {
    switch quiz.nextInSequel() {
    case .question:
      collectionView.scrollToItem(at: IndexPath(row: quiz.currentSequelIndex, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
      nextQuestion()
    case .description:
      collectionView.scrollToItem(at: IndexPath(row: quiz.currentSequelIndex, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
    case .result:
      collectionView.scrollToItem(at: IndexPath(row: quiz.currentSequelIndex, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
    }
  }
  
  func leftButtonPressed() {
    dismiss(animated: true, completion: nil)
  }
}
