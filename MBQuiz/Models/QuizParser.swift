//
//  QuizParser.swift
//  MBQuiz
//
//  Created by Mirko Babic on 3/13/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import Foundation
import Unbox

class QuizParser: NSObject {
  static func getData(fromURL url: URL, completion: @escaping (Quiz) -> ()) {
    URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      if let error = error {
        print(error)
      } else {
        // "Quizzes" should be fixed on backend
        let quizzes = try! unbox(data: data!) as [Quiz]
        DispatchQueue.main.sync {
          completion(quizzes.first!)
        }
      }
    }.resume()
  }
}
