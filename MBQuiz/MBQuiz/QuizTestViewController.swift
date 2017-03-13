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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let quiz = DummyQuiz.createDummyQuiz()
    let vc = storyboard.instantiateViewController(withIdentifier: "QuizVC") as! QuizViewController
    vc.quiz = quiz
    present(vc, animated: true, completion: nil)
  }
}
