## Notes from: Introduction to D3
### Curran Kelleher

*Youtub Link*
https://www.youtube.com/watch?v=8jvoTV54nXw

*GitHub Repo*
https://github.com/curran/screencasts/tree/gh-pages/d3ReusableCharts

d3 gives you:
- scales to map data to pixes
- axis 
- functions that add HTML attributes like bars, dots

jsbin.com - an IDE that lives in the web-browser. Allows you to show and manipulate JS on the web instead of locally. 

#### SVG Basics:

Colors
- uses 'fill' attribute
+ fill = "rgb(255, 0, 0)""
+ fill = "rgba(255, 0, 0, 0.5)" <- 'alpha' transparent
+ fill = "#0000FF" <- hex color strings

The built in d3 color scales use hex. 

Shape outline attribute
- stroke = "blue"
- stroke-width = "10"

SVG Paths - allows for continuous lines and filled polygons
- d(M50 50 L100 150 L150 150 L200 50 50Z) 

"g tag" groups elements together. You can then assign a transform that will reassign the coordinate system. Allows you to use a localized coordinate system. 

*Using Google Fonts*
http://curran.github.io/screencasts/introToD3/examples/viewer/#/31

#### JavaScript Basics

Use console.log to print objects or object properties to the console using Chrom dev tools. 
