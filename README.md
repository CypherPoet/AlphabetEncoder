# AlphabetEncoder

<!-- Header Logo -->

<!--
<div align="center">
   <img width="600px" src="./Sources/MyLibraryName/MyLibraryName.docc/Resources/Images/banner-logo.png" alt="Banner Logo">
</div>

<!-- Badges -->

<p>
    <img src="https://img.shields.io/badge/Swift-5.6-F06C33.svg" />
    <img src="https://img.shields.io/badge/iOS ->= 13.0-865EFC.svg" />
    <img src="https://img.shields.io/badge/iPadOS ->= 13.0-F65EFC.svg" />
    <img src="https://img.shields.io/badge/macOS ->= 10.15-179AC8.svg" />
    <img src="https://img.shields.io/badge/tvOS ->= 13.0-41465B.svg" />
    <img src="https://img.shields.io/badge/watchOS ->= 8.0+-1FD67A.svg" />
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" />
    <img src="https://github.com/CypherPoet/AlphabetEncoder/workflows/Build%20&%20Test/badge.svg" />
    <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" />
    </a>
    <a href="https://twitter.com/cypher_poet">
        <img src="https://img.shields.io/badge/Contact-@cypher_poet-lightgrey.svg?style=flat" alt="Twitter: @cypher_poet" />
    </a>
</p>

<p align="center">A library to encode and decode integers from base alphabets of characters.<p />

## Installation

### Xcode Projects

Select `File` -> `Swift Packages` -> `Add Package Dependency` and enter `https://github.com/CypherPoet/AlphabetEncoder`.

### Swift Package Manager Projects

You can add `AlphabetEncoder` as a package dependency in your `Package.swift` file:

```swift
let package = Package(
    //...
    dependencies: [
        .package(
            name: "AlphabetEncoder",
            url: "https://github.com/CypherPoet/AlphabetEncoder",
            .exact("0.0.1")
        ),
    ],
    //...
)
```

<!-- 🔑 UNCOMMENT THE INSTRUCTIONS BELOW IF THE GITHUB REPO NAME MATCHES THE PACKAGE NAME 👇 -->

From there, refer to `AlphabetEncoder` as a "target dependency" in any of _your_ package's targets that need it.

```swift
targets: [
    .target(
        name: "YourLibrary",
        dependencies: [
          "AlphabetEncoder",
        ],
        ...
    ),
    ...
]
```

Then simply `import AlphabetEncoder` wherever you’d like to use it.

## 🗺 Road Map

- Potentially add more base alphabets.

## 💻 Developing

### Requirements

- Xcode 13.0+

### 📜 Creating & Building Documentation

Documentation is built with [DocC](https://developer.apple.com/documentation/docc) (see [Apple's guidance for more details about creating DocC content](https://developer.apple.com/documentation/docc/api-reference-syntax)).

To build and preview the documentation output, follow the instructions for the [here](https://github.com/apple/swift-docc-plugin#previewing-documentation) for the `Swift-DocC Plugin `.

If you're using VSCode, there's also a [task configuration](./.vscode/tasks.json) that will handle this directly from the editor 💪

## 🏷 License

`AlphabetEncoder` is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.
