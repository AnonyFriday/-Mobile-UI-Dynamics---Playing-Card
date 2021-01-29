
import UIKit


class ViewController: UIViewController {
    
    lazy var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: KDPlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCardSwipeGesture))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(KDPlayingCardView.adjustFaceCardScale(byHandlingGestureRecoginizedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    //MARK: Swipe Gesture, Converting Model to the view
    @objc func nextCardSwipeGesture() {
        if let card = deck.drawCard() {
            playingCardView.rank    = card.rank.numericOrder
            playingCardView.suit    = card.suit.rawValue
        }
    }
    
    @IBAction func flipOverCardTapGesture(_ sender: UITapGestureRecognizer) {
        playingCardView.isFaceUp = !playingCardView.isFaceUp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
