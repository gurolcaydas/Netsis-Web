<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Recete" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
        <!-- #include file="./subs/dbcon.asp" -->
<script type="text/javascript" src="include/xlsx.full.min.js"></script>
    <script type="text/javascript">

        function html_table_to_excel(type,str,str2)    {  // Excel
            var data = document.getElementById(str2);
            var file = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
            XLSX.write(file, { bookType: type, bookSST: true, type: 'base64' });
            XLSX.writeFile(file, str + '.' + type);
        }
 
    </script>
    
<%

if instr(UserLevel,"s") then 'needed level' 
        search_madde_kodu = BeniKoddanArindir(request.form("search_madde_kodu"))
        search_dolar = BeniKoddanArindir(request.form("search_dolar"))
        if search_dolar="" then search_dolar=1

        search_lira = BeniKoddanArindir(request.form("search_lira"))
        if search_lira="" then 
            Netsis_SQL="SELECT top 1 DOV_SATIS FROM NETSIS..DOVIZ WHERE DOVIZ.SIRA ='1' ORDER BY DOVIZ.TARIH DESC "
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            search_lira=NetsisRecordSet("DOV_SATIS")
            NetsisRecordSet.close
        end if 

        search_euro = BeniKoddanArindir(request.form("search_euro"))
        if search_euro="" then 
            Netsis_SQL="SELECT top 1 DOV_SATIS FROM NETSIS..DOVIZ WHERE DOVIZ.SIRA ='2' ORDER BY DOVIZ.TARIH DESC "
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            search_euro=NetsisRecordSet("DOV_SATIS")/search_lira
            NetsisRecordSet.close
        end if 

        search_rmb = BeniKoddanArindir(request.form("search_rmb"))
        if search_rmb="" then 
            Netsis_SQL="SELECT top 1 DOV_SATIS FROM NETSIS..DOVIZ WHERE DOVIZ.SIRA ='7' ORDER BY DOVIZ.TARIH DESC "
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            search_rmb=search_lira/NetsisRecordSet("DOV_SATIS")
            NetsisRecordSet.close
        end if 

        search_yen = BeniKoddanArindir(request.form("search_yen"))
        if search_yen="" then 
            Netsis_SQL="SELECT top 1 DOV_SATIS FROM NETSIS..DOVIZ WHERE DOVIZ.SIRA ='3' ORDER BY DOVIZ.TARIH DESC "
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            search_yen=search_lira/NetsisRecordSet("DOV_SATIS")
            NetsisRecordSet.close
        end if 

        search_twd = BeniKoddanArindir(request.form("search_twd"))

        search_dolar=replace(search_dolar,",",".")
        search_lira=replace(search_lira,",",".")
        search_euro=replace(search_euro,",",".")
        search_rmb=replace(search_rmb,",",".")
        search_yen=replace(search_yen,",",".")
        search_twd=replace(search_twd,",",".")

  %>         
    <div class="container-fluid" style="margin-top:80px"> 

        <div class="container-fluid p-4"> <h3></h3>

            
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Reçete Göster</h4>         
                        <div class="input-group">
                            <span class="input-group-text">Kod</span><input  required class="form-control" type="text" name="search_madde_kodu"  placeholder="Stok Kodu"  value="<%=search_madde_kodu%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">USD/USD</span><input  required class="form-control"  type="text"  name="search_dolar"  placeholder="dolar/dolar"  value="<%=search_dolar%>">
                            <span class="input-group-text">TRY/USD</span><input  required class="form-control"  type="text"  name="search_lira"  placeholder="lira/dolar"  value="<%=search_lira%>">
                            <span class="input-group-text">USD/EUR</span><input  required class="form-control"  type="text"  name="search_euro"  placeholder="dolar/euro"  value="<%=search_euro%>">
                            <span class="input-group-text">RMB/USD</span><input  required class="form-control"  type="text"  name="search_rmb"  placeholder="rmb/dolar"  value="<%=search_rmb%>">
                            <span class="input-group-text">JPY/USD</span><input  required class="form-control"  type="text"  name="search_yen"  placeholder="yen/dolar"  value="<%=search_yen%>">
                            <span class="input-group-text">TWD/USD</span><input  required class="form-control"  type="text"  name="search_twd"  placeholder="twd/dolar"  value="<%=search_twd%>">
                        </div>
                    </div>                           
                </form> 
            
