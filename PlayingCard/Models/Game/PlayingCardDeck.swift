



import UIKit

class PlayingCardDeck
{
    //MARK: Properties
    var totalCards = [PlayingCard]()
    
    
    //MARK: Initializer
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                totalCards.append(.init(rank: rank, suit: suit))
            }
        }
    }
    
    
    //MARK: Draw Random Card
    func drawRandomCard() -> PlayingCard? {
        if totalCards.count > 0 {
            return totalCards.remove(at: totalCards.count.arc4random)
        } else {
            return nil
        }
    }
}




