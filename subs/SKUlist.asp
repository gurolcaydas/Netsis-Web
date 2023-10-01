<div class="list-group">         
    <ol class="list-group list-group-numbered">
        <%  
        Response.ContentType = "text/html"
        Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
        Response.CodePage = 65001
        Response.CharSet = "UTF-8"
        q=request.querystring("q") 'arama alanları
        r=request.querystring("r") 'arama alanları
        p=request.querystring("p") 'arama alanları
        s=request.querystring("s") 'yaynlanacak alan ID
                    %>
                    <!-- #include file="./dbcon.asp" -->
                    <%
            Netsis_SQL="SELECT TOP 25																	"
            Netsis_SQL=Netsis_SQL+"		[STOK_KODU]															"
            Netsis_SQL=Netsis_SQL+"		,[STOK_ADI]	,[GRUP_ISIM],[GRUP_KODU]														"
            Netsis_SQL=Netsis_SQL+"FROM [db2022].[dbo].[TBLSTSABIT] 										"
            Netsis_SQL=Netsis_SQL+"LEFT JOIN [db2022].[dbo].[TBLSTOKKOD1] ON [KOD_1]=[GRUP_KOD]									"
            Netsis_SQL=Netsis_SQL+"WHERE [STOK_KODU] LIKE '%"&q&"%' "
            Netsis_SQL=Netsis_SQL+" AND [STOK_ADI] LIKE '%"&r&"%'						  "
            Netsis_SQL=Netsis_SQL+" AND [GRUP_ISIM] LIKE '%"&p&"%'						  "
            Netsis_SQL=Netsis_SQL+" ORDER BY [STOK_ADI]	"
            sira=0
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                do until NetsisRecordSet.EOF 
                    renkli=""
                    SELECT CASE NetsisRecordSet("GRUP_KODU")
                        CASE "FP1"
                        renkli="bg-primary"
                        CASE "CO1"
                        renkli="bg-secondary"
                        CASE "PA1"
                        renkli="bg-success"
                        CASE "NS1"
                        renkli="bg-danger" 
                    END SELECT                    
                    sira=sira+1
                    BizimKod=NetsisRecordSet("STOK_KODU")
                    %>
                    <li class="list-group-item d-flex justify-content-between align-items-start">
                        <div class="ms-2 me-auto">
                        <div class="fw-bold "><%=replace(NetsisRecordSet("STOK_KODU"),q,"<mark>"&q&"</mark>",1,-1,1)%></div>
                            <input type="radio" class="form-check-input me-1" id="radioo<%=s%>" name="radio<%=s%>" value="<%=BizimKod%>" onclick="showBOMlist('subs/BOMlist.asp?item=<%=BizimKod%>','<%=s%>')" ><%=replace(NetsisRecordSet("STOK_ADI"),r,"<mark>"&r&"</mark>",1,-1,1)%>
                        </div>
                        <span class="badge bg-primary rounded-pill <%=renkli%>"><%=NetsisRecordSet("GRUP_ISIM")%></span>
                    </li>
                    <%
                    NetsisRecordSet.movenext
                Loop
            NetsisRecordSet.close
            if sira=0 then response.write("no data!" )           
        NetsisConnection.Close
        Set NetsisRecordSet = Nothing
        Set NetsisConnection = Nothing
        %>
    </ol>
</div>