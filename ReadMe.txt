

Image Slider iFrame Generater (Early Alpha)	March 25th, 2014
Assembled by Kris Stanton for the SERVIR Project
(Please note this is an early alpha and may have bugs / unknown issues!)  (See bottom of file for reporting those!)


Intro/Background.
This application is an attempt to automate or at the very least reduce the time consumed by the process of creating image sliders.
This application is a 2 part program for quickly generating dual static image sliders.. dynamically.
Part 1 is an asp.net handler that generates a dynamic webpage which only contains an image slider and dependent javascript files and graphics to enable the slider.
Part 2 is a very basic html interface which creates an iFrame embed script which points to the image slider handler (GetSlider.ashx).

		

Common Usage
Quickly generate image sliders for visualization and embeddeding on any webpage.



Dependencies,
Web Server with ASP.net



Install Instructions
(1) Select a web accessible path on your webserver and extract the the file, "GetSlider.ashx" and the entire contents of the folder "libs" to that directory.
(2) Place the file "SliderFrameDesigner.htm" (or its html) anywhere on your webserver you would like the Slider iFrame Generator User Interface to be located.
(3) Replace the only hardcoded reference inside the SliderFrameDesigner page.
	In the file,
		"SliderFrameDesigner.html" 
	Replace line 25 to match your current installation.

	Exact Code Change Example,
		Change
			srcBuilder += "https://www.servirglobal.net/MapSupport/Slider/GetSlider.ashx";
		To
			srcBuilder += "http://YOUR_DOMAIN.com/PATH_TO_GetSlider_FILE/GetSlider.ashx";


			
Usage Instructions
First, in a webbrowser, browse to the location of "SliderFrameDesigner.htm".
When the page first loads, the default values in the boxes should load
the recent slider for "Pacaya" as an example.

Form Items to fill out.
-Image Title (short title)
-Image Width in pixels
-Image Height in pixels
-Source URL to the image on the internet that should appear on the left.
-Source URL to the image on the internet that should appear on the
right.

Next, click "Update Embedded iFrame Code"

Last, simply copy and paste the iFrame code exactly where you want it in an article (or any web page).

There is a 'preview' pane below the update button which should give an idea of what the iframe will look like on a page.

The source of the iFrame code dynamically generates a page which serves up the image slider based on the inputs.



Current Limitations
-Images must already be uploaded somewhere publically accessible on the internet
-Images 'should' already be the same dimensions of each other.
-Width is limited by how wide the iframe going into an article can be (width of the page the hosts the article)
-Very long URLs for images could potentially not work under certain specific conditions. (Some browsers have low character length limitations on URLs)



Tested
	IE, Firefox, Chrome


	
Comments, Suggestions, Bugs?
Kris.Stanton@nasa.gov	Or	KrisStanton@gmail.com	
	
