//
//  NSObject+Extension.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 21.02.2024.
//

import UIKit

extension NSObject {
    func adaptiveSize(for size: CGFloat) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        let baseSize = CGSize(width: 375, height: 812)
        let scale = min(screenSize.width, screenSize.height) / min(baseSize.width, baseSize.height)
        
        return size * scale
    }
    func adaptiveHeight(for height: CGFloat) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let baseHeight = 812.0 // iPhone 13 Pro Max reference height
        let ratio = height / baseHeight
        return screenHeight * ratio
      }
}
