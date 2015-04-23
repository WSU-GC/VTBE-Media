<%@ page import="blackboard.platform.plugin.PlugInUtil"%>
<%
//this prepares the embed HTML and inserts it into the VTBE/WYSIWYG editor
String WYSIWYG_WEBAPP = "/webapps/wysiwyg";
String linkTitle = request.getParameter("linkTitle");
String transcript = request.getParameter("transcript");
String pdfSlides = request.getParameter("pdfSlides");
String url = request.getParameter("url");
String output = "<a class='MediaCenterPopup' target='_blank' data-type='iframe' href='"+ url +"'>" + linkTitle + "</a>"; 

if(transcript != null && !"".equals(transcript)) {
	output += ", <a href='" + transcript + "' target='_blank'>transcript</a>";
}

if(pdfSlides != null && !"".equals(pdfSlides)) {
	output += ", <a href='" + pdfSlides + "' target='_blank'>pdf</a>";
}

request.setAttribute( "embedHtml", output );
String embedUrl = PlugInUtil.getInsertToVtbePostUrl().replace( WYSIWYG_WEBAPP, "" );
RequestDispatcher rd = getServletContext().getContext( WYSIWYG_WEBAPP ).getRequestDispatcher( embedUrl );
rd.forward( request, response );
        
%>