//
//  QuizTestViewController.swift
//  MBQuiz
//
//  Created by Mirko Babic on 3/13/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

class QuizTestViewController: UIViewController {
  
  @IBAction func startQuiz(_ sender: Any) {
    let url = URL(string: "http://devmobile.oroundocms.com/api/quizzes/all?poi_id=50&language_id=2")!
    Quiz.getQuizData(from: url) { (quiz: Quiz) in
      let storyboard = UIStoryboard(name: "Quiz", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "QuizVC") as! QuizViewController
      vc.quiz = quiz
      self.present(vc, animated: true, completion: nil)
    }
  }
}
