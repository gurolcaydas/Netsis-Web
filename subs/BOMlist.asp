<div class="table-responsive">
    <ol class="list-group list-group-numbered"> <%
                    %>
                    <!-- #include file="./dbcon.asp" -->
                    <%              
            url_item=request.querystring("item")          
            ' *************************************** üretim emri reçete [TBLSTOKURS]  <--> [TBLSTOKURM] Reçete'
            Netsis_SQL=           " With Liste as (																 "
            Netsis_SQL=Netsis_SQL+" SELECT  																		 "
            Netsis_SQL=Netsis_SQL+"	CAST(A.[OPNO] as varchar(250)) as SortOrder									 "
            Netsis_SQL=Netsis_SQL+"	,CAST(1 AS INT) as LeveL													 "
            Netsis_SQL=Netsis_SQL+"	,A.[MAMUL_KODU] 															 "
            Netsis_SQL=Netsis_SQL+"	,A.[HAM_KODU]																 "
            Netsis_SQL=Netsis_SQL+"	,A.[MIKTAR] 													 "
            Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLSTOKURM] A										 "
            Netsis_SQL=Netsis_SQL+"  WHERE [MAMUL_KODU]='"&url_item&"'  AND [GEC_FLAG]=0 "
            Netsis_SQL=Netsis_SQL+"																				 "
            Netsis_SQL=Netsis_SQL+"  UNION ALL																	 "
            Netsis_SQL=Netsis_SQL+"																				 "
            Netsis_SQL=Netsis_SQL+" SELECT  																	 "
            Netsis_SQL=Netsis_SQL+"	CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2					 "
            Netsis_SQL=Netsis_SQL+"	, CAST(C.[LeveL]+1 as INT) as Level2										 "
            Netsis_SQL=Netsis_SQL+"	,B.[MAMUL_KODU]																 "
            Netsis_SQL=Netsis_SQL+"	,B.[HAM_KODU]																 "
            Netsis_SQL=Netsis_SQL+"	,B.[MIKTAR]																	 "
            Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLSTOKURM] B										 "
            Netsis_SQL=Netsis_SQL+"																				 "
            Netsis_SQL=Netsis_SQL+"  Join Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU]							 "
            Netsis_SQL=Netsis_SQL+"  )																			 "
            Netsis_SQL=Netsis_SQL+"  Select Y.SortOrder															 "
            Netsis_SQL=Netsis_SQL+"		,Y.Level 													 "
            Netsis_SQL=Netsis_SQL+"		,Y.[MAMUL_KODU] 											 "
            Netsis_SQL=Netsis_SQL+"		,Y.[HAM_KODU] 											 "
            Netsis_SQL=Netsis_SQL+"		,G.[GRUP_ISIM] 											 "
            Netsis_SQL=Netsis_SQL+"		,E.[STOK_ADI] 													 "
            Netsis_SQL=Netsis_SQL+"		,Y.[MIKTAR] 													 "
            Netsis_SQL=Netsis_SQL+"		,E.[OLCU_BR1] 												 "
            Netsis_SQL=Netsis_SQL+"		,Z.[FIYAT1] 											 "
            Netsis_SQL=Netsis_SQL+"		,Z.[FIYATDOVIZTIPI] 									 "
            Netsis_SQL=Netsis_SQL+"		,Z.[OLCUBR] 									 "
            Netsis_SQL=Netsis_SQL+"		,H.[MIKTAR] as 'Alt_Urun' 									 "
            Netsis_SQL=Netsis_SQL+"	 from Liste Y																 "
            Netsis_SQL=Netsis_SQL+"  OUTER APPLY (SELECT TOP 1 [FIYAT1],[FIYATDOVIZTIPI],[OLCUBR] FROM [db2022].[dbo].[TBLSTOKFIAT] WHERE  Y.HAM_KODU=[STOKKODU] ORDER BY [BASTAR] DESC) Z "
            Netsis_SQL=Netsis_SQL+"  OUTER APPLY (SELECT TOP 1 [MIKTAR] FROM [db2022].[dbo].[TBLSTOKURM] WHERE  Y.[HAM_KODU]=[MAMUL_KODU] ) H "
            Netsis_SQL=Netsis_SQL+"  LEFT JOIN [db2022].[dbo].[TBLSTSABIT] E ON Y.[HAM_KODU]=E.[STOK_KODU]	 "
            Netsis_SQL=Netsis_SQL+"  LEFT JOIN [db2022].[dbo].[TBLSTOKKOD4] G ON E.[KOD_4]=G.[GRUP_KOD]		 "
            Netsis_SQL=Netsis_SQL+"  ORDER BY SortOrder															 "
            sira=0
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                do until NetsisRecordSet.EOF
                    Sira=sira+1

                    Select Case NetsisRecordSet("LeveL")
                        Case 1
                            renkli=" text-danger"
                            bosluk=""      
                        Case 2
                            renkli=" text-secondary"
                            bosluk="&emsp;<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z'/></svg>"
                        Case 3
                            renkli=" text-success"                                          
                            bosluk="&emsp;&emsp;<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z'/></svg>"
                        Case 4
                            renkli=" text-primary"
                            bosluk="&emsp;&emsp;&emsp;<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z'/></svg>"
                        Case 5
                            renkli=" text-danger"
                            bosluk="&emsp;&emsp;&emsp;&emsp;<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-arrow-return-right' viewBox='0 0 16 16'><path fill-rule='evenodd' d='M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z'/></svg>"
                        Case Else
                            bosluk=""
                            renkli=" text-danger"
                    end Select 
                    Response.ContentType = "text/html"
                    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
                    Response.CodePage = 65001
                    Response.CharSet = "UTF-8" %>
                    <li class="list-group-item d-flex justify-content-between align-items-start">
                        <div class="ms-2 me-auto">
                        <div class="fw-bold <%=renkli%>"><%=bosluk%><%=NetsisRecordSet("HAM_Kodu")%></div>
                        <div class="fw-bold <%=renkli%>" style="--bs-text-opacity: .5;"><%=bosluk%><%=NetsisRecordSet("GRUP_ISIM")%></div>
                            <%=NetsisRecordSet("STOK_ADI")%>
                        </div>
                        <span class="badge bg-primary rounded-pill"><%=NetsisRecordSet("MIKTAR")%>&nbsp;<%=NetsisRecordSet("OLCU_BR1")%></span>
                    </li> <%
                    NetsisRecordSet.movenext
                Loop
            NetsisRecordSet.close
        NetsisConnection.Close
        Set NetsisRecordSet = Nothing
        Set NetsisConnection = Nothing
        if sira=0 then  response.write("no data!" ) %>
    </ol>
</div>