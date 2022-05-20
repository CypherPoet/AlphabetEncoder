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

    
    /// Helper to make the system under test from any default initializer
    /// and then test its initial conditions
    private func makeSUTFromDefaults() -> SystemUnderTest {
        .init()
    }
}


// MARK: - "Given" Helpers (Conditions Exist)
extension AlphabetCoderTests {

    private func givenSomething() {
        // some state or condition is established
    }
}


// MARK: - "When" Helpers (Actions Are Performed)
extension AlphabetCoderTests {

    private func whenSomethingHappens() {
        // perform some action
    }
}


// MARK: - Test - Init with Default Properties
extension AlphabetCoderTests {
    
    func test_Init_WhenLeveragingDefaultProperties_ItSetsTheBaseAlphabetToBase62() async throws {
        sut = makeSUTFromDefaults()
        XCTAssertEqual(sut.alphabet, Alphabets.base62)
    }
}


// MARK: - Test - Init with Custom Arguments
extension AlphabetCoderTests {


    func test_Init_WhenUsingCustomBaseAlphabet_ItSetsTheBaseAlphabetToTheOneProvided() async throws {
        customAlphabet = ["S", "W", "I", "F", "T", "🏎"]
        sut = makeSUT()
        
        XCTAssertEqual(sut.alphabet, customAlphabet)
    }
}


// MARK: - Test - Encoding
extension AlphabetCoderTests {
    
    func test_Encoding_WhenEncodingIntegerSmallerThanTheAlphabetBase_ItComputesASingleCharacterAtTheAlphabetIndexPositionOfTheInteger() async throws {
        customAlphabet = Alphabets.base62
        sut = makeSUT()
        
        let index = 2
        let expected = String(customAlphabet[index])
        let actual = try sut.encode(integer: index)
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_Encoding_WhenEncodingZero_ItEncodesToTheFirstElementOfTheBaseAlphabet() async throws {
        customAlphabet = Alphabets.base62
        sut = makeSUT()
        
        let index = 0
        let expected = String(try XCTUnwrap(customAlphabet.first))
        let actual = try sut.encode(integer: index)
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_Encoding_WhenProvidedNegativeInteger_ItThrowsAnError() async throws {
        customAlphabet = Alphabets.base62
        sut = makeSUT()
        
        do {
            let _ = try sut.encode(integer: -2)
            XCTFail("Error should be thrown before reaching this line")
        } catch let error as SystemUnderTest.Error {
            XCTAssertEqual(error, .negativeIntegerArgument)
        } catch {
            XCTFail()
        }
    }
    
    
    func test_MeasureEncoding_WithDefaultAlphabet() async throws {
        let testIntegers = Array(repeating: 100, count: 1000)
        
        sut = makeSUTFromDefaults()
        
        measure {
            for integer in testIntegers {
                let _ = try! sut.encode(integer: integer)
            }
        }
    }
}



// MARK: - Test - Decoding
extension AlphabetCoderTests {

    func test_Decoding_WhenDecodingString_ItComputesTheInverseOfTheInputsEncodedValue() async throws {
        
        for alphabet in [
            Alphabets.base62,
            Alphabets.base62,
        ] {
            customAlphabet = alphabet
            sut = makeSUT()
            
            for expectedOutput in (1...20).map({ _ in Int.random(in: 0...100_000) }) {
                let input = try sut.encode(integer: expectedOutput)
                let actual = try sut.decode(string: input)

                XCTAssertEqual(actual, expectedOutput)
            }
        }
    }
}
