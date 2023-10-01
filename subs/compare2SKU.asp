<% 
sku1=request.querystring("sku1")
sku2=request.querystring("sku2")
Dim table1(10,1000)
Dim table2(10,1000)



               


                ' *************************************** üretim emri reçete [TBLSTOKURS]  <--> [TBLSTOKURM] Reçete'
                    %>
                    <!-- #include file="./dbcon.asp" -->
                    <%             
                Netsis_SQL=           " With Liste as (																 "
                Netsis_SQL=Netsis_SQL+" SELECT  																		 "
                Netsis_SQL=Netsis_SQL+"	CAST(A.[OPNO] as varchar(250)) as SortOrder									 "
                Netsis_SQL=Netsis_SQL+"	,CAST(1 AS INT) as LeveL													 "
                Netsis_SQL=Netsis_SQL+"	,A.[MAMUL_KODU] 															 "
                Netsis_SQL=Netsis_SQL+"	,A.[HAM_KODU]																 "
                Netsis_SQL=Netsis_SQL+"	,A.[MIKTAR] 												 "
                Netsis_SQL=Netsis_SQL+"	,CAST(A.[HAM_KODU] as varchar(250)) as agac				 "
                Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLSTOKURM] A										 "
                Netsis_SQL=Netsis_SQL+"  WHERE [MAMUL_KODU]='"&sku1&"'  AND [GEC_FLAG]=0		                                                     "
                Netsis_SQL=Netsis_SQL+"																				 "
                Netsis_SQL=Netsis_SQL+"  UNION ALL																	 "
                Netsis_SQL=Netsis_SQL+"																				 "
                Netsis_SQL=Netsis_SQL+" SELECT  																	 "
                Netsis_SQL=Netsis_SQL+"	CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2					 "
                Netsis_SQL=Netsis_SQL+"	, CAST(C.[LeveL]+1 as INT) as Level2										 "
                Netsis_SQL=Netsis_SQL+"	,B.[MAMUL_KODU]																 "
                Netsis_SQL=Netsis_SQL+"	,B.[HAM_KODU]																 "
                Netsis_SQL=Netsis_SQL+"	,B.[MIKTAR]																	 "
                Netsis_SQL=Netsis_SQL+"	,CAST(C.[agac] +' / '+ B.[HAM_KODU] as varchar(250)) as agac2              "
                Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLSTOKURM] B										 "
                Netsis_SQL=Netsis_SQL+"																				 "
                Netsis_SQL=Netsis_SQL+"  Join Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU]							 "
                Netsis_SQL=Netsis_SQL+" WHERE B.[GEC_FLAG]=0                                                         "
                Netsis_SQL=Netsis_SQL+"  )																			 "
                Netsis_SQL=Netsis_SQL+"  Select Y.SortOrder															 "
                Netsis_SQL=Netsis_SQL+"		,Y.Level 												 "
                Netsis_SQL=Netsis_SQL+"		,Y.agac			 "
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

                            renkli=" text-danger"
                            Select Case NetsisRecordSet("LeveL")
                                Case 1
                                renkli=" text-danger"
                                Case 2
                                renkli=" text-secondary"
                                Case 3
                                renkli=" text-success"                                          
                                Case 4
                                renkli=" text-primary"
                                Case 5
                                renkli=" text-danger"
                            end Select 




                        Table1(7,sira)="<div class='ms-2 me-auto'><div class='fw-bold "&renkli&"'>"
                         Table1(8,sira)=replace(NetsisRecordSet("agac"),NetsisRecordSet("HAM_Kodu"),"<span  class='fw-bold h5'>"&NetsisRecordSet("HAM_Kodu")&"</span>")&"</div><div class='fw-bold  "&renkli&"' style='--bs-text-opacity: .7;'>"&NetsisRecordSet("GRUP_ISIM")
                         Table1(9,sira)="</div>"&NetsisRecordSet("STOK_ADI")&"</div><span class='badge bg-primary rounded-pill'>"&NetsisRecordSet("MIKTAR")&"&nbsp;"&NetsisRecordSet("OLCU_BR1")&" </span>"

                        Table1(2,sira)=NetsisRecordSet("GRUP_ISIM")
                        Table1(3,sira)=NetsisRecordSet("HAM_KODU")
                        Table1(4,sira)=CSTR(NetsisRecordSet("MIKTAR"))
                        Table1(5,sira)=" list-group-item-warning "
                        Table1(1,sira)=" bg-warning "
                        Table1(6,sira)="Yok"
                        NetsisRecordSet.movenext
                    Loop
                NetsisRecordSet.close

                ' *************************************** üretim emri reçete [TBLSTOKURS]  <--> [TBLSTOKURM] Reçete'
           
                Netsis_SQL=           " With Liste as (																 "
                Netsis_SQL=Netsis_SQL+" SELECT  																		 "
                Netsis_SQL=Netsis_SQL+"	CAST(A.[OPNO] as varchar(250)) as SortOrder									 "
                Netsis_SQL=Netsis_SQL+"	,CAST(1 AS INT) as LeveL													 "
                Netsis_SQL=Netsis_SQL+"	,A.[MAMUL_KODU] 															 "
                Netsis_SQL=Netsis_SQL+"	,A.[HAM_KODU]																 "
                Netsis_SQL=Netsis_SQL+"	,A.[MIKTAR] 												 "
                Netsis_SQL=Netsis_SQL+"	,CAST(A.[HAM_KODU] as varchar(250)) as agac				 "
                Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLSTOKURM] A										 "
                Netsis_SQL=Netsis_SQL+"  WHERE [MAMUL_KODU]='"&sku2&"'	 AND [GEC_FLAG]=0 "  'GEC_FLAG çıkartılmış parçaları filtreliyor'
                Netsis_SQL=Netsis_SQL+"																				 "
                Netsis_SQL=Netsis_SQL+"  UNION ALL																	 "
                Netsis_SQL=Netsis_SQL+"																				 "
                Netsis_SQL=Netsis_SQL+" SELECT  																	 "
                Netsis_SQL=Netsis_SQL+"	CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2					 "
                Netsis_SQL=Netsis_SQL+"	, CAST(C.[LeveL]+1 as INT) as Level2										 "
                Netsis_SQL=Netsis_SQL+"	,B.[MAMUL_KODU]																 "
                Netsis_SQL=Netsis_SQL+"	,B.[HAM_KODU]																 "
                Netsis_SQL=Netsis_SQL+"	,B.[MIKTAR]																	 "
                Netsis_SQL=Netsis_SQL+"	,CAST(C.[agac] +' / '+ B.[HAM_KODU] as varchar(250)) as agac2              "
                Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLSTOKURM] B										 "
                Netsis_SQL=Netsis_SQL+"																				 "
                Netsis_SQL=Netsis_SQL+"  Join Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU]							 "
                Netsis_SQL=Netsis_SQL+"   WHERE B.[GEC_FLAG]=0       )																			 "
                Netsis_SQL=Netsis_SQL+"  Select Y.SortOrder															 "
                Netsis_SQL=Netsis_SQL+"		,Y.Level 												 "
                Netsis_SQL=Netsis_SQL+"		,Y.agac			 "
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

                sira2=0
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                    do until NetsisRecordSet.EOF
                            sira2=sira2+1
                            renkli=" text-danger"
                            Select Case NetsisRecordSet("LeveL")
                            Case 1
                            renkli=" text-danger"
                            Case 2
                            renkli=" text-secondary"
                            Case 3
                            renkli=" text-success"                                          
                            Case 4
                            renkli=" text-primary"
                            Case 5
                            renkli=" text-danger"
                            end Select 
                        

                         Table2(7,sira2)="<div class='ms-2 me-auto'><div class='fw-bold "&renkli&"'>"
                         Table2(8,sira2)=replace(NetsisRecordSet("agac"),NetsisRecordSet("HAM_Kodu"),"<span  class='fw-bold h5'>"&NetsisRecordSet("HAM_Kodu")&"</span></div><div class='fw-bold  "&renkli&"' style='--bs-text-opacity: .7;'>"&NetsisRecordSet("GRUP_ISIM"))
                         Table2(9,sira2)="</div>"&NetsisRecordSet("STOK_ADI")&"</div><span class='badge bg-primary rounded-pill'>"&NetsisRecordSet("MIKTAR")&"&nbsp;"&NetsisRecordSet("OLCU_BR1")&"</span>"

                        Table2(2,sira2)=NetsisRecordSet("GRUP_ISIM")
                        Table2(3,sira2)=NetsisRecordSet("HAM_KODU")
                        Table2(4,sira2)=CSTR(NetsisRecordSet("MIKTAR"))
                        Table2(5,sira2)=" list-group-item-warning "
                        Table2(1,sira2)=" bg-warning "
                        Table2(6,sira2)="Yok"
                        NetsisRecordSet.movenext
                    Loop
                NetsisRecordSet.close
                NetsisConnection.Close
    Set NetsisRecordSet = Nothing
    Set NetsisConnection = Nothing




        if sira=0 then  
            response.write("no data!" )
        else                ' 2- grup_isim, 3-ham_kodu, 4-miktar
            For i=1 to sira ' birebir aynı olanları OK işaretle '
                For j=1 to sira2
                    if  Table1(3,i)=Table2(3,j) and  Table1(4,i)=Table2(4,j) AND Table1(6,i)="Yok"  AND Table2(6,j)="Yok" then
                        Table1(5,i)=" list-group-item-success "                        
                        Table2(5,j)=" list-group-item-success "
                        Table1(1,i)=" bg-success "                        
                        Table2(1,j)=" bg-success "
                        Table1(6,i)="OK"
                        Table2(6,j)="OK" 
                    end If                               
                next
            next
            For i=1 to sira ' grup aynı, kod aynı ama miktar farklı'
                For j=1 to sira2
                    if Table1(2,i)=Table2(2,j) and  Table1(3,i)=Table2(3,j) and  Table1(4,i)<>Table2(4,j) AND Table1(6,i)="Yok"  AND Table2(6,j)="Yok" then
                        Table1(5,i)=" list-group-item-primary "                        
                        Table2(5,j)=" list-group-item-primary "
                        Table1(1,i)=" bg-primary "                        
                        Table2(1,j)=" bg-primary "
                        Table1(6,i)="miktar farkli"
                        Table2(6,j)="miktar farkli" 
                    end if
                       
                next
            next  
            For i=1 to sira          ' 2- grup_isim, 3-ham_kodu, 4-miktar
                For j=1 to sira2     ' grup aynı, kod farklı '       
                    if Table1(2,i)=Table2(2,j) and  Table1(3,i)<>Table2(3,j) and  (Table1(6,i)="Yok" OR Table1(6,i)="kod farkli")  AND (Table2(6,j)="Yok" or Table2(6,j)="kod farkli") then
                        Table1(5,i)=" list-group-item-secondary "                        
                        Table2(5,j)=" list-group-item-secondary "
                        Table1(1,i)=" bg-secondary "                        
                        Table2(1,j)=" bg-secondary "                        
                        Table1(6,i)="kod farkli"
                        Table2(6,j)="kod farkli" 
                    end if        
    
                next
            next        
            For i=1 to sira
                For j=1 to sira2            

                    if Table1(2,i)<>Table2(2,j) and  Table1(3,i)<>Table2(3,j) and  (Table1(6,i)="Yok" OR Table1(6,i)="eksik")  AND (Table2(6,j)="Yok" OR Table2(6,j)="eksik") then
                        Table1(5,i)=" list-group-item-warning "                        
                        Table2(5,j)=" list-group-item-warning "
                        Table1(1,i)=" bg-warning "                        
                        Table2(1,j)=" bg-warning "
                        Table1(6,i)="eksik"
                        Table2(6,j)="eksik"                         
                    end if         

                       
                next
            next                    
            %>
            <h4>Karşılaştırma</h4>
            <table class='table '><tr><td>
 
                    <div class="table-responsive">
                        <ol class="list-group">
                            <%
                            Response.CodePage = 65001
                            For i=1 to sira
                                response.write(""&"<li class='list-group-item d-flex justify-content-between "&Table1(5,i)&" align-items-start'>")
                                response.write(Table1(7,i)&Table1(8,i)&" <span class='badge "&Table1(1,i)&" rounded-pill'>"&Table1(6,i)&"</span>"&Table1(9,i)&"</li>")                         
                            next
                            %>
                        </ol>
                    </div>
            </td><td>
               
                    <div class="table-responsive">
                        <ol class="list-group">
                            <%
                            Response.CodePage = 65001
                            For j=1 to sira2
                                response.write(""&"<li class='list-group-item d-flex justify-content-between "&Table2(5,j)&" align-items-start'>")
                                response.write(Table2(7,j)&Table2(8,j)&" <span class='badge "&Table2(1,j)&" rounded-pill'>"&Table2(6,j)&"</span>"&Table2(9,j)&"</li>")
                            next
                            %>
                        </ol>
                    </div>
              
            </td></tr></table>
            <%
        end if %>