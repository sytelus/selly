<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "checklogin.inc" -->
<!-- #INCLUDE FILE = "pagevariables.inc" -->

<% 
	msPageName="report_list"
	msPageTitle = "Report List"
	msPageHeading = "Report List"
	mbShowStatus = True
	msWindowCaption = "Report List"
	msWindowWidth = "100%"
	mbShowCloseButton = True
	maPageMenu = Array("home","logout","find_patient","patient_detail", "add_report", "external_report_list","help")	
%>

<% 
	Dim sReportListSQL, rsReportList
	sReportListSQL = "SELECT REPORT_LIST.*, REPORT_LIST.HEADING AS HEADING_NAME, (PERSON.TITLE + PERSON.SURNAME) AS PERSON_NAME  FROM REPORT_LIST, PERSON WHERE "
	sReportListSQL = sReportListSQL & " REPORT_LIST.NHS_ID = '" & GetSQLSafeString(Session("NHS_ID")) & "'" 
	sReportListSQL = sReportListSQL & " AND REPORT_LIST.AUTHOR_ID = PERSON.USER_ID"
	
	OpenRecordset sReportListSQL, rsReportList, True
%>

<!-- #INCLUDE FILE = "pageupperpart.inc" -->
		
	<!-- #INCLUDE FILE="winupperpart.inc" -->
				<TABLE WIDTH="100%" BORDER="2" BGCOLOR="#FFFFCA" BORDERCOLOR="Gray">
				<TR>
					<TD BORDERCOLOR="#FF8000" BGCOLOR="#FFFF80"><FONT FACE="Arial" SIZE="1">Report ID</FONT></TD>
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Arial" SIZE="1">Heading</FONT></TD>
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Arial" SIZE="1">Author Name</FONT></TD>	
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Arial" SIZE="1">Author ID</FONT></TD>	
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Arial" SIZE="1">Abstract</FONT></TD>	
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Arial" SIZE="1">Created On</FONT></TD>	
				</TR>
				<TR>
				
				<SCRIPT RUNAT="SERVER" LANGUAGE="VBScript">
					function GetAbstract(vvDatabaseValue)
						dim sAbstract
						dim sEndDots
						sAbstract = AlternateIfBlank(vvDatabaseValue,"N/A")
						If Len(sAbstract) > 10 Then 
							sEndDots = "..."
						Else
							sEndDots = ""
						End If
						GetAbstract = Left(sAbstract,10) + sEndDots
					End Function
				</SCRIPT>
				
				<% 
					if rsReportList.EOF AND rsReportList.BOF Then
						Response.Write "<TR><TD COLSPAN=6 ALIGN=CENTER><FONT FACE=Arial SIZE=2><B>" + "No reports available for this patient" + "</B></FONT> </TD></TR>"
					End If
					
					dim sReportDetail
					Do While Not rsReportList.EOF
						sReportDetail = "<TR>"
						sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + "<A HREF=reportdetail.asp?reportid=" + AlternateIfBlank(rsReportList("ID"),"") + ">" + AlternateIfBlank(rsReportList("ID"),"N/A") + "</A>" + "</FONT> </TD>"
						sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(rsReportList("HEADING_NAME"),"N/A") + "</FONT> </TD>"
						sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(rsReportList("PERSON_NAME"),"N/A") + "</FONT> </TD>"
						sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(rsReportList("AUTHOR_ID"),"N/A") + "</FONT> </TD>"
						sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" +  GetAbstract(rsReportList("ABSTRACT"))  + "</FONT> </TD>"
						sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(rsReportList("CREATED_ON"),"N/A") + "</FONT> </TD>"
						sReportDetail = sReportDetail & "</TR>"
						Response.Write sReportDetail
						rsReportList.MoveNext				
					Loop
				%>
				</TR>
				</TABLE>			
			<CENTER><FORM1 ACTION="addreportgui.asp" METHOD="POST"><INPUT1 TYPE="Submit" VALUE="Add New Report" ALIGN="MIDDLE"></FORM></CENTER>
			<CENTER><FORM1 ACTION="reportlistexternal.asp" METHOD="POST"><INPUT1 TYPE="Submit" VALUE="Search Reports On Other HCFs" ALIGN="MIDDLE"></FORM></CENTER>
	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	<BR><BR><BR><BR>


<!-- #INCLUDE FILE="pagelowerpart.inc" -->