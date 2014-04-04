<%@ WebHandler Language="C#" Class="GetSlider" %>

using System;
using System.Web;

// Docs

// Takes two images of the same dimensions (width and height) and create a slider of them.  
// Common Usage is to take two satellite images of the same location at different times and produce this slider product for ease of visualization.
// Another common usage is to take a single image and produce a second one which contains some kind of derrived data / image (such as NDVI overlay)

// Params
// Param        Description                                     Example Value
// imgWidth     width of the two images                         668      
// imgHeight    height of the two images                        347
// leftImgSrc   Location on the internet of the left image      https://www.servirglobal.net/MapSupport/Slider/images/gt_pacaya_2014_v3temp.jpg
// rightImgSrc  Location on the internet of the right image     https://www.servirglobal.net/MapSupport/Slider/images/gt_pacaya_2014_v3.jpg
// imgTitle     Title of the image pair                         Pacaya
// Example usage URL string
// https://www.servirglobal.net/MapSupport/Slider/GetSlider.ashx?imgWidth=668&imgHeight=347&leftImgSrc=https://www.servirglobal.net/MapSupport/Slider/images/gt_pacaya_2014_v3temp.jpg&rightImgSrc=https://www.servirglobal.net/MapSupport/Slider/images/gt_pacaya_2014_v3.jpg&imgTitle=Pacaya

public class GetSlider : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) 
    {   
        // Inputs Section
            // Defaults
        int int_Image_Width = 500;
        int int_Image_Height = 500;
        string str_LeftImgSrc = "";
        string str_RightImgSrc = "";
        string str_Image_Title = "DefaultTitle";
        
        
        try
        {
            string str_Image_Width = context.Request["imgWidth"].ToString();
            string str_Image_Height = context.Request["imgHeight"].ToString();
            str_LeftImgSrc = context.Request["leftImgSrc"].ToString();
            str_RightImgSrc = context.Request["rightImgSrc"].ToString();
            str_Image_Title = context.Request["rightImgSrc"].ToString();

            int_Image_Width = int.Parse(str_Image_Width);
            int_Image_Height = int.Parse(str_Image_Height);
        }
        catch (Exception err)
        {

        }

        // Offset value (sets the margin-left css param)
        int int_NegativeOffset = 0;
        if (int_Image_Width % 2 == 1)
        {
            int_NegativeOffset = (int)((int_Image_Width + 1) / 2);
        }
        else
        {
            int_NegativeOffset = (int)(int_Image_Width / 2);
        }
            
        
        
        // Path to Slider
        string totalURL = context.Request.Url.OriginalString;
        string urlPartToSubtract = context.Request.Url.Query;

        string partOfURLToUse = totalURL;
        if (urlPartToSubtract.Length > 0)
        {
            // Subtract off query params.
            partOfURLToUse = totalURL.Replace(urlPartToSubtract, "");
        }
        
        
        string currentPathToSlider = "";
        
        //string currentPathToThisFile = context.Request.Url.AbsoluteUri;
        string currentPathToThisFile = partOfURLToUse;
        
        
        string[] stringSeparators = new string[] { "/" };
        string[] strParts = currentPathToThisFile.Split(stringSeparators, StringSplitOptions.None);
        for (int i = 0; i < strParts.Length; i++)
        {
            if (i == strParts.Length - 1)
            {

            }
            else
            {
                currentPathToSlider += strParts[i];
                currentPathToSlider += "/";
            }
        }
        
        // Path to css and js root
        string path_To_CSS_Root = currentPathToSlider + "libs/css/";
        string path_To_JS_Root = currentPathToSlider + "libs/js/";
        
        // path to files
        string raw_css_1 = path_To_CSS_Root + "ba.css";
        string raw_css_2 = path_To_CSS_Root + "ba_preview.css";
        string raw_js_1 = path_To_JS_Root + "jquery-1.6.4.min.js";
        string raw_js_2 = path_To_JS_Root + "jquery.easing.1.3.js";
        string raw_js_3 = path_To_JS_Root + "jquery-ui-1.8.7.draggable.min.js";
        string raw_js_4 = path_To_JS_Root + "wpw.ba.viewer.1.0.js";

        string finalHTML = "";
        // Build header
        finalHTML += wrap_CSS_Header(raw_css_1);
        finalHTML += wrap_CSS_Header(raw_css_2);
        finalHTML += wrap_JS_Header(raw_js_1);
        finalHTML += wrap_JS_Header(raw_js_2);
        finalHTML += wrap_JS_Header(raw_js_3);
        finalHTML += wrap_JS_Header(raw_js_4);
        
        // Build the div
        finalHTML += "<div class=\"ba_gallery gallery_1\" style=\"left: 50%; margin-left: -"+int_NegativeOffset.ToString()+"px;\">";
        finalHTML += "<img src=\""+str_RightImgSrc+"\" alt=\""+str_LeftImgSrc+"\" title=\""+str_Image_Title+"\" />";
        finalHTML += "</div>";
        
        // Final Javascript
        finalHTML += "<script type=\"text/javascript\">$('.gallery_1').wpwBAgallery( { height:"+int_Image_Height.ToString()+", width:"+int_Image_Width.ToString()+" });</script>";
        
        context.Response.ContentType = "text/HTML";
        context.Response.Write(finalHTML);
    }
    
    public string wrap_JS_Header(string srcString)
    {
        string retString = "";
        retString += "<script src=\"";
        retString += srcString;
        retString += "\" type=\"text/javascript\"></script>";
        return retString;
    }
    
    public string wrap_CSS_Header(string hrefString)
    {
        string retString = "";
        retString += "<link rel=\"StyleSheet\" href=\"";
        retString += hrefString;
        retString += "\" type=\"text/css\" media=\"screen\" />";
        return retString;
    }

    
    public bool IsReusable {
        get {
            return false;
        }
    }

}