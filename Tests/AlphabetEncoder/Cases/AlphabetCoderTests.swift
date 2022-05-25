import XCTest
import AlphabetEncoder


final class AlphabetCoderTests: XCTestCase {
    private typealias SystemUnderTest = AlphabetCoder

    private var sut: SystemUnderTest!
    private var customAlphabet: SystemUnderTest.Alphabet!
}


// MARK: - Lifecycle
extension AlphabetCoderTests {

    override func setUp() async throws {
        // Put setup code here.
        // This method is called before the invocation of each
        // test method in the class.

        try await super.setUp()

        customAlphabet = Alphabets.base62
    }


    override func tearDown() async throws {
        // Put teardown code here.
        // This method is called after the invocation of each
        // test method in the class.

        try await super.tearDown()

        customAlphabet = nil
        sut = nil
    }
}


// MARK: - Factories
extension AlphabetCoderTests {

    private func makeSUT() -> SystemUnderTest {
        .init(
            alphabet: customAlphabet
        )
    }
}


// MARK: - Test - Init with Custom Arguments
extension AlphabetCoderTests {

    func test_Init_ItSetsTheProvidedBaseAlphabet() async throws {
        customAlphabet = ["S", "W", "I", "F", "T", "🏎"]
        sut = makeSUT()
        
        XCTAssertEqual(sut.alphabet, customAlphabet)
    }
    

    func test_Init_ItSetsTheBaseAccordingToTheSizeOfTheAlphabet() async throws {
        customAlphabet = ["S", "W", "I", "F", "T"]
        sut = makeSUT()
        
        XCTAssertEqual(sut.base, UInt64(customAlphabet.count))
        
        sut.alphabet.append("🏎")
        
        XCTAssertEqual(sut.base, UInt64(customAlphabet.count + 1))
    }
}


// MARK: - Test - Encoding
extension AlphabetCoderTests {
    
    func test_Encoding_WhenEncodingIntegerSmallerThanTheAlphabetBase_ItComputesASingleCharacterAtTheAlphabetIndexPositionOfTheInteger() async throws {
        sut = makeSUT()
        
        let input = AlphabetCoder.EncodingInput(2)
        let expected = String(customAlphabet[Int(input)])
        let actual = try sut.encode(input)
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_Encoding_WhenEncodingZero_ItEncodesToTheFirstElementOfTheBaseAlphabet() async throws {
        sut = makeSUT()
        
        let input = AlphabetCoder.EncodingInput(0)
        let expected = String(try XCTUnwrap(customAlphabet.first))
        let actual = try sut.encode(input)
        
        XCTAssertEqual(actual, expected)
    }
    

    func test_MeasureEncoding_WithBase62Alphabet() async throws {
        sut = makeSUT()

        let testIntegers = Array(repeating: AlphabetCoder.EncodingInput(100), count: 1000)
        
        measure {
            for integer in testIntegers {
                let _ = try! sut.encode(integer)
            }
        }
    }
}



// MARK: - Test - Decoding
extension AlphabetCoderTests {

    func test_Decoding_WhenDecodingValidInput_ItComputesTheInverseOfTheInputsEncodedValue() async throws {
        
        for alphabet in [
            Alphabets.base62,
            Alphabets.base62,
        ] {
            customAlphabet = alphabet
            sut = makeSUT()

            for expectedOutput in (1...20).map({ _ in
                AlphabetCoder.EncodingInput.random(in: 0...100_000)
            }) {
                let input = try sut.encode(expectedOutput)
                let actual = try sut.decode(input)

                XCTAssertEqual(actual, expectedOutput)
            }
        }
    }
    
    
    func test_Decoding_WhenStringContainsCharacterNotInAlphabet_ItThrowsAnError() async throws {
        sut = makeSUT()
        
        let input = "🦄"
        let expectedError = SystemUnderTest.Error.unknownCharacterInDecodeInput
        
        do {
            let _ = try sut.decode(input)
            XCTFail("Error should be thrown before reaching this line")
        } catch let error as SystemUnderTest.Error {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Unknown Error was thrown")
        }
    }
    

    func test_Decoding_WhenStringIsEmpty_ItThrowsAnError() async throws {
        sut = makeSUT()
        
        let input = ""
        let expectedError = SystemUnderTest.Error.cannotDecodeEmptyString
        
        do {
            let _ = try sut.decode(input)
            XCTFail("Error should be thrown before reaching this line")
        } catch let error as SystemUnderTest.Error {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Unknown Error was thrown")
        }
    }
    
    
    func test_Decoding_WhenStringIsTooLong_ItThrowsAnErrorForInputBeingTooLong() async throws {
        sut = makeSUT()
        
        let input = try sut.encode(SystemUnderTest.EncodingInput.max) + "0"
        let expectedError = SystemUnderTest.Error.decodedInputStringIsTooLong
        
        do {
            let _ = try sut.decode(input)
            XCTFail("Error should be thrown before reaching this line")
        } catch let error as SystemUnderTest.Error {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Unknown Error was thrown")
        }
    }
    
    
    func test_MeasureDecoding_GivenBase62Alphabet_WhenDecodingString() async throws {
        sut = makeSUT()

        let baseInput = AlphabetCoder.DecodingInput("AAAA")
        let testInputs = Array(repeating: baseInput, count: 1000)
        
        measure {
            for input in testInputs {
                let _ = try! sut.decode(input)
            }
        }
    }
}
