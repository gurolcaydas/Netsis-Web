        <!-- #include file="./dbcon.asp" -->
        <%            
        url_item = request.querystring("item")      %>
            <table class="table table-sm table-striped table-hover align-middle">                        <%
                Netsis_SQL=" "
                Netsis_SQL=Netsis_SQL+" SELECT [ISEMRINO],[MAMUL_KODU]	"
                Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLISEMRIREC]	"
                Netsis_SQL=Netsis_SQL+" WHERE MAMUL_KODU='"&url_item&"'	"
                Netsis_SQL=Netsis_SQL+"  GROUP BY [ISEMRINO] ,[MAMUL_KODU]	"
                        'response.write(Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=1000
                        if sira=0 then                         %>
                            <thead><tr> <%
                            Response.Write("<th>Sıra</th>")
 
                                Response.Write("<th>İş emri</th><th>Bağlı reçete</th>")
                            %>
                            </tr></thead>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr><td>"&sira&"</td>")
                        Response.Write("<td>" & NetsisRecordSet("ISEMRINO") & "</td><td>" & NetsisRecordSet("MAMUL_KODU") & "</td>") %>
                        <td><div class="badge badge-pill bg-warning" data-bs-target="#exampleModal3" onclick="showAltBomList('<%=NetsisRecordSet("MAMUL_KODU")%>','<%=NetsisRecordSet("ISEMRINO")%>')">
                            <i class="bi bi-journal-text"></i> 
                        </div></td> <%
                        NetsisRecordSet.MoveNext
                    loop
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Set NetsisRecordSet = Nothing
                Set NetsisConnection = Nothing
            Response.Write(" </table> ")


                if sira=0 then response.write ("Kayıt bulunamadı...")     
                'if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")    

%>