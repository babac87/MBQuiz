//
//  Extensions.swift
//  MBQuiz
//
//  Created by Mirko Babic on 3/14/17.
//  Copyright © 2017 Happy Boar. All rights reserved.
//

import UIKit

extension UIView {
  func round() {
    layer.cornerRadius = self.frame.size.width / 2.0
    layer.masksToBounds = layer.cornerRadius > 0
  }
}
