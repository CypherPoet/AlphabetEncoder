import Foundation


public struct AlphabetCoder {
    public typealias Alphabet = [Character]
    public typealias EncodingInput = UInt64
    public typealias EncodingOutput = String
    public typealias DecodingInput = EncodingOutput
    public typealias DecodingOutput = EncodingInput
    
    
    public private(set) var base: UInt64
    
    
    public var alphabet: Alphabet {
        didSet {
            self.base = UInt64(alphabet.count)
        }
    }
    
    
    /// The maximum length of a string that can be used for decoding.
    ///
    /// Passing a string that's too long will encode to a value that overflows
    /// the `.max` for the ``EncodingInput``.
    public var maxDecodingStringLength: Int {
        encode(EncodingInput.max).count
    }
    
    
    public init(
        alphabet: Alphabet
    ) {
        self.alphabet = alphabet
        self.base = UInt64(alphabet.count)
    }
    
    
    public func encode(_ integer: EncodingInput) -> EncodingOutput {
        // base case
        if integer < base {
            return String(alphabet[Int(integer)])
        }
        
        // recursion
        let firstPart = encode(integer / base)
        let alphabetIndex = Int(integer % base)
        let secondPart = String(alphabet[alphabetIndex])
        
        return "\(firstPart)\(secondPart)"
    }
}


// MARK: - Decoding
extension AlphabetCoder {
    
    public func decode(_ string: DecodingInput) throws -> DecodingOutput {
        guard string.isEmpty == false else {
            throw Error.cannotDecodeEmptyString
        }
        
        guard string.count <= maxDecodingStringLength else {
            throw Error.decodedInputStringIsTooLong
        }

        return try string
            .reversed()
            .enumerated()
            .reduce(DecodingOutput(0)) { accumulatedValue, enumerationInfo in
                let (characterPosition, currentCharacter) = enumerationInfo
                
                guard let alphabetIndex = alphabet
                    .firstIndex(of: currentCharacter)
                else {
                    throw Error.unknownCharacterInDecodeInput
                }
                
                let alphabetIndexScale = DecodingOutput(
                    pow(Double(base), Double(characterPosition))
                )
                
                let incrementationAmount = alphabetIndexScale * DecodingOutput(alphabetIndex)
                
                return accumulatedValue + incrementationAmount
            }
    }
}
