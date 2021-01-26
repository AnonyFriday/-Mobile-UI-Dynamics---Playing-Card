
import UIKit


class ViewController: UIViewController {
    
    lazy var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            print(deck.drawCard()!)
        }
    }
}
