
import UIKit


class ViewController: UIViewController {
    
    //MARK: Properties
    private lazy var deck = PlayingCardDeck()
    @IBOutlet var playingCardDeckViews: [KDPlayingCardView]! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCard(_:)))
            for card in playingCardDeckViews {
                card.addGestureRecognizer(tap)
            }
        }
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelToView()
    }
    
    
    //MARK: Synchronzie data from Model to View
    private func syncModelToView() {
        var index = 0;
        var playingCardDeck = deck.deckCards!
        while index < playingCardDeckViews.count {
            playingCardDeckViews[index].suit     = playingCardDeck[index].suit.rawValue
            playingCardDeckViews[index].rank     = playingCardDeck[index].rank.numericOrder
            playingCardDeckViews[index].isFaceUp = false
            
            //Attach Tap Gesture
            index += 1
        }
    }
    
    @objc private func didTapCard(_ gestureRecognier: UIGestureRecognizer) {
        print("Hello")
    }
}
