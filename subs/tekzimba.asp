        <!-- #include file="./dbcon.asp" -->
        <%            
        url_item = request.querystring("item")      %>
            <table class="table table-sm table-striped table-hover align-middle">                        <%
                Netsis_SQL=" "
                Netsis_SQL=Netsis_SQL+" With Liste as (																				"
                Netsis_SQL=Netsis_SQL+" 	SELECT  																				"
                Netsis_SQL=Netsis_SQL+" 		CAST(A.[OPNO] as varchar(250)) as SortOrder											"
                Netsis_SQL=Netsis_SQL+" 		,CAST(1 AS INT) as LeveL															"
                Netsis_SQL=Netsis_SQL+" 		,A.[MAMUL_KODU] 																	"
                Netsis_SQL=Netsis_SQL+" 		,A.[HAM_KODU]																		"
                Netsis_SQL=Netsis_SQL+" 		,A.[MIKTAR]																			"
                Netsis_SQL=Netsis_SQL+" 		,CAST(A.[MAMUL_KODU]  as varchar(250)) as agac										"
                Netsis_SQL=Netsis_SQL+" 	FROM [db2022].[dbo].[TBLSTOKURM] A													"
                Netsis_SQL=Netsis_SQL+" 	WHERE [GEC_FLAG]=0 "
                Netsis_SQL=Netsis_SQL+" 	AND  [MAMUL_KODU] IN ('"&url_item&"')												"
                Netsis_SQL=Netsis_SQL+" 	UNION ALL																				"
                Netsis_SQL=Netsis_SQL+" 	SELECT  																				"
                Netsis_SQL=Netsis_SQL+" 		CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2							"
                Netsis_SQL=Netsis_SQL+" 		, CAST(C.[LeveL]+1 as INT) as Level2												"
                Netsis_SQL=Netsis_SQL+" 		,B.[MAMUL_KODU]																		"
                Netsis_SQL=Netsis_SQL+" 		,B.[HAM_KODU]																		"
                Netsis_SQL=Netsis_SQL+" 		,B.[MIKTAR]																			"
                Netsis_SQL=Netsis_SQL+"        	,CAST(C.[agac]  as varchar(250)) as agac2              								"
                Netsis_SQL=Netsis_SQL+" 	FROM [db2022].[dbo].[TBLSTOKURM] B													"
                Netsis_SQL=Netsis_SQL+" 	JOIN Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU]										"
                Netsis_SQL=Netsis_SQL+" 	)																						"
                Netsis_SQL=Netsis_SQL+" SELECT 																						"
                Netsis_SQL=Netsis_SQL+" 	Y.SortOrder as 'Sort_order'																"
                Netsis_SQL=Netsis_SQL+" 	,Y.Level as 'Seviye'																	"
                Netsis_SQL=Netsis_SQL+" 	,Y.agac as 'Ana_mamul'																	"
                Netsis_SQL=Netsis_SQL+" 	,Y.[MAMUL_KODU] as 'Recete'																"
                Netsis_SQL=Netsis_SQL+" 	,Y.[HAM_KODU] as 'Madde_kodu'															"
                Netsis_SQL=Netsis_SQL+" 	,G.[GRUP_ISIM] as 'Madde_grubu'															"
                Netsis_SQL=Netsis_SQL+" 	,E.[STOK_ADI] as 'Stok_Adi'																"
                Netsis_SQL=Netsis_SQL+" 	,Y.[MIKTAR] as 'Recete_Miktari'															"
                Netsis_SQL=Netsis_SQL+" 	,E.[OLCU_BR1] as 'Birim'																"
                Netsis_SQL=Netsis_SQL+" from Liste Y																				"
                Netsis_SQL=Netsis_SQL+" LEFT JOIN [db2022].[dbo].[TBLSTSABIT] E ON Y.[HAM_KODU]=E.[STOK_KODU]					"
                Netsis_SQL=Netsis_SQL+" LEFT JOIN [db2022].[dbo].[TBLSTOKKOD4] G ON E.[KOD_4]=G.[GRUP_KOD]						"
                Netsis_SQL=Netsis_SQL+" WHERE Y.HAM_KODU IN (																		"
                Netsis_SQL=Netsis_SQL+" SELECT  																					"
                Netsis_SQL=Netsis_SQL+" A.[STOK_KODU]  																				"
                Netsis_SQL=Netsis_SQL+" FROM [db2022].[dbo].[TBLSTOKPH] A WITH (NOLOCK)  										"
                Netsis_SQL=Netsis_SQL+" INNER JOIN [db2022].[dbo].[TBLSTOKDP] B  WITH (NOLOCK) ON A.[DEPO_KODU]=B.[DEPO_KODU]  	"
                Netsis_SQL=Netsis_SQL+" INNER JOIN [db2022].[dbo].[TBLSTSABIT] C  WITH (NOLOCK) ON A.[STOK_KODU]=C.[STOK_KODU] "
                Netsis_SQL=Netsis_SQL+" INNER JOIN [db2022].[dbo].[TBLSTOKKOD1] D  WITH (NOLOCK)  ON C.[KOD_1]=D.[GRUP_KOD]    "
                Netsis_SQL=Netsis_SQL+" WHERE A.[DEPO_KODU]=10 AND [TOP_GIRIS_MIK]+[TOP_CIKIS_MIK]!=0  							   "
                Netsis_SQL=Netsis_SQL+" )																						   "
                Netsis_SQL=Netsis_SQL+" ORDER BY SortOrder																		   "
                'response.write(Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=1000
                        if sira=0 then                         %>
                            <thead><tr> <%
                            Response.Write("<th>Sıra</th>")
                            for each x in  NetsisRecordSet.Fields
                                Response.Write("<th>" & x.name & "</th>")
                            next                    %>
                            </tr></thead>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr><td>"&sira&"</td>")
                        for each x in  NetsisRecordSet.Fields
                            'Response.Write(x.name)
                            'Response.Write(" = ")
                            Response.Write("<td>" & x.value & "</td>")
                        next
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