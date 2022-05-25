import Foundation


extension AlphabetCoder {
    
    public enum Error: Swift.Error {
        case unknownCharacterInDecodeInput
        case cannotDecodeEmptyString
        case decodedInputStringIsTooLong
    }
}
