//
//  FullScreenAdapter.swift
//  xkb
//
//  Created by heqichang on 2/26/20.
//  Copyright © 2020 heqichang. All rights reserved.
//

import Foundation
import UIKit

/// 判断是否全面屏的
class FullScreenAdapter {
    
    static var isFullScreen: Bool {
        return UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 896
    }
    
    static var bottomAddedHeight: CGFloat {
        return isFullScreen ? 34 : 0
    }
    
    static var tabBarHeight: CGFloat {
        return bottomAddedHeight + 49
    }
    
    static var topAddedHeight: CGFloat {
        return isFullScreen ? 24 : 0
    }
    
    static var statusBarHeight: CGFloat {
        return isFullScreen ? 44 : 20
    }
    
    static var navigationBarHeight: CGFloat {
        return statusBarHeight + 44
    }
    
}
