
import Foundation

struct PlayingCard : CustomStringConvertible, Hashable
{
    static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.rank == lhs.rank && lhs.suit == rhs.suit
    }
    
    var rank: Rank
    var suit: Suit
    var isFaceUp: Bool = false
    
    enum Suit: String, CustomStringConvertible, Hashable
    {
        case hearts     = "♥️"
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
    
    
    enum Rank: CustomStringConvertible, Hashable
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
        
        
        var numericOrder: Int {
            switch self {
                case .ace: return 1
                case .numeric(pipsCount: let pips): return pips
                case .face(let face) where face == "J": return 11
                case .face(let face) where face == "Q": return 12
                case .face(let face) where face == "K": return 13
                default: return 0
            }
        }
    }
    
    var description: String {
        return "\(rank) \(suit) \(isFaceUp)"
    }

}
