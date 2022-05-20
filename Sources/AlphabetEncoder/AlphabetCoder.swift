import Foundation


public struct AlphabetCoder {
    public typealias Alphabet = [Character]
    
    
    public private(set) var base: Int
    
    
    public var alphabet: [Character] {
        didSet {
            self.base = alphabet.count
        }
    }
    
    
    public init(
        alphabet: [Character] = Alphabets.base62
    ) {
        self.alphabet = alphabet
        self.base = alphabet.count
    }
    
    
    public func encode(integer: Int) throws -> String {
        guard integer >= 0 else {
            throw Error.negativeIntegerArgument
        }
        
        // base case
        if integer < base {
            return String(alphabet[integer])
        }
        
        // recursion
        let firstPart = try encode(integer: integer / base)
        let secondPart = String(alphabet[integer % base])
        
        return "\(firstPart)\(secondPart)"
    }
}


// MARK: - Decoding
extension AlphabetCoder {
    
    public func decode(string: String) throws -> Int {
        string
            .reversed()
            .enumerated()
            .reduce(0) { accumulatedValue, enumerationInfo in
                let (characterPosition, currentCharacter) = enumerationInfo
                
                guard let alphabetIndex = alphabet.firstIndex(of: currentCharacter) else {
                    return accumulatedValue
                }
                
                let indexScale = Int(
                    pow(Double(base), Double(characterPosition))
                )
                
                let nextValue = alphabetIndex * indexScale
                
                return accumulatedValue + nextValue
            }
    }
    
}


extension AlphabetCoder {
    
    public enum Error: Swift.Error {
        case negativeIntegerArgument
    }
}
