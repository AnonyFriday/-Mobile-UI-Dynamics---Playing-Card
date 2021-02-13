
import UIKit


class ViewController: UIViewController {
    
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
    
    
    
    private
    

    
    //MARK: Methods
    @objc private func didTapCard(_ gestureRecognier: UIGestureRecognizer) {
        switch gestureRecognier.state {
            case .ended:
                if let playingCardView = gestureRecognier.view as? KDPlayingCardView,
                   let index = playingCardDeckViews.firstIndex(of: playingCardView)
                {
                    var card  = gameCard.displayedCards[index]
                    
                }
                
            default: break;
        }
    }
}
