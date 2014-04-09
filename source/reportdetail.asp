<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "pagevariables.inc" -->

<% 
	Dim mbExternal
	If Request.QueryString("external") = "true" Then
		mbExternal = True
	Else
		mbExternal = False
	End If
%>

<% If not mbExternal Then %>

<!-- #INCLUDE FILE = "checklogin.inc" -->

<% 
	Else
		Application("Connection_String") = "provider=microsoft.jet.oledb.4.0;data source=" & Server.MapPath("epr.mdb") & ";"
	End If 
%>

<% 
	msPageName="report_detail"
	msPageTitle = "Report Details"
	msPageHeading = "Report Details"
	mbShowStatus = True
	msWindowCaption = "Report Details"
	msWindowWidth = "100%"
	mbShowCloseButton = not mbExternal
	maPageMenu = Array("home","logout","find_patient","patient_detail","report_list", "add_report", "external_report_list","help")		
%>

<% 
	Dim sReportID
	sReportID = Request.QueryString("reportid")

	dim sTableDetail
	
	Dim sReportListSQL, rsReportList
	sReportListSQL = "SELECT REPORT_LIST.*, REPORT_LIST.HEADING AS HEADING_NAME, (PERSON.TITLE + ' ' + PERSON.SURNAME + ' ' + PERSON.FORENAME) AS PERSON_NAME  FROM REPORT_LIST, PERSON WHERE "
	sReportListSQL = sReportListSQL & " REPORT_LIST.ID = '" & GetSQLSafeString(sReportID) & "'" 
	sReportListSQL = sReportListSQL & " AND REPORT_LIST.AUTHOR_ID = PERSON.USER_ID"
	OpenRecordset sReportListSQL, rsReportList, True
	
	If rsReportList.EOF Or rsReportList.BOF Then
		If sReportID = "" then
			Response.Redirect "reportlist.asp"
		Else
			Response.Write "Report details for Report ID [" & sReportID & "] is not available. Please select report from list by using <A HREF=reportlist.asp>View Reports menu</A>. Press Back button in your browser to return to previous screen."
			Response.End
		End If
	End If
	
	Dim sPatientComplaintsSQL, rsPatientComplaints
	sPatientComplaintsSQL = "SELECT * FROM COMPLAINT WHERE COMPLAINT.REPORT_ID = '" & sReportID & "'"
	OpenRecordset sPatientComplaintsSQL, rsPatientComplaints, True

	Dim sPatientSymptomsSQL, rsPatientSymptoms
	sPatientSymptomsSQL = "SELECT * FROM SYMPTOMS WHERE SYMPTOMS.REPORT_ID = '" & sReportID & "'"
	OpenRecordset sPatientSymptomsSQL, rsPatientSymptoms, True

	Dim sPatientExaminationsSQL, rsPatientExaminations
	sPatientExaminationsSQL = "SELECT * FROM EXAMINATION WHERE EXAMINATION.REPORT_ID = '" & sReportID  & "'"
	OpenRecordset sPatientExaminationsSQL, rsPatientExaminations, True

	Dim sExibitsSQL, rsExibits
	sExibitsSQL = "SELECT * FROM EXIBITS WHERE EXIBITS.REPORT_ID = '" & sReportID  & "'"
	OpenRecordset sExibitsSQL, rsExibits, True
	
%>

