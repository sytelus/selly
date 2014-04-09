<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "checklogin.inc" -->
<!-- #INCLUDE FILE = "pagevariables.inc" -->

<% 
	msPageTitle = "Add Report Result"
	msPageHeading = "Add Report Result"
	mbShowStatus = True
	msWindowCaption = "Add Report Result"
	msWindowWidth = "0%"
	mbShowCloseButton = True
	maPageMenu = Array("home","logout","find_patient","report_list", "add_report", "external_report_list","help")			
%>

<% 
	Dim sReportID
	sReportID = Request("ReportId")
	Dim sReportListSQL, rsReportList
	sReportListSQL = "SELECT * FROM REPORT_LIST WHERE 1=2"
	OpenRecordset sReportListSQL, rsReportList, False
	With rsReportList
		.AddNew
			.Fields("ID") = sReportID
			.Fields("NHS_ID") = Session("NHS_ID")
			.Fields("HEADING") = Request("heading") & ""
			.Fields("AUTHOR_ID") = Session("UserID") & ""
			.Fields("ABSTRACT") = Request("abstract") & ""
			.Fields("CREATED_ON") = Now
			.Fields("ACTION_TAKEN") = Request("action_taken") & ""
		.Update
	End With
	
	Dim sPatientComplaintsSQL, rsPatientComplaints
	sPatientComplaintsSQL = "SELECT * FROM COMPLAINT WHERE 1=2"
	OpenRecordset sPatientComplaintsSQL, rsPatientComplaints, False
	With rsPatientComplaints
		.AddNew
			.Fields("REPORT_ID") = sReportID
			.Fields("TYPE") = Request("complaint_type") & ""
			.Fields("NATURE_OF_PAIN") = Request("complaint_nature_of_pain") & ""
			.Fields("DURATION") = Request("complaint_duration") & ""
			.Fields("RADIATION") = Request("complaint_radiation") & ""
			.Fields("SEVERITY") = Request("complaint_severity") & ""
			.Fields("NOTES") = Request("complaint_notes") & ""
		.Update
	End With

	Dim sPatientSymptomsSQL, rsPatientSymptoms
	sPatientSymptomsSQL = "SELECT * FROM SYMPTOMS WHERE 1=2"
	OpenRecordset sPatientSymptomsSQL, rsPatientSymptoms, False
	With rsPatientSymptoms
		.AddNew
			.Fields("REPORT_ID") = sReportID
			.Fields("DESCRIPTION") = Request("symptomt_description1") & ""
		.Update
	End With
	
	If Request("symptomt_description2") <> "" Then
		With rsPatientSymptoms
			.AddNew
				.Fields("REPORT_ID") = sReportID
				.Fields("DESCRIPTION") = Request("symptomt_description2") & ""
			.Update
		End With
	End If
	
	Dim sPatientExaminationsSQL, rsPatientExaminations
	sPatientExaminationsSQL = "SELECT * FROM EXAMINATION WHERE 1=2"
	OpenRecordset sPatientExaminationsSQL, rsPatientExaminations, False
	With rsPatientExaminations
		.AddNew
			.Fields("REPORT_ID") = sReportID
			.Fields("TYPE") = Request("examinations_type") & ""
			.Fields("RESULT") = Request("examinations_result") & ""
			.Fields("NOTES") = Request("examinations_notes") & ""
			.Fields("EXIBIT1") = Request("examinations_exibit") & ""
		.Update
	End With

	Dim sExibitsSQL, rsExibits
	sExibitsSQL = "SELECT * FROM EXIBITS WHERE 1=2"
	OpenRecordset sExibitsSQL, rsExibits, False
	With rsExibits
		.AddNew
			.Fields("REPORT_ID") = sReportID
			.Fields("FILENAME") = Request("exibits_media") & ""
			.Fields("FILETYPE") = Request("exibits_type")
			.Fields("NOTES") = Request("exibits_notes") & ""
		.Update
	End With
	
	If Err.Number = 0 Then
		Call CloseWriteConnection
	End If
	
%>

<!-- #INCLUDE FILE = "pageupperpart.inc" -->
		
	<FORM ACTION="reportlist.asp" METHOD="POST">
	<!-- #INCLUDE FILE="winupperpart.inc" -->
	<CENTER>
	<FONT FACE="Arial" SIZE="2" COLOR="Green"><B>Report Successfully added.</B></FONT><BR>
	<HR>
	<INPUT TYPE="Submit" VALUE="View Report List" ALIGN="MIDDLE">
	</CENTER>
	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	</FORM>
	<BR><BR><BR><BR>


<!-- #INCLUDE FILE="pagelowerpart.inc" -->