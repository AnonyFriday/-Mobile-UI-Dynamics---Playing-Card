

import Foundation

class GameCard
{
    private var cardDeck            = PlayingCardDeck()
    private(set) var displayedCards = [PlayingCard]()
    var selectedCardsFaceUp         : [PlayingCard] {
        return displayedCards.filter { $0.isFaceUp }
    }

    enum State {
        case matched, alreadyExist, unMatched
    }
    
    
    //MARK: Intilialier
    init() {
        setDisplayCards()
        shuffleCardInDeck()
    }
    
    func selectCard(card: inout PlayingCard, completed: @escaping(State) -> Void) {
        card.isFaceUp = !card.isFaceUp
        print(card)
    }
    
    var isPairCard : Bool
    {
        return selectedCardsFaceUp.count == 2 &&
            selectedCardsFaceUp[0].suit == selectedCardsFaceUp[0].suit &&
            selectedCardsFaceUp[1].rank == selectedCardsFaceUp[1].rank
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
        
        displayedCards.removeAll()
        
        /// Handle the case of non-card in the DisplayCard
        for card in removedCardFromDisplayedCard {
            cardDeck.totalCards.append(card)
        }
        setDisplayCards(withQuantity: removedCardFromDisplayedCard.count)
    }
}

