
import UIKit


class ViewController: UIViewController {
    
    private lazy var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: KDPlayingCardView! {
        didSet {
            let tap = UITapGestureRecognizer(target: playingCardView, action: #selector(KDPlayingCardView.flipCard))
            playingCardView.addGestureRecognizer(tap)
            
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(KDPlayingCardView.scaleCardImageOfFaceType(byApplyingGestureRecogniter:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    
    @IBAction func nextCardSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        sender.direction = [.left,.right]
        
        if let newCard = deck.drawCard() {
            playingCardView.suit    = newCard.suit.rawValue
            playingCardView.rank    = newCard.rank.numericalRank
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
