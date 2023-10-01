<% 
Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
Response.CodePage = 65001
Response.CharSet = "UTF-8"
q=ucase(request.querystring("q"))
r=ucase(request.querystring("r"))
p=ucase(request.querystring("p"))
                    %>
                    <!-- #include file="./dbcon.asp" -->
                    <%
                Netsis_SQL="SELECT TOP 25																	"
                Netsis_SQL=Netsis_SQL+"		[STOK_KODU]															"
                Netsis_SQL=Netsis_SQL+"		,[STOK_ADI]															"
                Netsis_SQL=Netsis_SQL+"FROM [db2022].[dbo].[TBLSTSABIT] 										"
                Netsis_SQL=Netsis_SQL+"WHERE [STOK_KODU] LIKE '%"&q&"%' "
                Netsis_SQL=Netsis_SQL+" ORDER BY [STOK_ADI]	"
                sira=0
                response.write("<table>")
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                    do until NetsisRecordSet.EOF 
                    sira=sira+1
                            response.write("<tr  class='zebra'>")
                            response.write("<td>"&sira&"</td>")
                            response.write("<td>"&replace(NetsisRecordSet("STOK_KODU"),q,"<mark>"&q&"</mark>",1,-1,1)&"</td>")
                            response.write("<td>"&replace(NetsisRecordSet("STOK_ADI"),r,"<mark>"&r&"</mark>",1,-1,1)&"")
                            BizimKod=NetsisRecordSet("STOK_KODU")
                            %>
                                <img class='icon' src='img/icons/icons8-Binoculars.png'  onclick="showDiv('subs/txtbom.asp?item=<%=BizimKod%>','txtBom')" title='BoM' />
                            <%
                            response.write("</td></tr>")

                       NetsisRecordSet.movenext
                    Loop
                NetsisRecordSet.close
                response.write("</table>")
    NetsisConnection.Close
    Set NetsisRecordSet = Nothing
    Set NetsisConnection = Nothing  %>