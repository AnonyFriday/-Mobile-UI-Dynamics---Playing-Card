

import Foundation

class GameCard
{
    private var cardDeck            = PlayingCardDeck()
    private(set) var displayedCards = [PlayingCard]()
    var selectedCards               = [PlayingCard]()
    
    init() {
        setDisplayCards()
        shuffleCardInDeck()
    }
    
    
    func setDisplayCards(withQuantity quantity: Int = 12) {
        for _ in 0..<((quantity + 1) / 2) {
            let matchedCard = cardDeck.drawRandomCard()!
            displayedCards += [matchedCard, matchedCard]
        }
    }
    
    func shuffleCardInDeck(){
        guard !displayedCards.isEmpty else { return }
        
        let removedCardFromDisplayedCard = displayedCards
        
        selectedCards.removeAll()
        displayedCards.removeAll()
        
        for card in removedCardFromDisplayedCard {
            cardDeck.totalCards.append(card)
        }
        setDisplayCards(withQuantity: removedCardFromDisplayedCard.count)
    }
}