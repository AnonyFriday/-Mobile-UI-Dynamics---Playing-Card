
import UIKit


class PlayingCardScreen: UIViewController {
    
    //MARK: Dynamic Animator
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    private lazy var compositesBehavior = DynamicAnimator(animator: animator)
    
    
    //MARK: Properties
    private lazy var gameCard = GameCard()
    @IBOutlet var playingCardDeckViews: [KDPlayingCardView]! {
        didSet {
            for card in playingCardDeckViews {
                let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCard(_:)))
                card.addGestureRecognizer(tap)
            }
        }
    }
    
    
    
    
    

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.description)
        syncModelToView()
    }
    
    
    //MARK: Synchronzie data from Model to View
    private func syncModelToView() {
        var index = 0
        while index < gameCard.displayedCards.count {
            
            playingCardDeckViews[index].suit     = gameCard.displayedCards[index].suit.rawValue
            playingCardDeckViews[index].rank     = gameCard.displayedCards[index].rank.numericOrder
            playingCardDeckViews[index].isFaceUp = gameCard.displayedCards[index].isFaceUp
            compositesBehavior.addItem(item: playingCardDeckViews[index])
            //Attach Tap Gesture
            index += 1
        }
    }
    
    
    
    private var faceUpCardViews: [KDPlayingCardView] {
        return playingCardDeckViews.filter { $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0) && $0.alpha == 1}
    }
    
    private var faceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 &&
        faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
        faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    private var lastChosenCard: KDPlayingCardView?
    
    //MARK: Methods
    @objc private func didTapCard(_ gestureRecognier: UIGestureRecognizer) {
        switch gestureRecognier.state {
            case .ended:
                if let playingCardView = gestureRecognier.view as? KDPlayingCardView, faceUpCardViews.count < 2
                {
                    //MARK: -- Flip the Card
                    UIView.transition(with: playingCardView, duration: 1, options: .transitionFlipFromRight) {
                        playingCardView.isFaceUp = !playingCardView.isFaceUp
                        
                    } completion: { [self] (finished) in
                        let cardsToAnimate = self.faceUpCardViews
                        
                        // Matched
                        if self.faceUpCardViewsMatch {
                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0.2, options: .curveEaseInOut) {
                                for cardView in cardsToAnimate {
                                    cardView.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
                                }
                            } completion: { (finished) in
                                
                                UIView.animate(withDuration: 0.75) {
                                    for cardView in cardsToAnimate {
                                        cardView.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)
                                        cardView.alpha     = 0.0
                                    }
                                } completion: { (finished) in
                                    
                                    for cardView in cardsToAnimate {
                                        cardView.isHidden = true
                                        cardView.alpha    = 1.0
                                        cardView.transform = .identity
                                    }
                                }
                            }

                            // Unmatched
                        } else if cardsToAnimate.count == 2 {
                            for cardView in cardsToAnimate {
                                UIView.transition(with: cardView, duration: 2, options: .transitionFlipFromLeft) {
                                    cardView.isFaceUp = false
                                } completion: { (finished) in
                                    
                                }
                            }
                        }
                        
                        
                        else {
                            
                        }
                        
                    }

                    
                }
                
            default: break;
        }
    }
}
