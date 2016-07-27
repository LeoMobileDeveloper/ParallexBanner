
# Introduction

ParallexBanner is a images banner with parallex scroll effect written by pure Swift 2.2

<img src="https://github.com/LeoMobileDeveloper/ParallexBanner/blob/master/ScreenShots/gif.gif?raw=true" width="300">

## Features

- [x] Support storyboard and pure code
- [x] Support auto scroll
- [x] Support infinite scroll
- [x] WebImage (It use Kingfisher to load web image)
- [x] Placeholder image

## Requirements

- iOS 8
- ARC

## Getting start

ParallexBanner use dataSource and delegate

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
