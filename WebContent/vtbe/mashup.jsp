<%@page import="helper.buildingblock.BuildingBlockHelper"%>
<%@page import="java.util.Properties"%>
<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ page isErrorPage="true" %>

<% Properties props = BuildingBlockHelper.loadEnvProperties(); %>

<script type="text/javascript" src="../js/lo-dash.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/xml2json.js"></script>
<script type="text/javascript" src="../js/jsrender.js"></script>
<script>$.noConflict();</script>
<script>
	/*var data = [
			{
				title: 'The Great Floods',
				url: 'https://online.wsu.edu/lms_media.aspx?cid=@X@course.id@X@&seq=1&type=v',
				transcript: 'http://online.wsu.edu/onlinemedia/transcripts/The%20Great%20Floods%20(c092).pdf',
				pdfSlides: ''
			},
			{
				title: 'Hotel Operating Statistics', 
				url: 'https://online.wsu.edu/lms_media.aspx?cid=2014-fall-ONLIN-HBM-491-5827-LEC&seq=1&type=p',
				transcript: 'http://online.wsu.edu/onlinemedia/transcripts/hbm491_01_art(c131).pdf',
				pdfSlides: 'http://online.wsu.edu/onlinemedia/pdf_version/hbm491_01_art(c131).pdf'
			}
	];*/
	(function($) {
		
		
		$(function() {

			var url = '<%= props.getProperty("url") + "/Menu.asmx/MediaCenter" %>';
			console.log(url);
			var jxhr = $.ajax(url, {
				data: {
					courseId: '<%= request.getParameter("course_id") %>'
				}
			});

			jxhr.done(function(xml) {
				var data = $.xml2json(xml);
				data = data.MediaItem ? data.MediaItem : [{
					title: "Media not available for this course.",
					url: "",
					transcript: "",
					pdfSlides: ""
				}];
				data = Array.isArray(data)
					? data
					: [data];
				
				data.unshift({title: "Select an Option", url: "", transcript: "", pdfSlides: ""});
				
				var template = $.templates("#theTmpl");
		
				var htmlOutput = template.render(data);
		
				$("#media").html(htmlOutput);
				
				$('#media').change(function() {
					var $el = $(this);
					var model = data[$el.val()];
					$('#linkTitle').val(model.title);
					$('#url').val(model.url);
					$('#transcript').val(model.transcript);
					$('#pdfSlides').val(model.pdfSlides);
				});
			});

			jxhr.fail(function(xhr, statusText) {
				
			});
			
		});
	}(jQuery));
</script>
<style>
	form#mashupForm input,
	form#mashupForm select {
		display: block;
		width: 400px;
	}
</style>
<bbNG:genericPage>

<script id="theTmpl" type="text/x-jsrender">
<option value="{{:#index}}">{{:title}}</option>
</script>

<h1>Course ID: <%= request.getParameter("course_id") %></h1>

<form id="mashupForm" action="mashup_proc.jsp" method="POST">
<bbNG:dataCollection>
<bbNG:step title="Select Media to Insert">


<Select id="media" name="media">
	<!-- <option value="Select">Select an Option</option>
	<option value="0">The Great Floods</option>
	<option value="1">Hotel Operating Statistics</option>-->
</Select>

<!-- <textarea rows="25" cols="50" name="embedHtml"></textarea>-->
<input id="linkTitle" type="hidden" name="linkTitle"/><br/>

<!-- HIDDEN FIELDS -->
<input id="url" type="hidden" name="url"/><br/>
<input id="transcript" type="hidden" name="transcript"/><br/>
<input id="pdfSlides" type="hidden" name="pdfSlides"/>

</bbNG:step>
<bbNG:stepSubmit>
<bbNG:stepSubmitButton label="Submit"/>
</bbNG:stepSubmit>
</bbNG:dataCollection>
</form>
</bbNG:genericPage>