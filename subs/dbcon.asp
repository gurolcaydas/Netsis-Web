                    <%
                    Set NetsisConnection = Server.CreateObject("ADODB.Connection")
                    NetsisConnection.Open "PROVIDER=SQLOLEDB;DATA SOURCE=0.0.0.0;UID=Gurol;PWD=passpass;DATABASE=db2022 "
                    Set NetsisRecordSet = Server.CreateObject("ADODB.Recordset") 
                    

                 
                    %>   