//
//  CardModel.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 30.05.25.
//
import Foundation
import UIKit
class CardModel: UIView {
    weak var delegate: GameViewController?
    private var isFaceUp: Bool = true
    private let frontView: UIImageView = UIImageView(image: UIImage(systemName: "chevron.compact.down"))
    let backView: UIImageView
    func flip(completion: (() -> Void)?) {
        
        let frontView = isFaceUp ? self.frontView : self.backView
        let backView = isFaceUp ? self.backView : self.frontView
        UIView.transition(from: frontView, to: backView, duration: 0.5, options: .transitionFlipFromLeft, completion: {finished in completion?()})
        isFaceUp.toggle()
        print("flipped")
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isFaceUp { flip(completion: writeCard) }
        
    }
    
    init(frontImage: UIImage? ) {
        self.backView = UIImageView(image: frontImage)
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        backgroundColor = .systemTeal
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.shadowOpacity = 0.5
        self.contentMode = .scaleAspectFit
//        addSubview(backView)
        addSubview(frontView)
    }
    func setupLayout() {
        backView.contentMode = .scaleAspectFit
        frontView.contentMode = .scaleAspectFit
        backView.frame = bounds
        frontView.frame = bounds
        backView.layer.shadowOpacity = 0.5
        frontView.layer.shadowOpacity = 0.5
    }
    func writeCard(){
        if delegate?.firstCard == nil {
            delegate?.firstCard = self
        } else if delegate?.secondCard == nil {
            delegate?.secondCard = self
            delegate?.checkCards()
        }
        else {
            delegate?.firstCard = self
            delegate?.secondCard = nil
        }
    }
    func disappear() {
        let animations: () -> Void = {
            self.alpha = 0
            self.bounds.size = CGSize(width: 0, height: 0)
            self.transform = CGAffineTransformMakeRotation(.pi)
        }
        UIView.animate(withDuration: 0.5, animations: animations, completion: {finished in self.removeFromSuperview()})
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
