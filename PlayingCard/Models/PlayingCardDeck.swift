



import UIKit

struct PlayingCardDeck
{
    
    private var totalCards = [PlayingCard]()
    var deckCards : [PlayingCard]! {
        mutating get {
            var cardHolder = [PlayingCard]()
            for _ in 0..<totalCards.count {
                let randomCard = drawRandomCard()!
                cardHolder += [randomCard, randomCard]
            }
            return cardHolder
        }
    }
    
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                totalCards.append(.init(rank: rank, suit: suit))
            }
        }
    }
    
    
    mutating func drawRandomCard() -> PlayingCard? {
        if totalCards.count > 0 {
            return totalCards.remove(at: totalCards.count.arc4random)
        } else {
            return nil
        }
    }
}




