//
//  CardModel.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 30.05.25.
//
import Foundation
import UIKit
class CardModel: UIView {
   
    private var isFaceUp: Bool = true
    private var frontView: UIImageView
    private let backView: UIImageView = UIImageView(image: UIImage(systemName: "chevron.compact.down"))
    private func flip() {
        
        let frontView = isFaceUp ? self.frontView : self.backView
        let backView = isFaceUp ? self.backView : self.frontView
        UIView.transition(from: frontView, to: backView, duration: 0.5, options: .transitionFlipFromLeft)
        isFaceUp.toggle()
        print("flipped")
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flip()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.flip()
        }
        self.removeFromSuperview()
    }
    
    init(frontImage: UIImage ) {
        self.frontView = UIImageView(image: frontImage)
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        backgroundColor = .systemTeal
        layer.cornerRadius = 10
        layer.masksToBounds = true
//        addSubview(backView)
        addSubview(frontView)
        setupLayout()
    }
   private  func setupLayout() {
        backView.frame = bounds
        frontView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