<%
if url_doo="list" then 
%>
                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
<input type="button" value="Export to Excel" onclick="html_table_to_excel('xlsx','filename','tblData')" />
            <table class="table table-sm table-striped table-hover align-middle" id="tblData">         <%
                ' SQL   Rapor-CariStokEksik.asp
                    Netsis_SQL=" With Liste as (																																								 "
                    Netsis_SQL=Netsis_SQL+" 		SELECT  																																							 "
                    Netsis_SQL=Netsis_SQL+" 			CAST(A.[MAMUL_KODU] +'.'+ A.[OPNO] as varchar(250)) as SortOrder																								 "
                    Netsis_SQL=Netsis_SQL+" 			,CAST(A.[MAMUL_KODU] as varchar(250)) as UstRecete																												 "
                    Netsis_SQL=Netsis_SQL+" 			,CAST(1 AS INT) as LeveL																																		 "
                    Netsis_SQL=Netsis_SQL+" 			,A.[MAMUL_KODU] 																																				 "
                    Netsis_SQL=Netsis_SQL+" 			,A.[HAM_KODU]																																					 "
                    Netsis_SQL=Netsis_SQL+" 			,A.[MIKTAR] 																																					 "
                    Netsis_SQL=Netsis_SQL+" 			,CAST(A.[MAMUL_KODU] as varchar(250)) as Mamul																													 "
                    Netsis_SQL=Netsis_SQL+" 		FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A WITH (NOLOCK) 																																 "
                    if instr(search_madde_kodu," ") then 
                        Netsis_SQL=Netsis_SQL+" 		WHERE A.[GEC_FLAG]=0  AND  [MAMUL_KODU] IN ("
                        a=Split(search_madde_kodu)
                        for each x in a
                            Netsis_SQL=Netsis_SQL+"'"+x +"',"
                        next
                        Netsis_SQL=Netsis_SQL+"'ğğğğ')" 	
                    else
                        Netsis_SQL=Netsis_SQL+" 		WHERE [MAMUL_KODU] LIKE  '"&search_madde_kodu&"'  AND A.[GEC_FLAG]=0 																											 "
                    end if
                    Netsis_SQL=Netsis_SQL+" 		UNION ALL																																							 "
                    Netsis_SQL=Netsis_SQL+" 		SELECT  																																							 "
                    Netsis_SQL=Netsis_SQL+" 			CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2																										 "
                    Netsis_SQL=Netsis_SQL+" 			,CAST(C.[SortOrder] as varchar(250)) as UstRecete2																												 "
                    Netsis_SQL=Netsis_SQL+" 			, CAST(C.[LeveL]+1 as INT) as Level2																															 "
                    Netsis_SQL=Netsis_SQL+" 			,B.[MAMUL_KODU]																																					 "
                    Netsis_SQL=Netsis_SQL+" 			,B.[HAM_KODU]																																					 "
                    Netsis_SQL=Netsis_SQL+" 			,B.[MIKTAR]																																						 "
                    Netsis_SQL=Netsis_SQL+" 			,CAST(C.[Mamul] as varchar(250)) as Mamul2 																														 "
                    Netsis_SQL=Netsis_SQL+" 		FROM ["+currentDB+"].[dbo].[TBLSTOKURM] B	 WITH (NOLOCK) 																															 "
                    Netsis_SQL=Netsis_SQL+" 		Join Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU]																													 "
                    Netsis_SQL=Netsis_SQL+"  	WHERE B.[GEC_FLAG]=0 	"
                    Netsis_SQL=Netsis_SQL+"   )																																											 "
                    Netsis_SQL=Netsis_SQL+"   Select DISTINCT 																																							 "
                    Netsis_SQL=Netsis_SQL+" 		Y.Mamul as 'Mamul'																																					 "
                    Netsis_SQL=Netsis_SQL+" 		,Y.SortOrder as 'Sort_order'																																		 "
                    Netsis_SQL=Netsis_SQL+" 		,Y.UstRecete as 'Ust_Recete'																																		 "
                    Netsis_SQL=Netsis_SQL+" 		,X.UstRecete as 'YariMamul'																																			 "
                    Netsis_SQL=Netsis_SQL+" 		,Y.Level as 'Seviye'																																				 "
                    Netsis_SQL=Netsis_SQL+"   		,Y.[MAMUL_KODU] as 'Recete'																																			 "
                    Netsis_SQL=Netsis_SQL+" 		,Y.[HAM_KODU] as 'Madde_kodu'																																		 "
                    Netsis_SQL=Netsis_SQL+" 		,G.[GRUP_ISIM] as 'Maliyet_grubu'																																	 "
                    Netsis_SQL=Netsis_SQL+" 		,E.[STOK_ADI] as 'Stok_Adi'																																			 "
                    Netsis_SQL=Netsis_SQL+" 		,Y.[MIKTAR] as 'Recete_Miktari'																																		 "
                    Netsis_SQL=Netsis_SQL+" 		,E.[OLCU_BR1] as 'Birim'																																			 "
                    Netsis_SQL=Netsis_SQL+" 		,Z.[FIYAT1]*CASE																																					 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.[OLCUBR]=1  THEN '1'																																		 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.[OLCUBR]=2  THEN E.[PAY_1]/E.[PAYDA_1]																													 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.[OLCUBR]=3  THEN E.[PAY2]/E.[PAYDA2]																														 "
                    Netsis_SQL=Netsis_SQL+" 			ELSE NULL																																						 "
                    Netsis_SQL=Netsis_SQL+" 		END AS 'Birim_Fiyat_BoM_birimli'																																	 "
                    Netsis_SQL=Netsis_SQL+" 		,CASE																																								 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.[OLCUBR]=1  THEN E.[OLCU_BR1]																															 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.[OLCUBR]=2  THEN E.[OLCU_BR2]																															 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.[OLCUBR]=3  THEN E.[OLCU_BR3]																															 "
                    Netsis_SQL=Netsis_SQL+" 			ELSE NULL																																						 "
                    Netsis_SQL=Netsis_SQL+" 		END AS 'Fiyat_Listesindeki_Birim'																																	 "
                    Netsis_SQL=Netsis_SQL+" 		,Z.[FIYAT1] as 'FL_Birim_fiyat'																																		 "
                    Netsis_SQL=Netsis_SQL+" 		,Z.[FIYATDOVIZTIPI] as 'Birim_Fiyat_Doviz_tipi'																														 "
                    Netsis_SQL=Netsis_SQL+" 		,CS.CARI_KOD AS 'Satici'																																			 "
                    Netsis_SQL=Netsis_SQL+" 		,CASE 																																								 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN LC.ORAN IS NULL THEN 1																																		 "
                    Netsis_SQL=Netsis_SQL+" 			ELSE LC.ORAN																																					 "
                    Netsis_SQL=Netsis_SQL+" 		END AS 'Maliyet_Kat_Sayisi'																																			 "
                    Netsis_SQL=Netsis_SQL+" 		,CAST(																																								 "
                    Netsis_SQL=Netsis_SQL+" 		CASE 																																								 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.FIYATDOVIZTIPI=0 then 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				Z.FIYAT1 / "&search_lira&" * Y.[MIKTAR] 																																 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE WHEN LC.ORAN IS NULL THEN 1 ELSE LC.ORAN END 																										 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE																																						 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=1  THEN 1																															 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=2  THEN E.[PAY_1]/E.[PAYDA_1]																										 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=3  THEN E.[PAY2]/E.[PAYDA2]																											 "
                    Netsis_SQL=Netsis_SQL+" 						ELSE 1																																				 "
                    Netsis_SQL=Netsis_SQL+" 				END																																							 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.FIYATDOVIZTIPI=1 then 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				Z.FIYAT1 * "&search_dolar&" * Y.[MIKTAR] 																																		 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE WHEN LC.ORAN IS NULL THEN 1 ELSE LC.ORAN END 																										 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE																																						 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=1  THEN 1																															 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=2  THEN E.[PAY_1]/E.[PAYDA_1]																										 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=3  THEN E.[PAY2]/E.[PAYDA2]																											 "
                    Netsis_SQL=Netsis_SQL+" 						ELSE 1																																				 "
                    Netsis_SQL=Netsis_SQL+" 				END																																							 "
                    Netsis_SQL=Netsis_SQL+" 																																											 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.FIYATDOVIZTIPI=2 then 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				Z.FIYAT1 * "&search_euro&"* Y.[MIKTAR] 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE WHEN LC.ORAN IS NULL THEN 1 ELSE LC.ORAN END 																										 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE																																						 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=1  THEN 1																															 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=2  THEN E.[PAY_1]/E.[PAYDA_1]																										 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=3  THEN E.[PAY2]/E.[PAYDA2]																											 "
                    Netsis_SQL=Netsis_SQL+" 						ELSE 1																																				 "
                    Netsis_SQL=Netsis_SQL+" 				END																																							 "
                    Netsis_SQL=Netsis_SQL+" 																																											 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.FIYATDOVIZTIPI=3 then 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				Z.FIYAT1 / "&search_yen&"* Y.[MIKTAR] 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE WHEN LC.ORAN IS NULL THEN 1 ELSE LC.ORAN END 																										 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE																																						 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=1  THEN 1																															 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=2  THEN E.[PAY_1]/E.[PAYDA_1]																										 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=3  THEN E.[PAY2]/E.[PAYDA2]																											 "
                    Netsis_SQL=Netsis_SQL+" 						ELSE 1																																				 "
                    Netsis_SQL=Netsis_SQL+" 				END																																							 "
                    Netsis_SQL=Netsis_SQL+" 																																											 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.FIYATDOVIZTIPI=7 then 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				Z.FIYAT1 / "&search_rmb&"* Y.[MIKTAR] 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE WHEN LC.ORAN IS NULL THEN 1 ELSE LC.ORAN END 																										 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE																																						 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=1  THEN 1																															 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=2  THEN E.[PAY_1]/E.[PAYDA_1]																										 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=3  THEN E.[PAY2]/E.[PAYDA2]																											 "
                    Netsis_SQL=Netsis_SQL+" 						ELSE 1																																				 "
                    Netsis_SQL=Netsis_SQL+" 				END																																							 "
                    Netsis_SQL=Netsis_SQL+" 																																											 "
                    Netsis_SQL=Netsis_SQL+" 			WHEN Z.FIYATDOVIZTIPI=9 then 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				Z.FIYAT1 / "&search_twd&" * Y.[MIKTAR] 																																	 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE WHEN LC.ORAN IS NULL THEN 1 ELSE LC.ORAN END 																										 "
                    Netsis_SQL=Netsis_SQL+" 				* CASE																																						 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=1  THEN 1																															 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=2  THEN E.[PAY_1]/E.[PAYDA_1]																										 "
                    Netsis_SQL=Netsis_SQL+" 						WHEN Z.[OLCUBR]=3  THEN E.[PAY2]/E.[PAYDA2]																											 "
                    Netsis_SQL=Netsis_SQL+" 						ELSE 1																																				 "
                    Netsis_SQL=Netsis_SQL+" 				END																																							 "
                    Netsis_SQL=Netsis_SQL+" 																																											 "
                    Netsis_SQL=Netsis_SQL+" 		END																																									 "
                    Netsis_SQL=Netsis_SQL+" 		as float) as 'adetli_katsayili_Dolar_fiyat'																															 "
                    Netsis_SQL=Netsis_SQL+" 	from Liste Y																																							 "
                    Netsis_SQL=Netsis_SQL+" 	OUTER APPLY (SELECT TOP 1 [FIYAT1],[FIYATDOVIZTIPI],[OLCUBR] FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] WITH (NOLOCK)  WHERE  Y.HAM_KODU=[STOKKODU] AND [FIYAT1]>0 ORDER BY [BASTAR] DESC) Z 				 "
                    Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E WITH (NOLOCK)  ON Y.[HAM_KODU]=E.[STOK_KODU]																								 "
                    Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] G WITH (NOLOCK)  ON E.[KOD_4]=G.[GRUP_KOD]																									 "
                    Netsis_SQL=Netsis_SQL+" 	OUTER APPLY (SELECT TOP 1 STOK_KODU,CARI_KOD FROM ["+currentDB+"].[dbo].[TBLCARISTOK] WITH (NOLOCK) WHERE Y.HAM_KODU=STOK_KODU AND CARI_KOD is not null ) CS	"
                    'Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLCARISTOK] CS WITH (NOLOCK)  ON Y.HAM_KODU=CS.STOK_KODU AND CS.CARI_KOD is not null																	 "
                    Netsis_SQL=Netsis_SQL+" 	OUTER APPLY (SELECT TOP 1 [ORAN],[CGI],[CARI_KOD] FROM ["+currentDB+"].[dbo].[PLT_LANDING_RATIO] WITH (NOLOCK) WHERE E.[KOD_4]=CGI AND  CS.CARI_KOD=CARI_KOD ) LC				 "
                    ' Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[PLT_LANDING_RATIO] LC WITH (NOLOCK)  ON E.[KOD_4]=LC.CGI AND  CS.CARI_KOD=LC.CARI_KOD		"
                    Netsis_SQL=Netsis_SQL+" 	LEFT JOIN Liste X WITH (NOLOCK)  ON Y.sortorder = X.UstRecete																															 "
                    Netsis_SQL=Netsis_SQL+" ORDER BY Y.MAMUL,Y.SortOrder                                                                                                                                                 "

                ' SQL ende
                
                'response.write(Netsis_SQL)
                'response.write("search_dolar,search_euro,search_lira,search_rmb,search_twd,search_yen<br>")
                'response.write(search_dolar&search_euro&search_lira&search_rmb&search_twd&search_yen)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=10000
                        if sira=0 then                         %>
                            <tr> <%
                            Response.Write("<th>Sıra</th>")
                            for each x in  NetsisRecordSet.Fields
                                Response.Write("<th>" & x.name & "</th>")
                            next                    %>
                            <th>Reçete Var?</th>
                            <th> Level 6 </th>
                            <th> Level 5 </th>
                            <th> Level 4 </th>
                            <th> Level 3 </th>
                            <th> Level 2 </th>
                            <th> Level 1 </th>
                            <th>Toplam</th>
                            

                            </tr>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr><td>"&sira&"</td>")
                        for each x in  NetsisRecordSet.Fields
                            'Response.Write(x.name) 
                            'Response.Write(" = ")
                            Response.Write("<td>") ' # karekteri exceli yarıda kesiyor
                            if len(x.value)>0 then Response.Write(Replace(Replace(x.value, "#",	"&bull;"),",",".")) ' # karekteri exceli yarıda kesiyor
                            Response.Write("</td>") ' # karekteri exceli yarıda kesiyor
                        next
                            Response.Write("<td>=LEN(E"&sira+1&")>0</td>") ' excel formuller
                            Response.Write("<td>=IF(T"&sira+1&",IF(F"&sira+1&">=6,SUMIF(D:D,E"&sira+1&",S:S)*K"&sira+1&",T"&sira+1&"),S"&sira+1&")</td>") 
                            Response.Write("<td>=IF(T"&sira+1&",IF(F"&sira+1&">=5,SUMIF(D:D,E"&sira+1&",U:U)*K"&sira+1&",T"&sira+1&"),S"&sira+1&")</td>") 
                            Response.Write("<td>=IF(T"&sira+1&",IF(F"&sira+1&">=4,SUMIF(D:D,E"&sira+1&",V:V)*K"&sira+1&",T"&sira+1&"),S"&sira+1&")</td>") 
                            Response.Write("<td>=IF(T"&sira+1&",IF(F"&sira+1&">=3,SUMIF(D:D,E"&sira+1&",W:W)*K"&sira+1&",T"&sira+1&"),S"&sira+1&")</td>") 
                            Response.Write("<td>=IF(T"&sira+1&",IF(F"&sira+1&">=2,SUMIF(D:D,E"&sira+1&",X:X)*K"&sira+1&",T"&sira+1&"),S"&sira+1&")</td>") 
                            Response.Write("<td>=IF(T"&sira+1&",IF(F"&sira+1&">=1,SUMIF(D:D,E"&sira+1&",Y:Y)*K"&sira+1&",T"&sira+1&"),S"&sira+1&")</td>") 
                            Response.Write("<td>=IF(F"&sira+1&"=1,Z"&sira+1&",0)</td>") 
                        NetsisRecordSet.MoveNext
                    loop
                    
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                %> 
            </table> 
            <%
            if sira=0 then response.write ("Kayıt bulunamadı...")     
            if sira=10000 then response.write ("Max. 10000 kayıt görüntülendi.</td></tr>")     
                
            end if
            %>
        </div>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->