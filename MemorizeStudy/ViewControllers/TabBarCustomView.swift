//
//  TabBarCustomView.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 24.06.25.
//

import UIKit

class TabBarCustomView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect , buttons: [UIButton]) {
        stackView.addArrangedSubview(UIView())
        for button in buttons {
            button.tintColor = .darkGray
            stackView.addArrangedSubview(button)
        }
        stackView.addArrangedSubview(UIView())
        super.init(frame: frame)
        self.backgroundColor = .clear
        stackView.frame = self.bounds
        addSubview(stackView)
        self.layer.borderColor = UIColor.black.cgColor
    }
    override func draw(_ rect: CGRect) {
        // Drawing code
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 30, y: 0,
                                                          width: self.frame.width - 60,
                                                          height: self.bounds.height),cornerRadius: self.bounds.height / 2)
        bezierPath.close()
        UIColor.white.setFill()
        bezierPath.fill()
    }
    
}
