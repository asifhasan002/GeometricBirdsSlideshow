# GeometricBirdsSlideshow

Welcome to the SVG Bird Morphing Animation project! This SwiftUI application showcases a visually engaging morphing animation using SVG images of various birds. The animation transitions between different bird shapes and colors, providing an elegant visual experience.

#### Features
* Morphing Animation: Smoothly transitions between multiple bird SVG shapes.
* Dynamic Color Change: Each bird's color changes during the morphing animation.
* Text Display: Corresponding text updates to reflect the current bird being displayed.
* Interactive Dots: Visual indicators that highlight the current bird, enhancing user engagement.

#### Prerequisites
* Xcode 13.0 or later
* Swift 5.0 or later
* Installation
* Clone this repository:

#### Key Components
* Bird Data Loading: SVG paths and colors are loaded from specified SVG files.
* Shape Layer Setup: CAShapeLayer is used to render the SVG shapes.
* Animation Logic: Animations for both path morphing and color transitions are handled through Core Animation.

#### Main Functionality
* The app initializes by loading SVG bird data and setting up shape layers.
* A sequential animation function triggers the morphing effect, iterating through the bird shapes and updating the display text and dots.
* Morphing is achieved using CABasicAnimation for both the path and fill color.

#### Code Structure
* ContentView and ContentViewModel: Main view containing the UI logic and UI elements.
* BirdShapeLayerView: A wrapper for displaying each bird shape.
* Color Extension: Utility to convert hex color strings into SwiftUI Color objects.
* BirdShapeLayer+Morph: Containing animation logic

#### Customization
* To add more birds, simply include additional SVG files in the project directory and update the loadBirdData() function accordingly.
* Modify colors and shapes by editing the corresponding SVG files.
* Note: Svg birds must have equal paths for smooth animation.

#### Acknowledgments

* SVGBezierPath for handling SVG paths.
* SwiftUI for building the user interface.

Enjoy experimenting with this SVG bird morphing animation!Happy coding!

https://github.com/user-attachments/assets/8cd77089-e770-4a07-bdc7-b753bb847d32

