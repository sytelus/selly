	<!-- #INCLUDE FILE = "patientdetailutils.inc" --> 		
	<% 
			'Only if this page was self posted
			Dim sSQL, rsPatient, bPatientFound
			sSQL = "SELECT PATIENT_PERSONAL.*, (PERSON.TITLE + ' ' + PERSON.SURNAME + ' ' + PERSON.FORENAME) AS GP_NAME FROM PATIENT_PERSONAL, PERSON WHERE "
			sSQL = sSQL & "NHS_ID = '" & GetSQLSafeString(Session("NHS_ID")) & "'" 
			sSQL = sSQL & " AND PATIENT_PERSONAL.GP_USER_ID = PERSON.USER_ID"	
		
			OpenRecordset sSQL, rsPatient, True
			If IsRecordsetEmpty(rsPatient) = True Then
				Response.Write "NHS ID " & Session("NHS_ID") & " is not found"
				Response.End
			End If
	%>
		
	<% 
		dim sName, sDOB, sGender, sAddress, sTelephones, sNextOfKinContact
		sName=GetFullName(rsPatient("TITLE"), rsPatient("SURNAME"), rsPatient("FORENAME"))
		sDOB = AlternateIfBlank(CStr(FormateDateTimeX(rsPatient("DOB"),True,False)),"Not Available")
		sGender = GetGenderName(rsPatient("GENDER"))
		sAddress = GetFullAddress(rsPatient("ADDRESS1"), rsPatient("ADDRESS2"), rsPatient("CITY"), rsPatient("POSTCODE"))
		sTelephones = GetTelephoneDetail(rsPatient("TELE_HOME"), rsPatient("TELE_OFFICE"), rsPatient("TELE_MOBILE"))
	%>		


	<TABLE border=0 ALIGN="LEFT"><TR>
	<TD ALIGN="LEFT" VALIGN="TOP">
		<!-- #INCLUDE FILE="winupperpart.inc" -->
		<TABLE BORDER="1" VALIGN="TOP">
		<TR>
			<TD VALIGN="TOP">
				<FONT FACE="Arial" SIZE="3"><B><% Response.Write(sName) %></B></FONT><BR>
				<FONT FACE="Arial" SIZE="1"><B><% Response.Write(sAddress) %></B></FONT><BR>
				<BR>
				<FONT FACE="Wingdings" SIZE="1" COLOR="Red"><B  CLASS="Bolder">(</B></FONT><FONT FACE="Arial" SIZE="1"> <% Response.Write(sTelephones) %></FONT><BR><BR>
				
				<FONT FACE="Arial" SIZE="1"><B CLASS="Bolder">Dob:</B><% Response.Write(sDOB) %></FONT><BR>
				<FONT FACE="Arial" SIZE="1"><B  CLASS="Bolder">Age:</B><% Response.Write(DateDiff("yyyy",sDOB,Now)) %></FONT>&nbsp;<FONT FACE="Arial" SIZE="1"><B  CLASS="Bolder">Sex:</B><% Response.Write(sGender) %></FONT>
			</TD>
			<TD VALIGN="TOP">
				<FONT FACE="Arial" SIZE="1"><B  CLASS="Bolder">NHS ID:</B><% Response.Write(rsPatient("NHS_ID")) %></FONT><BR>
				<FONT FACE="Arial" SIZE="1"><B  CLASS="Bolder">GP:</B><% Response.Write(rsPatient("GP_NAME") & "") %></FONT><BR>
				<FONT FACE="Arial" SIZE="1"><B  CLASS="Bolder">HCP ID:</B>Local</FONT>
			</TD>
			<TD VALIGN="MIDDLE"><IMG ALIGN="MIDDLE" SRC="<% Response.Write("patientphotos\" & rsPatient("PHOTO")) %>" ALT="<% Response.Write("Patient: " & sName) %>"></TD>
			<TD VALIGN="TOP">
				<TABLE BORDER="0">
				<TR>
				<TD BGCOLOR="#6666FF"><FONT FACE="Verdana" SIZE="1"><B>Name</B></FONT></TD><TD  BGCOLOR="#6666FF"><FONT FACE="Verdana" SIZE="1"><B>Age</B></FONT></TD><TD  BGCOLOR="#6666FF"><FONT FACE="Verdana" SIZE="1"><B>Sex</B></FONT></TD>	
				</TR>
				<TR>
				<% 
					Dim sFamilyDetailSQL, rsFamilyDetail, sMemberDetail 
					sFamilyDetailSQL = "SELECT (PFD.SURNAME + ' ' + PFD.FORENAME) AS NAME, PFD.AGE, PFD.SEX  FROM PATIENT_PERSONAL, PATIENT_FAMILY_DETAILS As PFD WHERE "
					sFamilyDetailSQL = sFamilyDetailSQL & " PATIENT_PERSONAL.NHS_ID = PFD.PATIENT_NHS_ID"	
					
					OpenRecordset sFamilyDetailSQL, rsFamilyDetail, True
					
					if rsFamilyDetail.EOF AND rsFamilyDetail.BOF Then
						Response.Write "<TR><TD COLSPAN=3 ><FONT FACE=Arial SIZE=1> " + "No Family data entered" + "</FONT> </TD></TR>"
					End If
					
					Do While Not rsFamilyDetail.EOF
						sMemberDetail = "<TR>"
						sMemberDetail = sMemberDetail & "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsFamilyDetail("NAME"),"N/A") + "</FONT> </TD>"
						sMemberDetail = sMemberDetail & "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsFamilyDetail("AGE"),"N/A") + "</FONT> </TD>"
						sMemberDetail = sMemberDetail & "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsFamilyDetail("SEX"),"N/A") + "</FONT> </TD>"
						sMemberDetail = sMemberDetail & "</TR>"
						Response.Write sMemberDetail
						rsFamilyDetail.MoveNext				
					Loop
				%>
				</TR>
				</TABLE>			
			</TD>
		</TR>
		<TR>
			<TD COLSPAN="4" BGCOLOR="Silver">
			<TABLE WIDTH="100%" BORDER="1" VALIGN="TOP">
				<TR><TD COLSPAN="2" ALIGN="LEFT" BGCOLOR="Gray"><FONT FACE="" SIZE="3" COLOR="White"><B>Other Details</B></FONT></TD></TR>
				<TR>
				<TD VALIGN="TOP">
					<TABLE WIDTH="100%" BORDER="1" VALIGN="TOP">
					<TR>
						<TD ALIGN="CENTER" BGCOLOR="#7D7D00"><FONT FACE="" SIZE="2" COLOR="White"><B>Family History</B></FONT></TD>
					</TR>
					<TR>
						<TD>
							<TABLE WIDTH="100%" VALIGN="TOP">
								<% 
									Dim sFamilyHistorySQL, rsFamilyHistory
									sFamilyHistorySQL = "SELECT * FROM FAMILY_HISTORY AS FH WHERE FH.NHS_ID = '" & 	Session("NHS_ID") & "'"
									
									OpenRecordset sFamilyHistorySQL, rsFamilyHistory, True
									
									if rsFamilyHistory.EOF AND rsFamilyHistory.BOF Then
										Response.Write "<TR><TD COLSPAN=3 ><FONT FACE=Arial SIZE=1> " + "No Family History data available" + "</FONT> </TD></TR>"
									End If
									
									Do While Not rsFamilyHistory.EOF
										Response.Write "<TR>"
										If rsFamilyHistory("MEMBER_STATUS") = False Then
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + "D" + "</FONT> </TD>"		
										Else	
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + " " + "</FONT> </TD>"		
										End If
										Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + rsFamilyHistory("MEMBER_TYPE") + "</FONT> </TD>"						
										Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + rsFamilyHistory("CONDITION") + "</FONT> </TD>"						
										Response.Write "</TR>"
										rsFamilyHistory.MoveNext				
									Loop
								%>			
							</TABLE>
						</TD>
					</TR>
					</TABLE>
				</TD>
				<TD VALIGN="TOP">
					<TABLE WIDTH="100%" BORDER="1" VALIGN="TOP">
					<TR>
						<TD  BGCOLOR="#7D7D00" ALIGN="CENTER"><FONT FACE="" SIZE="2" COLOR="White"><B>Notes</B></FONT></TD>
					</TR>
					<TR>
						<TD>
							<TABLE WIDTH="100%" VALIGN="TOP">
								<% 
									Dim sPatientMedicalSQL, rsPatientMedical
									sPatientMedicalSQL = "SELECT * FROM PATIENT_MEDICAL WHERE PATIENT_MEDICAL.NHS_ID = '" & Session("NHS_ID") & "'"
									
									OpenRecordset sPatientMedicalSQL, rsPatientMedical, True
									
									If rsPatientMedical.EOF AND rsPatientMedical.BOF Then
										Response.Write "<TR><TD><FONT FACE=Arial SIZE=1> " + "No medical details available" + "</FONT> </TD></TR>"
									Else
										Response.Write "<TR><TD><FONT FACE=Arial SIZE=1 COLOR=Red> Allergies </FONT> </TD> <TD>&nbsp;</TD>"
										Response.Write "<TD><FONT FACE=Arial SIZE=1>" + GetCommaConcatedStr(Array(rsPatientMedical("Allergy1"),rsPatientMedical("Allergy2"),rsPatientMedical("Allergy3"),rsPatientMedical("Allergy4"))) + "</FONT> </TD></TR>"
										
										Response.Write "<TR><TD><FONT FACE=Arial SIZE=1 COLOR=green> Blood group </FONT> </TD> <TD>&nbsp;</TD>"
										Response.Write "<TD><FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedical("BLOOD_GROUP"),"N/A") + "</FONT> </TD></TR>"
										
										Response.Write "<TR><TD><FONT FACE=Arial SIZE=1 COLOR=Maroon> Smoker </FONT> </TD> <TD>&nbsp;</TD>"
										Response.Write "<TD><FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedical("SMOKER"),"N/A") + "</FONT> </TD></TR>"
										
										If rsPatient("GENDER") = "F" Then
											Response.Write "<TR><TD><FONT FACE=Arial SIZE=1 COLOR=Navy> Termination </FONT> </TD> <TD>&nbsp;</TD>"
											Response.Write "<TD><FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedical("TERMINATION"),"N/A") + "</FONT> </TD></TR>"
											
											Response.Write "<TR><TD><FONT FACE=Arial SIZE=1 COLOR=Navy> Pregnency </FONT> </TD> <TD>&nbsp;</TD>"
											Response.Write "<TD><FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedical("PREGNENCY"),"N/A") + "</FONT> </TD></TR>"
	
											Response.Write "<TR><TD><FONT FACE=Arial SIZE=1 COLOR=Navy> Cervical Smear </FONT> </TD> <TD>&nbsp;</TD>"
											Response.Write "<TD><FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedical("CERVICAL_SMEAR"),"N/A") + "</FONT> </TD></TR>"
	
											Response.Write "<TR><TD><FONT FACE=Arial SIZE=1 COLOR=Navy> Contraception </FONT> </TD> <TD>&nbsp;</TD>"
											Response.Write "<TD><FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedical("CONTRACEPTION"),"N/A") + "</FONT> </TD></TR>"
										End If										
									End If
									
								%>			
							</TABLE>
						</TD>
					</TR>
					</TABLE>
				</TD>
				</TR>
				<TR>
				<TD COLSPAN="2">
					<TABLE WIDTH="100%" BORDER="1" VALIGN="TOP">
					<TR>
						<TD  BGCOLOR="#7D7D00" ALIGN="CENTER"><FONT FACE="" SIZE="2" COLOR="White"><B>Current Medication</B></FONT></TD>
					</TR>
					<TR>
						<TD>
							<TABLE WIDTH="100%" VALIGN="TOP">
							<TR>
								<TD BGCOLOR="#BFBF00"><FONT FACE="Verdana" SIZE="1"><B>Drug</B></FONT></TD>
								<TD BGCOLOR="#FFFFBB"><FONT FACE="Verdana" SIZE="1"><B>Strength</B></FONT></TD>
								<TD BGCOLOR="#BFBF00"><FONT FACE="Verdana" SIZE="1"><B>Form</B></FONT></TD>
								<TD BGCOLOR="#FFFFBB"><FONT FACE="Verdana" SIZE="1"><B>Dose</B></FONT></TD>
								<TD BGCOLOR="#BFBF00"><FONT FACE="Verdana" SIZE="1"><B>Freq</B></FONT></TD>
								<TD BGCOLOR="#FFFFBB"><FONT FACE="Verdana" SIZE="1"><B>Instructions</B></FONT></TD>
								<TD BGCOLOR="#BFBF00"><FONT FACE="Verdana" SIZE="1"><B>Start Date</B></FONT></TD>
								<TD BGCOLOR="#FFFFBB"><FONT FACE="Verdana" SIZE="1"><B>Finish Date</B></FONT></TD>
							</TR>
								<% 
									Dim sPatientMedicationHistSQL, rsPatientMedicationHist
									sPatientMedicationHistSQL = "SELECT * FROM CURRENT_MEDICATION WHERE CURRENT_MEDICATION.NHS_ID = '" & Session("NHS_ID") & "'"
									
									OpenRecordset sPatientMedicationHistSQL, rsPatientMedicationHist, True
									
									If rsPatientMedicationHist.EOF AND rsPatientMedicationHist.BOF Then
										Response.Write "<TR><TD COLSPAN=8><FONT FACE=Arial SIZE=1> " + "No current medication details available" + "</FONT> </TD></TR>"
									Else
										Do While Not rsPatientMedicationHist.EOF
											Response.Write "<TR>"
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("DRUG"),"N/A") + "</FONT> </TD>"						
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("STRENGTH"),"N/A") + "</FONT> </TD>"						
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("FORM"),"N/A") + "</FONT> </TD>"						
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("DOSE"),"N/A") + "</FONT> </TD>"						
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("FREQUENCY"),"N/A") + "</FONT> </TD>"						
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("INSTRUCTIONS"),"N/A") + "</FONT> </TD>"						
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("START_DATE"),"N/A") + "</FONT> </TD>"						
											Response.Write "<TD> <FONT FACE=Arial SIZE=1>" + AlternateIfBlank(rsPatientMedicationHist("FINISH_DATE"),"N/A") + "</FONT> </TD>"						
											Response.Write "</TR>"
											rsPatientMedicationHist.MoveNext				
										Loop
									End If	
								%>			
							</TABLE>
						</TD>
					</TR>
					</TABLE>
				</TD>
				</TR>
			</TABLE>
			</TD>
		</TR>
		</TABLE>
		<CENTER><FORM1 ACTION="reportlist.asp" METHOD="POST"><INPUT1 TYPE="Submit" VALUE="View Reports" ALIGN="MIDDLE"></FORM></CENTER>
		<!-- #INCLUDE FILE="winlowerpart.inc" -->
	</TD></TR>
	</TABLE>		
