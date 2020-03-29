//
//  LLSwipeAnimatable-Sample.swift
//  Guai-iOS
//
//  Created by heqichang on 3/29/20.
//  Copyright © 2020 heqichang. All rights reserved.
//

import UIKit

class LLSwipeAnimatable_Sample: UIView {

    var tapAction: ((Int) -> Void)?
    
    fileprivate enum Metric {
        static let sectionHeight = 12 + 21.fit + 12 // 高度
        static let buttonPadding: CGFloat = 15 // 按钮的内边距
    }
    
    fileprivate enum Style {
        static let normalButtonTextFont = UIFont.systemFont(ofSize: 15.fit)
        static let normalButtonTextColor = Constant.Color.secondaryTextColor
        static let activeButtonTextFont = UIFont.systemFont(ofSize: 15.fit, weight: .semibold)
        static let activeButtonTextColor = Constant.Color.level1TextColor
    }
    
    fileprivate var buttons: [UIButton] = []
    fileprivate let activeLine = UIView()

    fileprivate var buttonTextWidth: CGFloat = 0
    
    fileprivate var activeIndex = -1 {
        didSet {
            self.tapAction?(self.activeIndex)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - LLSwipeAnimatable -
extension LLSwipeAnimatable_Sample: LLSwipeAnimatable {
    
    var animateLine: UIView {
        return self.activeLine
    }
    
    var currentIndex: Int {
        return self.activeIndex
    }
    
    var scrollThresholds: CGFloat {
        return 0.05
    }
    
    var itemPadding: CGFloat {
        return Metric.buttonPadding
    }
    
    func nextItem() -> UIView? {
        guard self.activeIndex + 1 < self.buttons.count else {
            return nil
        }
        
        return self.buttons[self.activeIndex + 1]
    }
    
    func currentItem() -> UIView {
        return self.buttons[self.activeIndex]
    }
    
    func previousItem() -> UIView? {
        guard self.activeIndex - 1 >= 0 else {
            return nil
        }
        
        return self.buttons[self.activeIndex - 1]
    }
    
    func setActive(index: Int) {
        
        guard index < self.buttons.count else {
            return
        }
        
        if index == self.currentIndex {
            return
        }
        
        self.buttons.forEach {
            $0.titleLabel?.font = Style.normalButtonTextFont
            $0.setTitleColor(Style.normalButtonTextColor, for: .normal)
        }
        self.buttons[index].titleLabel?.font = Style.activeButtonTextFont
        self.buttons[index].setTitleColor(Style.activeButtonTextColor, for: .normal)
        self.activeLine.frame.origin.x = self.buttons[index].frame.origin.x + Metric.buttonPadding
        self.activeLine.frame.size.width = self.buttons[index].frame.size.width - 2 * Metric.buttonPadding
        self.activeIndex = index
    }
}

// MARK: - private -
private extension LLSwipeAnimatable_Sample {
    
    func setupSubviews() {
        
        let buttonTexts = ["微博", "评论", "赞过", "话题"]
        
        self.buttonTextWidth = NSString(string: "微博")
        .boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 40),
                      options: [.usesFontLeading, .usesLineFragmentOrigin],
                      attributes: [NSAttributedString.Key.font: Style.normalButtonTextFont],
                      context: nil).width
        
        let buttonView = UIView()
        buttonView.backgroundColor = .clear
        
        self.addSubview(buttonView)
        buttonView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(8 * Metric.buttonPadding + 4 * self.buttonTextWidth)
        }
        
        var startX: CGFloat = 0
        let buttonWidth: CGFloat = 2 * Metric.buttonPadding + self.buttonTextWidth
        for (index, item) in buttonTexts.enumerated() {
            
            let button = UIButton(type: .custom)
            button.tag = index
            button.setTitle(item, for: .normal)
            button.setTitleColor(Style.normalButtonTextColor, for: .normal)
            button.titleLabel?.font = Style.normalButtonTextFont
            button.addTarget(self, action: #selector(buttonDidTouch(_:)), for: .touchUpInside)
            button.frame = CGRect(x: startX, y: 0, width: buttonWidth, height: Metric.sectionHeight)
            buttonView.addSubview(button)
            self.buttons.append(button)
        
            startX += buttonWidth
        }
        
        self.activeLine.backgroundColor = Constant.Color.mainColor
        self.activeLine.layer.cornerRadius = 1.5
        self.activeLine.frame = CGRect(x: 0, y: Metric.sectionHeight - 7, width: 0, height: 3)
        buttonView.addSubview(self.activeLine)
        
        self.setActive(index: 0)
    }
    
    @objc func buttonDidTouch(_ sender: UIButton) {
        self.setActive(index: sender.tag)
    }
    
}
