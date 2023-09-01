//
//  UIProgressView+Additionals.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 02/09/23.
//

import UIKit

extension UIProgressView {
    func increaseSizeBy(x: CGFloat = 1, y: CGFloat = 2) {
        self.transform = self.transform.scaledBy(x: x, y: y)
    }
}
