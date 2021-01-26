
import Foundation

struct PlayingCard : CustomStringConvertible
{
    var rank: Rank
    var suit: Suit
    
    
    enum Suit: String, CustomStringConvertible
    {
        case hearts     = "❤️"
        case spades     = "♠️"
        case clubs      = "♣️"
        case diamonds   = "♦️"
        
        static var all: [Suit] {
            return [.clubs,.diamonds,.hearts,.spades]
        }
        
        var description: String {
            return rawValue
        }
    }
    
    
    enum Rank: CustomStringConvertible
    {
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
        
        var description: String {
            switch self {
                case .ace:
                    return "A"
                case .face(let kind):
                    return kind
                case .numeric(pipsCount: let pipsCount):
                    return "\(pipsCount)"
            }
        }
    }
    
    var description: String {
        return "\(rank) \(suit)"
    }

}
