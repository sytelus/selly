<% Option Explicit %>

<!-- #INCLUDE FILE = "dblib.inc" -->
<!-- #INCLUDE FILE = "utils.inc" --> 
<!-- #INCLUDE FILE = "checklogin.inc" -->
<!-- #INCLUDE FILE = "sessioninit.inc" -->
<!-- #INCLUDE FILE = "pagevariables.inc" -->

<% Call InitAppStrings()  %>

<% 
	msPageName="external_report_list"
	msPageTitle = "External Report List"
	msPageHeading = "Report List On Other HCFs"
	mbShowStatus = True
	msWindowCaption = "External Report List"
	msWindowWidth = "100%"
	mbShowCloseButton = True
	maPageMenu = Array("home","logout","find_patient","patient_detail","report_list", "add_report", "help")
%>

<% 
		'Only if this page was self posted
		Dim sHCFSQL, rsHCF
		sHCFSQL = "SELECT * FROM HCF"
		OpenRecordset sHCFSQL, rsHCF, True
		If IsRecordsetEmpty(rsHCF) = True Then
			Response.Write "No other Health Care Facilities recorded in the database."
			Response.End
		End If
%>


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

<!-- #INCLUDE FILE = "pageupperpart.inc" -->
		
	<!-- #INCLUDE FILE="winupperpart.inc" -->
				<TABLE WIDTH="100%" BORDER="2" BGCOLOR="#FFFFCA" BORDERCOLOR="Gray">
				<TR>
					<TD BORDERCOLOR="#FF8000" BGCOLOR="#FFFF80"><FONT FACE="Verdana" SIZE="1"><B>Report ID</B></FONT></TD>
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Verdana" SIZE="1"><B>Heading</B></FONT></TD>
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Verdana" SIZE="1"><B>Author Name</B></FONT></TD>	
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Verdana" SIZE="1"><B>Author ID</B></FONT></TD>	
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Verdana" SIZE="1"><B>Abstract</B></FONT></TD>	
					<TD BORDERCOLOR="#FF8000"   BGCOLOR="#FFFF80"><FONT FACE="Verdana" SIZE="1"><B>Created On</B></FONT></TD>	
					<TD BGCOLOR="#FFFF80" BORDERCOLOR="#FF8000"><FONT FACE="Verdana" SIZE="1"><B>HCF</B></FONT></TD>	
				</TR>
				<TR>
				
				<% 
					Dim oXMLDocument, oDocumentRoot
					Dim oRecords, oRecord
					Dim sID, sHeadingName, sPersonName, sAuthorID, sAbstract, sCreatedOn
					Dim sReportDetail
					Dim sHCFTextColor
					Dim sServerURL
										
					Const sHCF_TEXTCOLOR1 = "#000066"
					Const sHCF_TEXTCOLOR2 = "#660000"
					
					sHCFTextColor=sHCF_TEXTCOLOR1

					Set oXMLDocument = Server.CreateObject("Microsoft.XMLDOM")
					oXMLDocument.async = False
					
					Do While not rsHCF.EOF
						sServerURL = rsHCF("SERVER")
						oXMLDocument.load  sServerURL & "/reportlistxml.asp?NHS_ID=" & Session("NHS_ID")
						Set oDocumentRoot = oXMLDocument.DocumentElement
						
						For Each oRecords In oDocumentRoot.childNodes
							For Each oRecord In oRecords.childNodes
								Select Case oRecord.nodeName
									Case "ID"
										sID = oRecord.text
									Case "HEADING_NAME"
										sHeadingName = oRecord.text
									Case "PERSON_NAME"
										sPersonName = oRecord.text
									Case "AUTHOR_ID"
										sAuthorID = oRecord.text
									Case "ABSTRACT"
										sAbstract = oRecord.text
									Case "CREATED_ON"
										sCreatedOn = oRecord.text
								End Select
							Next
							
							sReportDetail = "<TR>"
							sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" +  "<A Target=new HREF=" + sServerURL + "/reportdetail.asp?external=true&reportid=" + AlternateIfBlank(sID,"") + ">" + AlternateIfBlank(sID,"N/A") + "</A>" + "</FONT> </TD>"
							sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(sHeadingName,"N/A") + "</FONT> </TD>"
							sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(sPersonName,"N/A") + "</FONT> </TD>"
							sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(sAuthorID,"N/A") + "</FONT> </TD>"
							sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" +  GetAbstract(sAbstract)  + "</FONT> </TD>"
							sReportDetail = sReportDetail & "<TD> <FONT FACE=Arial SIZE=1 COLOR=#0000A0>" + AlternateIfBlank(sCreatedOn,"N/A") + "</FONT> </TD>"
							sReportDetail = sReportDetail & "<TD  BGCOLOR=#FFFF80> <FONT FACE=Verdana SIZE=1 COLOR=" & sHCFTextColor & "><B>" + AlternateIfBlank(rsHCF("NAME"),"N/A") + "</B></FONT> </TD>"
							sReportDetail = sReportDetail & "</TR>"
							Response.Write sReportDetail
						next
						
						If sHCFTextColor = sHCF_TEXTCOLOR1 Then
							sHCFTextColor = sHCF_TEXTCOLOR2
						Else
							sHCFTextColor = sHCF_TEXTCOLOR1
						End If
						response.write "<TR><TD COLSPAN=7><HR COLOR=blue></TD></TR>"
						rsHCF.MoveNext
					Loop
				%>
				</TR>
				</TABLE>			
	<!-- #INCLUDE FILE="winlowerpart.inc" -->
	<BR><BR><BR><BR>


<!-- #INCLUDE FILE="pagelowerpart.inc" -->