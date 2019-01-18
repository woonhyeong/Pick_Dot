# Pick Dot
This app supports pixel art editor.  

## UI
<center><img src="/ReadmeImage/UI16.png" width="150" height="300"></center>

## Various Functions
### Color
Basically support RGB color. If you touch color button in main view, can use.
Also, support color picker using open source 
<center><img src="/ReadmeImage/RGB.png" width="150" height="300"></center>

### Menu
Support 'New' 'Save' 'Load' 'Export'
<center><img src="/ReadmeImage/MENU.png" width="150" height="300"></center>

### Pixel table
Support minimum 20x20 matrix to maximum 50x50 matrix.
I'm planning to support maximum 100x100 matrix.
<div><img src="/ReadmeImage/SELCTPIXEL.png" width="150" height="300"><img src="/ReadmeImage/UI16.png" width="150" height="300"><img src="/ReadmeImage/UI20.png" width="150" height="300"><img src="/ReadmeImage/UI24.png" width="150" height="300"><img src="/ReadmeImage/UI28.png" width="150" height="300"></div>

### Save & Load function
Support to local store and load. 

### Export by PNG
Support to export pixel by PNG image.

### More functions
- Long press button (direction, pen, eraser button)
  - Press and hold the direction key button and the color at the same time, and paint in the direction of progress.

## More functions to be needed
- Draw pixels by drag.
- Preview entire image.
- Switch screen to selected pixel screen when zooming 

## Problem
- Because it was the first app, it was poorly designed. It's a mess because we've added as much code as we can think.
- I intended to make the UI pretty, but it was not practical.
- There are not many tools for drawing. The only function that selects, paints, and clears the current color.
- Although stored pixels are extracted as images, it is difficult to apply this image to Photoshop. Extracted with png, but not a good png file for editing.

## Review
- There are many features to be added and modified, but I'm not going to touch the app any more.If I are going to start developing this app again, I are going to use Swift to restart UI/UX, Structural Design.
