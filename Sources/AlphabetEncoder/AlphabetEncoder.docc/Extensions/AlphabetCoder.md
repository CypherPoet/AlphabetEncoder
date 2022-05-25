# ``AlphabetEncoder/AlphabetCoder``

Encodes an integer to a string, and decodes a string to an integer.


## Overview

Use this struct for encoding an integer to a string, and decoding a string to an integer. 



```swift

import AlphabetEncoder

let alphabetCoder = AlphabetCoder(alphabet: Alphabets.base62)

let number = 21_000_000

print(alphabetCoder.encode(number))     // "1Q73g"
```


```swift
import AlphabetEncoder

let alphabetCoder = AlphabetCoder(alphabet: Alphabets.base62)

let name = "CypherPoet"

print(alphabetCoder.decode(name))     // 175727527079915127
```



## Topics

### Setup

- ``AlphabetCoder/init(alphabet:)``


### Using Built-in Alphabets

- ``AlphabetCoder/Alphabet-swift.typealias``
