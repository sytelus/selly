<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "checklogin.inc" -->
<!-- #INCLUDE FILE = "pagevariables.inc" -->

<% 
	msPageName="patient_detail"
	msPageTitle = "Patient Detail"
	msPageHeading = "Patient Detail"
	mbShowStatus = True
	msWindowCaption = "Patient Detail"
	msWindowWidth = "0%"
	mbShowCloseButton = True
	maPageMenu = Array("home","logout","find_patient","report_list", "add_report", "external_report_list","help")		
%>


<!-- #INCLUDE FILE = "pageupperpart.inc" -->

<!-- #INCLUDE FILE = "patientdetailmain.inc" -->
	

<!-- #INCLUDE FILE="pagelowerpart.inc" -->