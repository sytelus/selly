<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "sessioninit.inc" -->

<% Call InitAppStrings()  %>

<% 
	Dim sReportListSQL, rsReportList
	sReportListSQL = "SELECT REPORT_LIST.*, REPORT_LIST.HEADING AS HEADING_NAME, (PERSON.TITLE + PERSON.SURNAME) AS PERSON_NAME  FROM REPORT_LIST, PERSON WHERE "
	sReportListSQL = sReportListSQL & " REPORT_LIST.NHS_ID = '" & GetSQLSafeString(Request.QueryString("NHS_ID")) & "'" 
	sReportListSQL = sReportListSQL & " AND REPORT_LIST.AUTHOR_ID = PERSON.USER_ID"
	
	OpenRecordset sReportListSQL, rsReportList, True

	dim sReportDetail
	dim sLineBreak
	
	sLineBreak = Chr(13) & Chr(10)
	
	sReportDetail = "<report_list>" & sLineBreak
	
	If rsReportList.EOF AND rsReportList.BOF Then
		sReportDetail = sReportDetail & "<report/>"  & sLineBreak
	Else
		Do While Not rsReportList.EOF
			sReportDetail = sReportDetail & "<report>"  & sLineBreak
			sReportDetail = sReportDetail & GetXMLTag(rsReportList,"ID")  & sLineBreak
			sReportDetail = sReportDetail & GetXMLTag(rsReportList,"HEADING_NAME")  & sLineBreak
			sReportDetail = sReportDetail & GetXMLTag(rsReportList,"PERSON_NAME")  & sLineBreak
			sReportDetail = sReportDetail & GetXMLTag(rsReportList,"AUTHOR_ID")  & sLineBreak
			sReportDetail = sReportDetail & GetXMLTag(rsReportList,"ABSTRACT")  & sLineBreak
			sReportDetail = sReportDetail & GetXMLTag(rsReportList,"CREATED_ON")  & sLineBreak
			sReportDetail = sReportDetail & "</report>"  & sLineBreak
			rsReportList.MoveNext				
		Loop
	End If

	sReportDetail = sReportDetail & "</report_list>"

	Response.ContentType="text/xml"
	Response.Write sReportDetail	
	Response.End
%>

<SCRIPT LANGUAGE="VBScript" RUNAT="SERVER">
	Function GetXMLTag(vrsRecordSet,vsFieldName)
			If IsBlank(vrsRecordSet(vsFieldName)) Then
				GetXMLTag = "<" & vsFieldName & "/>"
			Else
				GetXMLTag = "<" & vsFieldName & ">" & vrsRecordSet(vsFieldName) & "</" & vsFieldName & ">"
			End If
	End Function
</SCRIPT>