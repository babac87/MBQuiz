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
    quiz.nextQuestion()
    collectionView.reloadData()
  }
}

extension QuizViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return quiz.questionSequel.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch quiz.currentSequelType {
    case .question:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as! QuestionCollectionViewCell
      cell.rightButton.isEnabled = false
      cell.topLabel.text = quiz.currentQuestion?.question ?? "Results"
      
      cell.delegate = self
      cell.tableView.dataSource = self
      cell.tableView.delegate = self
      cell.tableView.reloadData()
      
      return cell
    case .description:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCollectionViewCell
      cell.rightButton.isEnabled = true
      let currentQuestion = quiz.currentQuestion!
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView is UICollectionView {
      collectionView.reloadData()
      //      switch quiz.questionSequel[quiz.currentSequelIndex] {
      //      case .question:
      //        collectionView.reloadData()
      //      case .description:
      //        collectionView.scrollToItem(at: IndexPath(row: quiz.currentSequelIndex, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
      //      case .result:
      //        collectionView.scrollToItem(at: IndexPath(row: quiz.currentSequelIndex, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
      //        quiz.questionAnswered()
      //      }
    }
  }
}

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if quiz.currentSequelType == .question {
      return quiz.currentQuestion!.answers.count
    } else {
      return quiz.answeredQuestions.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch quiz.currentSequelType {
    case .question:
      let question = quiz.currentQuestion!
      let answer = question.answers[indexPath.row]
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as! AnswerTableViewCell
      
      cell.answerLabel.text = answer.answer
      
      if question.selectedAnswers.contains(answer) {
        cell.checkImageView.image = #imageLiteral(resourceName: "answerbuttonselected_icon")
      } else {
        cell.checkImageView.image = #imageLiteral(resourceName: "answerbutton_icon")
      }
      return cell
    case .result:
      /// HOT FIX - Even though collectionView loads this tableView for results it tries to modify earlier collectionViewCells tableView and app crashes
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") else {
        return UITableViewCell()
      }
      let question = quiz.answeredQuestions[indexPath.row]
      cell.textLabel?.text = question.question
      cell.accessoryView = UIImageView(image: question.answeredCorrectly ? #imageLiteral(resourceName: "correct_icon") : #imageLiteral(resourceName: "false_icon"))
      return cell
    default:
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if quiz.currentSequelType == .question {
      tableView.deselectRow(at: indexPath, animated: false)
      let question = quiz.currentQuestion!
      let answer = question.answers[indexPath.row]
      question.select(answer: answer)
      tableView.reloadData()
      let currentCell = collectionView.cellForItem(at: IndexPath(row: quiz.currentSequelIndex, section: 0)) as! QuizCollectionViewCell
      if question.selectedAnswers.count > 0 {
        currentCell.rightButton.isEnabled = true
      } else {
        currentCell.rightButton.isEnabled = false
      }
    }
  }
}

extension QuizViewController: NavigationButtonsCollectionViewCellDelegate {
  func rightButtonPressed() {
    guard let nextInSequel = quiz.nextInSequel() else {
      dismiss(animated: true, completion: nil)
      return
    }
    switch nextInSequel {
    case .question:
      quiz.questionAnswered()
      quiz.nextQuestion()
    case .description:
      break
    case .result:
      quiz.questionAnswered()
    }
    collectionView.scrollToItem(at: IndexPath(row: quiz.currentSequelIndex, section: 0), at: UICollectionViewScrollPosition.right, animated: true)
  }
  
  func leftButtonPressed() {
    dismiss(animated: true, completion: nil)
  }
}
