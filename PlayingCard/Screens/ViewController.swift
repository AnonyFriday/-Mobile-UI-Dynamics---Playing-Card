
import UIKit


class ViewController: UIViewController {
    
    lazy var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: KDPlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
        }
    }
    
    @objc func nextCard() {
        if let card = deck.drawCard() {
            playingCardView.rank    = card.rank.numericOrder
            playingCardView.suit    = card.suit.rawValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            print(deck.drawCard()!)
        }
    }
}
