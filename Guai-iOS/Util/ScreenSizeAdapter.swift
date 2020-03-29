//
//  ScreenSizeAdapter.swift
//  xkb
//
//  Created by heqichang on 3/1/20.
//  Copyright © 2020 heqichang. All rights reserved.
//

import UIKit

/// 屏幕适配器，某些控件大小按比例缩放
class ScreenSizeAdapter {
    
    static func adaptNumer(_ num: CGFloat) -> CGFloat {
        
        // 以 iphone 6 375 宽度为适配基准
        let scale = UIScreen.main.bounds.width / 375
        return num * scale
    }
}
