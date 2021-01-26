
import Foundation

struct PlayingCard : CustomStringConvertible {
    var description: String {
        return "\(rank) \(suit)"
    }
    
    var rank: Rank
    var suit: Suit
    
    enum Suit: String {
        case hearts = "❤️"
        case spades = "♠️"
        case clubs  = "♣️"
        case diamonds = "♦️"
        
        static var all: [Suit] {
            return [.clubs,.diamonds,.hearts,.spades]
        }
    }
    
    
    enum Rank {
        case ace
        case face(String)
        case numeric(pipsCount: Int)
        
        static var all: [Rank] {
            var all : [Rank] = [.ace]
            for num in 2...10 {
                all.append(.numeric(pipsCount: num))
            }
            all += [.face("J"), .face("Q"), .face("K")]
            return all
        }
    }

}
