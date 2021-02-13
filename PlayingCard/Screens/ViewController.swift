
import UIKit


class ViewController: UIViewController {
    
    enum State {
        case matched, unmatched, alreadyExist
    }
    
    
    
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
    
    
    
    //MARK: Gesture Animator
    private lazy var animator = UIDynamicAnimator(referenceView: self.view)
    

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelToView()
    }
    
    
    //MARK: Synchronzie data from Model to View
    private func syncModelToView() {
        var index = 0
        while index < gameCard.displayedCards.count {
            
            playingCardDeckViews[index].suit     = gameCard.displayedCards[index].suit.rawValue
            playingCardDeckViews[index].rank     = gameCard.displayedCards[index].rank.numericOrder
            playingCardDeckViews[index].isFaceUp = gameCard.displayedCards[index].isFaceUp

            //Attach Tap Gesture
            index += 1
        }
    }
    
    
    
    private var faceUpCardViews: [KDPlayingCardView] {
        return playingCardDeckViews.filter { $0.isFaceUp && !$0.isHidden}
    }
    
    private var faceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 &&
        faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
        faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    //MARK: Methods
    @objc private func didTapCard(_ gestureRecognier: UIGestureRecognizer) {
        switch gestureRecognier.state {
            case .ended:
                print(faceUpCardViews.description)
                if let playingCardView = gestureRecognier.view as? KDPlayingCardView, faceUpCardViews.count < 2
                {
                    //MARK: -- Flip the Card
                    UIView.transition(with: playingCardView, duration: 0.6, options: .transitionFlipFromRight) {
                        playingCardView.isFaceUp = !playingCardView.isFaceUp
                    } completion: { [self] (finished) in
                        let cardsToAnimate = self.faceUpCardViews
                        
                        // Matched
                        if self.faceUpCardViewsMatch {
                            for cardView in cardsToAnimate {
                                cardView.animate([.zoom(duration: 0.6, sx: 3.0, sy: 3.0)])
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    cardView.animate(inParallel:
                                                        [.zoom(duration: 0.6, sx: 0.1, sy: 0.1),
                                                         .fadeOut(duration: 0.6)])
                                }
                               
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    cardView.isHidden  = true
                                    cardView.alpha     = 1
                                    cardView.transform = .identity
                                }
                            }
                            
                            // Unmatched
                        } else if cardsToAnimate.count == 2 {
                            for cardView in cardsToAnimate {
                                UIView.transition(with: cardView, duration: 0.6, options: .transitionFlipFromLeft) {
                                    cardView.isFaceUp = false
                                } completion: { (finished) in
                                    
                                }

                            }
                        }
                        
                        // Already exist
                        else {
                            
                        }
                        
                    }

                    
                }
                
            default: break;
        }
    }
}
