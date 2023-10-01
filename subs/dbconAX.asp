                    <%
                    Set AXConnection = Server.CreateObject("ADODB.Connection")
                    AXConnection.Open "PROVIDER=SQLOLEDB;DATA SOURCE=0.0.0.0;UID=Gurol;PWD=passpass;DATABASE=MicrosoftDynamicsAX "
                    Set AXRecordSet = Server.CreateObject("ADODB.Recordset") 
                    
                    
                    %>   