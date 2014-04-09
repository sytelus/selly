<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "checklogin.inc" -->
<!-- #INCLUDE FILE = "pagevariables.inc" -->

<% 
	msPageName="find_patient"
	msPageTitle = "Search Patient"
	msPageHeading = "Search Patient"
	mbShowStatus = True
	msWindowCaption = "Search Patient"
	msWindowWidth = "0%"
	mbShowCloseButton = True
	maPageMenu = Array("home","logout","help")
%>

<% 
	Const mlREASON_NHS_ID_NOT_FOUND = "1"		'User entered incorrect login info
	Const mlREASON_DIRECT_ACCESS = "2"			'Page expecting user ID was accessed directly by entering URL without going through Search Patient screen

	'Only if this page was self posted
	If Request.QueryString("reason") = mlREASON_NHS_ID_NOT_FOUND Then
		Dim sSQL, rsPatient, bPatientFound
		sSQL = "SELECT * FROM PATIENT_PERSONAL WHERE "
		sSQL = sSQL & "NHS_ID = '" & GetSQLSafeString(Request("NHS_ID")) & "'" 
		
		OpenRecordset sSQL, rsPatient, True
		If IsRecordsetEmpty(rsPatient) = False Then
			Session("NHS_ID") = rsPatient("NHS_ID")
			Response.Redirect "patientdetail.asp"
		Else
			Session("NHS_ID") = ""
		End If
	End if
%>

<!-- #INCLUDE FILE = "pageupperpart.inc" -->


	<!-- If execution came here it means NHS ID was not found -->
	<% 
		If Request.QueryString("reason") = mlREASON_NHS_ID_NOT_FOUND Then
	%>
	<CENTER><FONT FACE="Arial" COLOR="Red">NHS ID Not Found: </FONT>
			<FONT FACE="Arial" COLOR="Maroon">The NHS ID you have entered was not found in database. Please try again.</FONT><BR>
			<BR><BR>
	</CENTER>	
	<%
		ElseIf  Request.QueryString("reason") = mlREASON_DIRECT_ACCESS Then
	%>
	<CENTER><FONT FACE="Arial" COLOR="Red">NHS ID Not Entered: </FONT>
			<FONT FACE="Arial" COLOR="Maroon">Before you access any other patient details you must enter patient's NHS ID first.</FONT><BR>
			<BR><BR>
	</CENTER>	
	<% 
		End If
	%>


		
	<!-- #INCLUDE FILE="winupperpart.inc" -->

		<FORM ACTION="patientsearch.asp?reason=<% =mlREASON_NHS_ID_NOT_FOUND %>" METHOD="POST">
			<TR><TD>NHS ID:</TD><TD><INPUT TYPE="Text" VALUE="<% =Request("NHS_ID") %>" NAME="NHS_ID" MAXLENGTH="12"></TD></TR>
			<TR><TD COLSPAN="2" ALIGN="RIGHT"><HR><INPUT TYPE="Submit" VALUE="Find"></TD></TR>
		</FORM>	

	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	<BR><BR><BR><BR>


<!-- #INCLUDE FILE="pagelowerpart.inc" -->