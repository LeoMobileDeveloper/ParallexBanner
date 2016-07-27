# ParallexBanner

 [![Version](https://img.shields.io/cocoapods/v/ParallexBanner.svg?style=flat)](http://cocoapods.org/pods/ParallexBanner)  [![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
 [![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
 [![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

ParallexBanner is a banner with parallex scroll effect written by pure Swift.

<img src="https://github.com/LeoMobileDeveloper/ParallexBanner/blob/master/ScreenShots/gif.gif?raw=true" width="200">

## Features

- [x] Storyboard and pure code layout
- [x] Auto scroll
- [x] Infinite scroll
- [x] WebImage and local image (It use Kingfisher to load web image)
- [x] Placeholder image

## Requirements

- iOS 8
- ARC

## Install

Using CocoaPod

```
pod "ParallexBanner"
```

## Getting start

ParallexBanner use dataSource and delegate as main interface

Data Source

```
//Number of banners
func numberOfBannersIn(_ bannner:ParallexBanner)->NSInteger
//You can return a ImageURL(String) or a UIImage object here
func banner(_ banner:ParallexBanner,urlOrImageAtIndex index:NSInteger)->AnyObject
//Return the place holder image here
optional func banner(_ banner:ParallexBanner,placeHolderForIndex index:NSInteger)->UIImage?
//Return the image contentMode here
optional func banner(_ banner:ParallexBanner,contentModeAtIndex index:NSInteger)->UIViewContentMode

```

Delegate

```
//Click at index
optional func banner(_ banner:ParallexBanner,didClickAtIndex index:NSInteger)
//Scroll to index
optional func banner(_ banner:ParallexBanner,didScrollToIndex index:NSInteger)
```

!!! Do not forget to call `banner.reloadData()` when model changed.

##Propertys

- `autoScroll` enable timer based scroll
- `autoScrollTimeInterval` scroll interval
- `enableScrollForSinglePage`  enable scroll if there is only single page
- `parllexSpeed` the speed of parallex scroll.Better to between 0.1 and 0.8
- `currentIndex` current page index.Readonly
- `pageControl` the pageControl object 
- `transitionMode` set it to .Normal if you do not want parallex scroll.


## Author

leo, leomobiledeveloper@gmail.com

## License

ParallexBanner is available under the MIT license. See the LICENSE file for more info.
