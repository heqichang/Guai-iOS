//
//  LLSwipeAnimatable.swift
//  Guai-iOS
//
//  Created by heqichang on 3/29/20.
//  Copyright © 2020 heqichang. All rights reserved.
//

import Foundation
import UIKit

enum LLSwipeAnimateDirection {
    case left
    case right
}

// 目录滑动动画
protocol LLSwipeAnimatable {
    
    var animateLine: UIView { get }
    
    var scrollThresholds: CGFloat { get }
    
    var itemPadding: CGFloat { get }
    
    var currentIndex: Int { get }
    
    func setActive(index: Int)
    
    func setPageOffset(_ offset: CGFloat)
    
    func nextItem() -> UIView?
    
    func currentItem() -> UIView
    
    func previousItem() -> UIView?
}


extension LLSwipeAnimatable {
    
    
    func setPageOffset(_ offset: CGFloat) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let precent = offset / screenWidth
        
        let lowerBound = floor(precent)
        let upperBound = ceil(precent)
        
        // 方向
        if self.currentIndex == Int(lowerBound) {
            
            let realPrecent = precent - lowerBound
            
            if realPrecent > 1 - self.scrollThresholds {
                
                self.setActive(index: Int(upperBound))
            } else if realPrecent < self.scrollThresholds {
                
                self.setActive(index: Int(lowerBound))
            } else {
                self.scrollAnimate(precent: realPrecent, direction: .right)
            }
            
        } else if self.currentIndex == Int(upperBound) {
            
            let realPrecent = upperBound - precent
            
            if realPrecent > 1 - self.scrollThresholds {
                self.setActive(index: Int(lowerBound))
            } else if realPrecent < self.scrollThresholds {
                self.setActive(index: Int(upperBound))
            } else {
                self.scrollAnimate(precent: realPrecent, direction: .left)
            }
            
        }
    }
    
    func scrollAnimate(precent: CGFloat, direction: LLSwipeAnimateDirection) {
        
        switch direction {
        case .left:
            self.scrollToPrevious(precent: precent)
        case .right:
            self.scrollToNext(precent: precent)
        }
    }
    
    func scrollToNext(precent: CGFloat) {
        
        guard let nextItem = self.nextItem() else {
            return
        }
        
        let activeItem = self.currentItem()
        
        if precent < 0.5 {
            let distance = nextItem.frame.maxX - activeItem.frame.maxX
            let widthAdd = distance * precent * 2
            self.animateLine.frame.size.width = activeItem.frame.width - 2 * self.itemPadding + widthAdd
        } else if precent >= 0.5 {
            
            let distance = nextItem.frame.minX - activeItem.frame.minX
            let widthMinus = distance * (precent - 0.5) * 2
            
            self.animateLine.frame.origin.x = activeItem.frame.minX + self.itemPadding + widthMinus
            self.animateLine.frame.size.width = nextItem.frame.maxX - activeItem.frame.minX - 2 * self.itemPadding - widthMinus
        }
        
    }
    
    func scrollToPrevious(precent: CGFloat) {
        
        guard let previousItem = self.previousItem() else {
            return
        }
        
        let activeItem = self.currentItem()
        

        if precent < 0.5 {
            
            let distance = activeItem.frame.minX - previousItem.frame.minX
            let widthAdd = distance * precent * 2
            self.animateLine.frame.origin.x = activeItem.frame.minX + self.itemPadding - widthAdd
            self.animateLine.frame.size.width = activeItem.frame.width - 2 * self.itemPadding + widthAdd
            
            
        } else if precent >= 0.5 {
            
            let distance = activeItem.frame.maxX - previousItem.frame.maxX
            let widthMinus = distance * (precent - 0.5) * 2
            self.animateLine.frame.size.width = activeItem.frame.maxX - previousItem.frame.minX - 2 * self.itemPadding - widthMinus
            
        }
    }
    
    
}
