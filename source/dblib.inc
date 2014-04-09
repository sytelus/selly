<% 
	'Const are defined here because ASP 1.0 doesn't support Meta tag to include type libs
	Const adOpenForwardOnly = 0
	Const adOpenKeyset = 1
	Const adLockReadOnly = 1
	Const adLockOptimistic = 3
	Const adUseClient = 3
	Const adModeRead = 1
	Const adOpenStatic = 3

	Dim mcnWriteConn
%>

<SCRIPT LANGUAGE="VBScript" RUNAT="Server"> 
	
	Sub OpenRecordset (vsSQL, rrsRecordset, vboolIsReadOnly)
		Set rrsRecordset = Server.CreateObject("ADODB.Recordset")
		If vboolIsReadOnly = True Then
			'Dim cnReadOnlyConn
			'Set cnReadOnlyConn = Server.CreateObject("ADODB.Connection")
			'cnReadOnlyConn.Mode = adModeRead
			'cnReadOnlyConn.CursorLocation = adUseClient
			'cnReadOnlyConn.Open Application("Connection_String")
			rrsRecordset.Open vsSQL, Application("Connection_String"), adOpenForwardOnly, adLockReadOnly
			'cnReadOnlyConn.Close	'Make recordset disconnected
		Else
			If IsEmpty(mcnWriteConn) Then
				Set mcnWriteConn = Server.CreateObject("ADODB.Connection")
				mcnWriteConn.Open Application("Connection_String")
				mcnWriteConn.BeginTrans
			End If
			rrsRecordset.Open vsSQL, mcnWriteConn, adOpenKeyset, adLockOptimistic				
		End If
	End Sub
	
	Sub CloseWriteConnection()
		mcnWriteConn.CommitTrans
		mcnWriteConn.Close
		Set mcnWriteConn = Nothing
	End Sub
	
	Function IsRecordsetEmpty (vrsRecordset)
		If vrsRecordset.EOF And vrsRecordset.BOF Then
			IsRecordSetEmpty = True
		Else
			IsRecordSetEmpty = False	
		End If
	End Function
	
	Function NullCheckedVal(vvValue,vvOnNullValue)
		If IsNull(vvValue) Then
			NullCheckedVal = vvOnNullValue
		Else
			NullCheckedVal = vvValue
		End If
	End Function
	
</SCRIPT>