# Keychaining

[![Version](https://img.shields.io/cocoapods/v/Keychaining.svg?style=flat)](https://cocoapods.org/pods/Keychaining)
[![License](https://img.shields.io/cocoapods/l/Keychaining.svg?style=flat)](https://cocoapods.org/pods/Keychaining)
[![Platform](https://img.shields.io/cocoapods/p/Keychaining.svg?style=flat)](https://cocoapods.org/pods/Keychaining)

Keychaining is wrapper for keychain that is similar to how you would use Keychain without any libraries.

## Usage

### Synchronous Basic

#### Save
```swift
do {
    try Keychain.genericPassword.makeSaveQuery()
        .setService("Keychaining")
        .setAccount("Account")
        .setDataFor("Private Data")
        .execute()
} catch {
    print(error)
}
```

#### Search
```swift
do {
    let data: Data = try Keychain.genericPassword.makeSearchQuery()
        .setService("Keychaining")
        .setAccount("Account")
        .setReturnTypes(.data)
        .execute()
    print(data)
} catch {
    print(error)
}
```

#### Delete
```swift
do {
    try Keychain.genericPassword.makeDeleteQuery()
        .setService("Keychaining")
        .setAccount("Account")
        .execute()
} catch {
    print(error)
}
```

### Use Asynchronous (\*recommended)
```swift
Task {
    try await Keychain.genericPassword.makeSaveQuery()
        .setService("Keychaining")
        .setAccount("Account")
        .setDataFor("Private Data")
        .execute()
}
```

### Simple Use

#### Save
```swift
try Keychain.set("Some string", forKey: "key")
```

#### Get
```swift
let data: Data = try Keychain.getData(forKey: "key")
```
or
```swift
let string: String = try Keychain.getString(forKey: "key")
```

#### Delete
```swift
try Keychain.delete(forKey: "key")
```

### Advanced

#### Set any attributes
```swift
let query = Keychain.internetPassword.makeBasicQuery()
    .setAccessGroup(accessGroup)
    .setAccessible(accessible)
    .setCreationDate(creationDate)
    .setModificationDate(modificationDate)
    .setDescription(description)
    .setComment(comment)
    .setCreator(creator)
    .setType(type)
    .setLabel(label)
    .setInvisible(isInvisible)
    .setNegative(isNegative)
    .setAccount(account)
    .setSecurityDomain(securityDomain)
    .setServer(server)
    .setProtocol(`protocol`)
    .setAuthenticationType(authenticationType)
    .setPort(port)
    .setPath(path)
    .setSynchronizable(synchronizable)
```

#### Reuse query
```swift
let defaultQuery = Keychain.genericPassword.makeBasicQuery()
    .setService(service)
    .setAccount(account)
    
try defaultQuery.forSave
    .setLabel(label)
    .setData(passwordData)
    .execute()
    
let data: Data = try defaultQuery.forSearch
    .setLabel(label)
    .setReturnTypes(.data)
    .execute()
```

#### Specific error handling
```swift
do {
    let data = try Keychain.genericPassword.makeSearchQuery()
        .setAccount("None")
        .execute()
        ...
} catch {
    if error.asKeychainError == .itemNotFound {
        ...
    }
    if let errorMessage = error.asKeychainError?.errorMessage {
        print(errorMessage)
    }
}
```

## Requirements

- iOS 12.4+
- Xcode 13.3+
- Swift 5.6+

## Installation

Keychaining is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!

target 'target_name' do
   pod 'Keychaining'
end
```

## Author

Jaewon Yun, woin2ee@gmail.com

## License

Keychaining is available under the MIT license. See the LICENSE file for more info.
