<SCRIPT LANGUAGE="VBScript" RUNAT="SERVER">
	Sub InitSession()
		Call InitAppStrings()
		Set Session("Menus")=Nothing
		dim oCol
		set oCol = Server.CreateObject("Scripting.Dictionary")
		Set Session("Menus")= oCol
		oCol.Add "home",Array("default.asp","Home","Start page of the site")
		oCol.Add "logout",Array("logout.asp","Logout","End your session")
		oCol.Add "login",Array("login.asp","Login","Login to access the	database")
		oCol.Add "find_patient",Array("patientsearch.asp","Find Patient","Search patient records")
		oCol.Add "patient_detail",Array("patientdetail.asp","Patient Deatil","View the basic patient details")
		oCol.Add "report_list",Array("reportlist.asp","View Reports","View the list of medical records on this server")
		oCol.Add "add_report",Array("addreportgui.asp","Add report","Add the new report on this server")
		oCol.Add "report_detail",Array("reportdetail.asp","Report Detail", "View the details of the report")
		oCol.Add "external_report_list",Array("reportlistexternal.asp", "Ext Reports", "View the patient records on other servers")
		oCol.Add "help",Array("help.asp","Help","Get the more information on this page")
		set oCol = nothing
	End Sub
	
	Sub InitAppStrings()
		Application("Connection_String") = "provider=microsoft.jet.oledb.4.0;data source=" & Server.MapPath("epr.mdb") & ";"
		Application("HCF_Name") = "Selly Oak GP MPRS"
	End Sub
</SCRIPT>