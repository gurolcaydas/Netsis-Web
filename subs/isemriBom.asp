        <!-- #include file="./dbcon.asp" -->
        <%            
        url_item = request.querystring("item")  
                   url_isemri = request.querystring("isemri")     
         %>

                        <div class="container-fluid p-4">  <!-- bomlist iş emri -->
                            <h2><%=url_item%></h2>  

                            <table class="table table-sm table-striped table-hover align-middle"> <% ' *************************************** üretim emri reçete [TBLSTOKURS]??  <--> [TBLSTOKURM] Reçete'
                                ' SQL
                                    Netsis_SQL= " With Liste as ( "
                                    Netsis_SQL=Netsis_SQL+" SELECT "
                                    Netsis_SQL=Netsis_SQL+" CAST(A.[OPNO] as varchar(250)) as SortOrder "
                                    Netsis_SQL=Netsis_SQL+" ,CAST(1 AS INT) as LeveL "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,A.[HAM_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MIKTAR] "
                                    Netsis_SQL=Netsis_SQL+" ,A.[STOK_MALIYET] "
        
                                    Netsis_SQL=Netsis_SQL+" FROM [db2022].[dbo].[TBLISEMRIREC] A "
                                    Netsis_SQL=Netsis_SQL+" WHERE A.[MAMUL_KODU]='"&url_item&"' AND A.[ISEMRINO]='"&url_isemri&"' AND A.[GEC_FLAG]=0"
                                    Netsis_SQL=Netsis_SQL+" "
                                    Netsis_SQL=Netsis_SQL+" UNION ALL "
                                    Netsis_SQL=Netsis_SQL+" "
                                    Netsis_SQL=Netsis_SQL+" SELECT "
                                    Netsis_SQL=Netsis_SQL+" CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2 "
                                    Netsis_SQL=Netsis_SQL+" , CAST(C.[LeveL]+1 as INT) as Level2 "
                                    Netsis_SQL=Netsis_SQL+" ,B.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,B.[HAM_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,B.[MIKTAR] "
                                    Netsis_SQL=Netsis_SQL+" ,B.[STOK_MALIYET] "
                                    Netsis_SQL=Netsis_SQL+" FROM [db2022].[dbo].[TBLISEMRIREC] B "
                                    Netsis_SQL=Netsis_SQL+" "
                                    Netsis_SQL=Netsis_SQL+" Join Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" WHERE B.[GEC_FLAG]=0 AND B.[ISEMRINO]='"&url_isemri&"' "
                                    Netsis_SQL=Netsis_SQL+" ) "
                                    Netsis_SQL=Netsis_SQL+" Select Y.SortOrder "
                                    Netsis_SQL=Netsis_SQL+" ,Y.Level "
                                    Netsis_SQL=Netsis_SQL+" ,Y.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,Y.[HAM_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,G.[GRUP_ISIM] "
                                    Netsis_SQL=Netsis_SQL+" ,E.[STOK_ADI] "
                                    Netsis_SQL=Netsis_SQL+" ,Y.[MIKTAR] "
                                    Netsis_SQL=Netsis_SQL+" ,E.[OLCU_BR1] "
                                    Netsis_SQL=Netsis_SQL+" ,K.[GRUP_ISIM] as 'Tedarikci' "
                                    Netsis_SQL=Netsis_SQL+" ,Z.[FIYAT1] "
                                    Netsis_SQL=Netsis_SQL+" ,Z.[FIYATDOVIZTIPI] "
                                    Netsis_SQL=Netsis_SQL+" ,Z.[OLCUBR] "
                                    Netsis_SQL=Netsis_SQL+" ,J.[OPKODU] as 'Operasyon_kodu' "
                                    Netsis_SQL=Netsis_SQL+" ,J.[OPISIM] as 'Operasyon' "
                                    Netsis_SQL=Netsis_SQL+" ,J.[OPMIK] as 'Operasyon_miktar' "
                                    Netsis_SQL=Netsis_SQL+" ,H.[MIKTAR] as 'Alt_Urun' " 
                                    Netsis_SQL=Netsis_SQL+" ,Y.[STOK_MALIYET] as 'Maliyet' " 
                                    Netsis_SQL=Netsis_SQL+" from Liste Y "
                                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP 1 [FIYAT1],[FIYATDOVIZTIPI],[OLCUBR] FROM [db2022].[dbo].[TBLSTOKFIAT] WHERE Y.HAM_KODU=[STOKKODU] ORDER BY [BASTAR] DESC) Z "
                                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP 1 [MIKTAR] FROM [db2022].[dbo].[TBLSTOKURM] WHERE Y.[HAM_KODU]=[MAMUL_KODU] ) H "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN [db2022].[dbo].[TBLSTSABIT] E ON Y.[HAM_KODU]=E.[STOK_KODU] "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN [db2022].[dbo].[TBLOPERATIONS_KATALOG] J ON Y.[HAM_KODU]=J.[OPKODU] "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN [db2022].[dbo].[TBLSTOKKOD2] K ON E.[KOD_2]=K.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN [db2022].[dbo].[TBLSTOKKOD4] G ON E.[KOD_4]=G.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL+" ORDER BY SortOrder "
                                ' SQL ende
                    Response.ContentType = "text/html"
                    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
                    Response.CodePage = 65001
                    Response.CharSet = "UTF-8"                                 
                                sira=0
                                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1                        
                                    do until NetsisRecordSet.EOF
                                        if sira=0 then %>
                                            <thead><tr>
                                                <th></th>
                                                <th colspan=2>Kod</th>
                                                <th colspan=1>Stok Adı</th>
                                                <th colspan=1>Kod 2</th>
                                                <th colspan=2>Miktar</th>
                                            </tr></thead>                                 <%
                                        end if
                                        Sira=sira+1                      
                                        renkli=" class='text-danger' "
                                        Select Case NetsisRecordSet("LeveL")
                                        Case 1
                                        renkli=" class='text-danger' "      
                                        Case 2
                                        renkli=" class='text-secondary' "
                                        Case 3
                                        renkli=" class='text-success' "                                          
                                        Case 4
                                        renkli=" class='text-primary' "
                                        end Select  
                                        response.write("<tr>")  
                                            response.write(" <td>"&Sira&"</td>")
                                            response.write(" <td " & renkli & " >")
                                                for i=1 to (NetsisRecordSet("Level")-1)*3
                                                    response.write("&nbsp;")
                                                next
                                            response.write("<b>"&NetsisRecordSet("HAM_Kodu")&"</b></td>")
 
                                            Dim bunutaz
                                            bunutaz=NetsisRecordSet("HAM_Kodu")
                                               %><!-- Modal -->   
                                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title"  id="fiyatlarbaslik"></h5>
                                                        </div>
                                                        <div class="modal-body" id="fiyatlar">
                                                            ...
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>                                                        
                                            <%
                                            response.write(" <td " & renkli & " >")
                                                for i=1 to (NetsisRecordSet("Level")-1)*3
                                                    response.write("&nbsp;")
                                                next
                                            'if LEFT(NetsisRecordSet("GRUP_ISIM"),5)="KADRO" OR LEFT(NetsisRecordSet("GRUP_ISIM"),5)="CATAL" then kadroDWG="<a target='_blank' href='http://qdms.bianchi.com/QDMSNET/Document/DokumanGoruntuleme.aspx?ROWINDEX=0&PAGEINDEX=0&kod="&NetsisRecordSet("HAM_Kodu")&"'><img  width='16' height='16'  src='img/icons/icons8-Design.png' title='Teknik Çizim' /></a>" else kadroDWG=""
                                                'http://qdms.bianchi.com/QDMSNET/Document/DokumanGoruntuleme.aspx?ROWINDEX=0&PAGEINDEX=0&kod='
                                            response.write(" <b>"&NetsisRecordSet("GRUP_ISIM")&"</b> "&kadroDWG&"</td>")
                                            if NetsisRecordSet("STOK_ADI")<>"" then response.write(" <td>"&NetsisRecordSet("STOK_ADI")&"</td>") else response.write(" <td>"&NetsisRecordSet("Operasyon")&"</td>") 
                                            response.write(" <td>"&NetsisRecordSet("Tedarikci")&"</td>")
                                            response.write(" <td>"&NetsisRecordSet("MIKTAR")&"</td>")
                                            response.write(" <td>"&NetsisRecordSet("OLCU_BR1")&"</td>")
                                            response.write(" <td>"&NetsisRecordSet("Maliyet")&"</td>")
                                            ' response.write(" <td>")
                                            ' 'if NetsisRecordSet("FIYAT1") then response.write(" "&NetsisRecordSet("FIYAT1")&" ["&NetsisRecordSet("FIYATDOVIZTIPI")&"] <font color='orange'>["&NetsisRecordSet("OLCUBR")&"]</font>") 
                                            ' response.write("</td>")
                                        response.write("</tr>")
                                        NetsisRecordSet.movenext
                                    Loop
                                NetsisRecordSet.close %>
                            </table>
                        </div>
                        <%
                Set NetsisRecordSet = Nothing
                Set NetsisConnection = Nothing %>