<% If not mbExternal Then %>
<!-- #INCLUDE FILE = "pageupperpart.inc" -->
<% End If %>
		
	<!-- #INCLUDE FILE="winupperpart.inc" -->
		<TABLE WIDTH="100%" BGCOLOR="#FFFFCA">
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#66B3FF"><TR>
					<TD><FONT FACE="Arial" SIZE="2" COLOR="#0000A0"><B>Date:</B> <% =rsReportList("CREATED_ON") %> </FONT></TD>
					<TD><FONT FACE="Arial" SIZE="2" COLOR="#0000A0"><B>Report ID:</B> <% =rsReportList("ID") %> </FONT></TD>
					<TD><FONT FACE="Arial" SIZE="2" COLOR="#0000A0"><B>Author:</B> <% =rsReportList("PERSON_NAME") %> </FONT></TD>
					<TD><FONT FACE="Arial" SIZE="2" COLOR="#0000A0"><B>HCF Source:</B> <% = Application("HCF_Name") %> </FONT></TD>
				</TR></TABLE>
			</TD>
		</TR>
		<TR><TD><HR ALIGN="CENTER" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%"  BGCOLOR="#FFFFCA" >
				<TR><TD COLSPAN="6" BGCOLOR="Gray"><FONT FACE="Arial" SIZE="3" COLOR="White"><B>Complaints</B></FONT></TD></TR>
				<TR>
					<TD BGCOLOR="#FFFF62" BORDERCOLOR="#FF8000"><FONT FACE="Arial" SIZE="2"><B>Type</B></FONT></TD>
					<TD BORDERCOLOR="#88C4FF"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Nature Of Pain</B></FONT></TD>
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Severity</B></FONT></TD>	
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Duration</B></FONT></TD>	
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Radiation</B></FONT></TD>	
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Notes</B></FONT></TD>	
				</TR>
				<TR>
				<% 
					if rsPatientComplaints.EOF AND rsPatientComplaints.BOF Then
						Response.Write "<TR><TD COLSPAN=6 ALIGN=CENTER><FONT FACE=Arial SIZE=2><B>" + "No complaints recorded" + "</B></FONT> </TD></TR>"
					End If
					
					Do While Not rsPatientComplaints.EOF
						sTableDetail = "<TR>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientComplaints("TYPE"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientComplaints("NATURE_OF_PAIN"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientComplaints("SEVERITY"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientComplaints("DURATION"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientComplaints("RADIATION"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientComplaints("NOTES"),"") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "</TR>"
						Response.Write sTableDetail
						rsPatientComplaints.MoveNext				
					Loop
				%>
				</TR>
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="CENTER" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%"  BGCOLOR="#FFFFCA" >
				<TR><TD COLSPAN="2" BGCOLOR="Gray"><FONT FACE="Arial" SIZE="3" COLOR="White"><B>Symptoms</B></FONT></TD></TR>
				<TR>
					<TD BORDERCOLOR="#FFFF62" BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>No.</B></FONT></TD>
					<TD BORDERCOLOR="#FFFF62" BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Description</B></FONT></TD>
				</TR>
				<TR>
				<% 
					if rsPatientSymptoms.EOF AND rsPatientSymptoms.BOF Then
						Response.Write "<TR><TD COLSPAN=2 ALIGN=CENTER><FONT FACE=Arial SIZE=2><B>" + "No symptoms recorded" + "</B></FONT> </TD></TR>"
					End If
					Dim lRecordCount					
					lRecordCount = 0
					Do While Not rsPatientSymptoms.EOF
						lRecordCount = lRecordCount + 1
						sTableDetail = "<TR>"
						sTableDetail = sTableDetail & "<TD WIDTH=5% > <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" & lRecordCount & "." & "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientSymptoms("DESCRIPTION"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "</TR>"
						Response.Write sTableDetail
						rsPatientSymptoms.MoveNext				
					Loop
				%>
				</TR>
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="CENTER" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#FFFFCA" >
				<TR><TD COLSPAN="4" BGCOLOR="Gray"><FONT FACE="Arial" SIZE="3" COLOR="White"><B>Examinations</B></FONT></TD></TR>
				<TR>
					<TD BORDERCOLOR="#FFFF62" BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Type</B></FONT></TD>
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Result</B></FONT></TD>
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Exibits</B></FONT></TD>	
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Notes</B></FONT></TD>	
				</TR>
				<TR>
				<% 
					if rsPatientExaminations.EOF AND rsPatientExaminations.BOF Then
						Response.Write "<TR><TD COLSPAN=4 ALIGN=CENTER><FONT FACE=Arial SIZE=2><B>" + "No examinations recorded" + "</B></FONT> </TD></TR>"
					End If
					
					Do While Not rsPatientExaminations.EOF
						sTableDetail = "<TR>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientExaminations("TYPE"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientExaminations("RESULT"),"N/A") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + GetCommaConcatedStr(Array(rsPatientExaminations("EXIBIT1"),rsPatientExaminations("EXIBIT2"),rsPatientExaminations("EXIBIT3"),rsPatientExaminations("EXIBIT4"))) + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + AlternateIfBlank(rsPatientExaminations("Notes"),"") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "</TR>"
						Response.Write sTableDetail
						rsPatientExaminations.MoveNext				
					Loop
				%>
				</TR>
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="CENTER" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%"  BGCOLOR="#FFFFCA" >
				<TR><TD COLSPAN="1" BGCOLOR="Gray"><FONT FACE="Arial" SIZE="3" COLOR="White"><B>Action Taken</B></FONT></TD></TR>
				<TR>
					<TD><FONT FACE=Arial SIZE=2 COLOR=#0000A0><% = AlternateIfBlank(rsReportList("ACTION_TAKEN"),"N/A") %></FONT></TD>
				</TR>
				</TABLE>			
			</TD>
		</TR>
		<TR><TD><HR ALIGN="CENTER" SIZE="2" WIDTH="100%"></TD></TR>
		<TR>
			<TD>
				<TABLE WIDTH="100%" BGCOLOR="#FFFFCA" >
				<TR><TD COLSPAN="2" BGCOLOR="Gray"><FONT FACE="Arial" SIZE="3" COLOR="White"><B>Exibits</B></FONT></TD></TR>
				<TR>
					<TD BORDERCOLOR="#FFFF62" BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Media</B></FONT></TD>
					<TD BORDERCOLOR="#FFFF62"   BGCOLOR="#FFFF62"><FONT FACE="Arial" SIZE="2"><B>Notes</B></FONT></TD>
				</TR>
				<TR>
				<% 
					if rsExibits.EOF AND rsExibits.BOF Then
						Response.Write "<TR><TD COLSPAN=2 ALIGN=CENTER><FONT FACE=Arial SIZE=2><B>" + "No exibits for this report" + "</B></FONT> </TD></TR>"
					End If
					
					Do While Not rsExibits.EOF
						sTableDetail = "<TR>"
						sTableDetail = sTableDetail & "<TD width=150> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + GetMediaHTML(rsExibits("FILENAME"),rsExibits("FILETYPE")) + "</FONT> </TD>"
						sTableDetail = sTableDetail & "<TD> <FONT FACE=Arial SIZE=2 COLOR=#0000A0>" + rsExibits("NOTES") + "</FONT> </TD>"
						sTableDetail = sTableDetail & "</TR>"
						Response.Write sTableDetail
						rsExibits.MoveNext				
					Loop
				%>
				
				<SCRIPT RUNAT="SERVER" LANGUAGE="VBSCRIPT">
					Function GetMediaHTML(vvMediaFile,vlMediaType)
						dim sMediaFile
						sMediaFile = AlternateIfBlank(vvMediaFile,"")
						If sMediaFile <> "" Then
							Select Case vlMediaType
								Case 1
									sMediaFile = sMediaFile & ".jpg"		
								Case 2
									sMediaFile = sMediaFile & ".gif"		
								Case 3
									sMediaFile = sMediaFile & ".avi"		
								Case 4
									sMediaFile = sMediaFile & ".wav"		
							End Select
							sMediaFile = "exibits\" & sMediaFile
							Select Case vlMediaType
								Case 1, 2	'jpg, gif
									GetMediaHTML = "<A TARGET=new HREF=" & sMediaFile & ">" & "<IMG WIDTH=100 HEIGHT=100 SRC=" & sMediaFile & " TITLE=""" & vvMediaFile & """" & ">" & "</A>"
								Case 3, 4	'avi, wav
									GetMediaHTML = "<A TARGET=new HREF=" & sMediaFile & ">" & "<EMBED WIDTH=100 HEIGHT=100 SRC=" & sMediaFile & " TITLE=""" & vvMediaFile & """" & ">" & "</A>"
								Case Else	'others, like mp3
									GetMediaHTML = "<A TARGET=new HREF=" & sMediaFile & ">" & "<EMBED WIDTH=100 HEIGHT=100 SRC=" & sMediaFile & " TITLE=""" & vvMediaFile & """" & ">" & "</A>"
							End Select
						Else
							GetMediaHTML = "Media Not Available"
						End If
					End Function
				</SCRIPT>
				
				</TR>
				</TABLE>			
			</TD>
		</TR>
		</TABLE>
	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	<BR><BR><BR><BR>

<% If not mbExternal Then %>
<!-- #INCLUDE FILE="pagelowerpart.inc" -->
<% End If %>