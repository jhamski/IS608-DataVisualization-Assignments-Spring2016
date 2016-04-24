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

In JS, you can pass functions into other functions.

/////////////
<script type="text/javascript">
	var square = function (x) {
	return x * x;
	}
	
	console.log(square(5))
</script>


25

/////////////

Arrays have a "forEach" function built-in. You can pass a function to .forEach and it will be executed on each element of the array. 
<script type="text/javascript">
	myArrayOfObjects.forEach(function (d){
	console.log(d.x + "," + d.y)
	})
</script>



Reading in CSV files will default to string type. You need to convert to parseFloat:
<script>

      d3.csv("data.csv", type, function (myArrayOfObjects){
        myArrayOfObjects.forEach(function (d){
          console.log(d.x + d.y);
        });
      });

      function type(d){
        d.x = parseFloat(d.x);
        d.y = parseFloat(d.y);
        return d;
      }

 </script>

### Big takeway
"d3 gives you a nice syntax for assigning attributes on d3 elements as functions of data elements."

*around 48:00 in the video*

<script>

      var data = [1, 2, 3, 4, 5];

      var scale = d3.scale.linear()
        .domain([1, 5])   // Data space
        .range([0, 200]); // Pixel space

      var svg = d3.select("body").append("svg")
        .attr("width",  250)
        .attr("height", 250);

      svg.selectAll("rect")
          .data(data)
        .enter().append("rect")
          .attr("x", function (d){ return scale(d); })
          .attr("y", 50)
          .attr("width",  20)
          .attr("height", 20);

    </script>

