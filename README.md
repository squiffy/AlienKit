# AlienKit

[![CI Status](https://travis-ci.org/squiffy/AlienKit.svg?branch=develop)](https://travis-ci.org/squiffy/AlienKit)
[![Version](https://img.shields.io/cocoapods/v/AlienKit.svg?style=flat)](http://cocoapods.org/pods/AlienKit)
[![License](https://img.shields.io/cocoapods/l/AlienKit.svg?style=flat)](http://cocoapods.org/pods/AlienKit)
[![Platform](https://img.shields.io/cocoapods/p/AlienKit.svg?style=flat)](http://cocoapods.org/pods/AlienKit)

Please note that this is still in development. Many, many endpoints are not implemented yet.
This library has no unit tests yet and some documentation is missing. Currently, AlienKit can only handle "app only" authorization. This means that you can access the Reddit API through oauth, just not in the context of a Reddit user. User-based authorization will be added eventually.
    
## Usage

One of the goals of AlienKit is easy of use.


The first step to communicating with Reddit, is to obtain an app id. You can obtain one [here](https://www.reddit.com/prefs/apps/).

Before you start using AlienKit, you must include the following line in all of the files you use AlienKit in:

```swift
import AlienKit
```

Once an app id has been obtained, you can use that app id to auth against oauth. To use "app only" authentication, you can use the following code. Be sure to use your own app id.

```swift
let client = UserlessClient(id: "my_app_id")
```

Now that you have a `UserlessClient` object, you can authorize with AlienKit:

```swift
client.authorize({
       print("Successfully authorized!")
   }, failure: { error in
       print("authorization failed: \(error)")
})
```

Retrieve posts in a subreddit with sorting and filtering:

```swift
client.getPostsFrom("swift", sortFilter: (.Top, .Week), success: { listing in
        for thing in listing.things {
            if let link = thing as? Link {
                print(link.title)
            }
        }
    }, failure: {
        print("cant get posts")  
})
```

Retrieve the comment tree with sorting:

```swift
client.getCommentsFor(someLinkPost, sort: .Top, success: { listing in
        for thing in listing.things {
            if let comment = thing as? Comment {
                // replies are in comment.replies as a "Listing" object
                print(comment.body)
            }
        }
    }, failure: {
        print("cant get comments")    
})
```

Thats it for now! Come back later for more.

## Installation
    
AlienKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following lines to your Podfile:

```ruby
pod 'AlienKit'
```

## Contributing
This project is being developed with a git workflow called [gitflow](https://github.com/nvie/gitflow). Therefore, when contributing, please work of the `develop` branch.

## Author

[@squiffy](https:twitter.com/squiffy)

## License

AlienKit is available under the MIT license. See the LICENSE file for more info.
