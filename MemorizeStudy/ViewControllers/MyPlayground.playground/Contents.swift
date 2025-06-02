//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class CardModel: UIView {
   
    private var isFaceUp: Bool = true
    var frontView: UIImageView
    private let backView: UIImageView = UIImageView(image: UIImage(systemName: "chevron.compact.down"))

    override init(frame: CGRect) {
        fatalError("Use init(frontImage:frame:) instead")
    }
    
    init(frontImage: UIImage, frame: CGRect ) {
        self.frontView = UIImageView(image: frontImage)
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .lightGray
        
        // Configure views
        frontView.contentMode = .scaleAspectFit
        backView.contentMode = .scaleAspectFit
        backView.tintColor = .black

        // Add both views
        addSubview(frontView)
        addSubview(backView)
        
        setupLayout()
        updateViewVisibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        frontView.frame = bounds
        backView.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func updateViewVisibility() {
        frontView.isHidden = !isFaceUp
        backView.isHidden = isFaceUp
    }
    
    func flip() {
        let fromView = isFaceUp ? frontView : backView
        let toView = isFaceUp ? backView : frontView
        let options: UIView.AnimationOptions = .transitionFlipFromLeft
        
        UIView.transition(from: fromView, to: toView, duration: 0.2, options: [options, .showHideTransitionViews]) { _ in
            self.isFaceUp.toggle()
            self.updateViewVisibility()
        }
        print("flipped")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flip()
    }
}

// Create two cards
let card1 = CardModel(frontImage: UIImage(systemName: "moon")!, frame: CGRect(x: 0, y: 0, width: 200, height: 200))
let card2 = CardModel(frontImage: UIImage(systemName: "cross")!, frame: CGRect(x: 0, y: 0, width: 200, height: 200))

// Arrange in stack view
let stackView = UIStackView(arrangedSubviews: [card1/*, card2*/])
stackView.bounds = CGRect(x: 0, y: 0, width: 400, height: 400)
stackView.axis = .horizontal
stackView.distribution = .equalSpacing
stackView.alignment = .center
//stackView.spacing = 20

PlaygroundPage.current.liveView = stackView


