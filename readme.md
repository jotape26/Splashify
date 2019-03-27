# _Splashify_
 Find new palettes using your images!
 
 - [Features](#features)
 - [Requirements](#requirements)
 - [Installation](#Installation)
 - [Usage](#usage)
 - [Credits](#credits)
---
 ## Features

 - [x] Search color palettes using images from the web.
 - [x] Choose between Simple, WebSave W3C or Precise colors.
 - [x] Preview colors in fullscreen for real life comparison.
---
 ## Requirements

- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 10.1+
- Swift 4.2+
- CocoaPods 1.6.0
---
 ## Installation
 
 - Clone or download this repository.
 - Install CocoaPods in your Mac.
   - Open your terminal and run ``` sudo gem install cocoapods```.
 - Install the project pods.
   - In your terminal, navigate to the folder where this project is located and run ```pod install```.
 - Open Splashify.xcworkspace and run the project.
 - Enjoy!
---
## Usage

- Find a color palette
  - Click the "+" button to add a new image.
  - Type the desired image URL and click the "Search" button.
   _if your request fails, the window will turn red informing you of what happened_
  - See your photo's color palette.
  _ You can click on the color to open a fullscreen window of the selected color_

- Use an advanced color palette
  - Click the search button.
  - Choose the desired color palette specification
  _You can read more about the palette on the description in the settings window_
  - Import a new image to use the new selected palette
  _You can reprocess old images with the new palette by simply clicking the old image. You will be prompted to reprocess or open the old palette_

- Delete old images
  - To delete an old image, simply long press it and you'll be prompted to erase the image from the app.
---
## Credits

Splashify is my final project submission for the Udacity iOS Developer Nanodegree program.

Code written in this project is either mine or dependency and extensions found in the internet. Extensions are provided with the source of the code for credits.