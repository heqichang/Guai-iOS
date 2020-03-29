//
//  CGFloatExtension.swift
//  xkb
//
//  Created by heqichang on 3/2/20.
//  Copyright © 2020 heqichang. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    var fit: CGFloat {
        get {
            return ScreenSizeAdapter.adaptNumer(self)
        }
    }
}

/// 整数字面量
extension Int {
    
    var fit: CGFloat {
        get {
            return ScreenSizeAdapter.adaptNumer(CGFloat(self))
        }
    }
}

