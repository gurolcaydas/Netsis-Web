<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Malzeme Sipariş Değerlendirme" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"u") then 'needed level' 
    search_stok_kodu = (request.form("search_madde_kodu"))  
    search_madde_ad = (request.form("search_madde_ad"))  
    search_stok_kodu=Replace(search_stok_kodu,vbCrLf, " ")       
    search_stok_kodu=Replace(search_stok_kodu,Chr(9), " ")        
    search_stok_kodu=Replace(search_stok_kodu,Chr(10), " ")        
    search_stok_kodu=Replace(search_stok_kodu,Chr(11), " ")        
    search_stok_kodu=Replace(search_stok_kodu,Chr(12), " ")        
    search_stok_kodu=Replace(search_stok_kodu,Chr(13), " ")        
    search_stok_kodu=Replace(search_stok_kodu,Chr(44), " ")        
    search_stok_kodu=Replace(search_stok_kodu, """", " ")
    search_stok_kodu=Replace(search_stok_kodu, "'", " ")
    search_stok_kodu=Replace(search_stok_kodu, "‚", " ")
    i=0
    Do While i<>LEN(search_stok_kodu) ' çift space kontrol
            i=LEN(search_stok_kodu)
            search_stok_kodu=Replace(search_stok_kodu, "  ", " ")
    Loop
    search_madde_kodu=trim(search_stok_kodu) %>         
        <div class="container-fluid" style="margin-top:80px"> 
            <!-- #include file="./subs/dbcon.asp" -->
            <div class="container-fluid p-4"> <h3></h3>                
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Malzeme Sipariş Değerlendirme </h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_madde_kodu"  placeholder="Stok Kodu"  value="<%=search_madde_kodu%>">
                            <input class="form-control" type="text" name="search_madde_ad"  placeholder="Stok Adı"  value="<%=search_madde_ad%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> <%  
                if url_doo="list" and len(search_stok_kodu)>0 then   %>
                    <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                    <table class="table table-sm table-striped table-hover align-middle" id="tblData">         <%
                        ' SQL   


Netsis_SQL =   "  with liste as (  "
Netsis_SQL = Netsis_SQL + "      SELECT   "  ' distinct silindi
Netsis_SQL = Netsis_SQL + "              'Ihtiyac' as 'stst'  "
Netsis_SQL = Netsis_SQL + "              ,C.[HAM_KODU] as 'SKU'  "
Netsis_SQL = Netsis_SQL + "              ,A2.INGISIM as 'Description'	  "
Netsis_SQL = Netsis_SQL + "              ,EN.ING as 'Item Group'  "
Netsis_SQL = Netsis_SQL + "              ,K2.GRUP_ISIM as 'Brand'  "
Netsis_SQL = Netsis_SQL + "              , -C.[MIKTAR]*(D.MIKTAR- CASE WHEN URETIM.URETILEN IS NULL THEN 0 ELSE URETIM.URETILEN END ) as 'QTY'  "
Netsis_SQL = Netsis_SQL + "          FROM ["+currentDB+"].[dbo].[TBLISEMRIREC] C  "
Netsis_SQL = Netsis_SQL + "              LEFT JOIN   ["+currentDB+"].[dbo].[TBLISEMRI] D ON D.ISEMRINO=C.ISEMRINO   "
Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E ON C.[HAM_KODU]=E.[STOK_KODU]  "
Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON C.[HAM_KODU]=A2.[STOK_KODU]   "
Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] K2 ON K2.GRUP_KOD=E.KOD_2  "
Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=E.KOD_1  "
Netsis_SQL = Netsis_SQL + "              OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  C.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=C.MAMUL_KODU) AS URETIM   "
Netsis_SQL = Netsis_SQL + "          WHERE C.ISEMRINO IN ( SELECT A.[ISEMRINO] FROM ["+currentDB+"].[dbo].[TBLISEMRI] A )  "
Netsis_SQL = Netsis_SQL + "              AND GEC_FLAG =0 AND D.KAPALI = 'H'  "
Netsis_SQL = Netsis_SQL + "              AND C.[MIKTAR]*(D.MIKTAR- CASE WHEN URETIM.URETILEN IS NULL THEN 0 ELSE URETIM.URETILEN END )>0  "
                         
                            ' madde koduna göre ara
                                y=0
                                if len(search_madde_kodu)>0 then 
                                    if instr(search_madde_kodu," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a2=Split(search_madde_kodu)
                                        for each x in a2
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" C.[HAM_KODU] LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND C.[HAM_KODU] LIKE '"&search_madde_kodu&"' "
                                    end if
                                end if 
                            ' end madde koduna göre  
                            ' madde adına göre ara
                                y=0
                                if len(search_madde_ad)>0 then                                 
                                    if instr(search_madde_ad," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a3=Split(search_madde_ad)
                                        for each x in a3
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A2.INGISIM LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A2.INGISIM LIKE '"&search_madde_ad&"' "
                                    end if
                                end if 
                            ' end madde adına göre

Netsis_SQL = Netsis_SQL + "      union all   "
Netsis_SQL = Netsis_SQL + "      SELECT   "
'Netsis_SQL = Netsis_SQL + "          'siparis' as 'stst'  "
Netsis_SQL = Netsis_SQL + "          case WHEN A.STHAR_FTIRSIP =6 then 'MusteriSip' ELSE 'TedarikSip' end  as 'stst' "
Netsis_SQL = Netsis_SQL + "          ,A.[STOK_KODU] as 'SKU'  "
Netsis_SQL = Netsis_SQL + "          ,A2.INGISIM as 'Description'  "
Netsis_SQL = Netsis_SQL + "          ,EN.ING as 'Item Group'  "
Netsis_SQL = Netsis_SQL + "          ,B2.GRUP_ISIM as Kod2   "
'Netsis_SQL = Netsis_SQL + "          ,isnull([STHAR_GCMIK],0) - isnull([FIRMA_DOVTUT] ,0) as 'QTY'  "
Netsis_SQL = Netsis_SQL + "          ,(case WHEN A.STHAR_FTIRSIP =6 then -1 ELSE +1 end) * (isnull(A.[STHAR_GCMIK],0) - isnull(A.[FIRMA_DOVTUT] ,0)) as 'QTY' "
Netsis_SQL = Netsis_SQL + "      FROM ["+currentDB+"].[dbo].[TBLSIPATRA] A  "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTSABIT] A3 ON A3.STOK_KODU=A.STOK_KODU  "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON A.STOK_KODU=A2.[STOK_KODU]   "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=A3.KOD_1  "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2 ON A3.[KOD_2]=B2.[GRUP_KOD]   "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLISEMRI] B WITH (NOLOCK) ON FISNO=SIPARIS_NO AND B.STOK_KODU=A.[STOK_KODU]   "
Netsis_SQL = Netsis_SQL + "      WHERE  A.DEPO_KODU!='62' AND A.SUBE_KODU='1' AND (B.KAPALI='H' OR B.KAPALI IS NULL) AND (isnull(A.[STHAR_GCMIK],0) - isnull(A.[FIRMA_DOVTUT] ,0) )>0   "


                            ' madde koduna göre ara
                                y=0
                                if len(search_madde_kodu)>0 then 
                                    if instr(search_madde_kodu," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a2=Split(search_madde_kodu)
                                        for each x in a2
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A.[STOK_KODU] LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A.[STOK_KODU] LIKE '"&search_madde_kodu&"' "
                                    end if
                                end if 
                            ' end madde koduna göre  
                            ' madde adına göre ara
                                y=0
                                if len(search_madde_ad)>0 then                                 
                                    if instr(search_madde_ad," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a3=Split(search_madde_ad)
                                        for each x in a3
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A2.INGISIM LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A2.INGISIM LIKE '"&search_madde_ad&"' "
                                    end if
                                end if 
                            ' end madde adına göre

Netsis_SQL = Netsis_SQL + "      union all   "
Netsis_SQL = Netsis_SQL + "      SELECT  "
Netsis_SQL = Netsis_SQL + "          'ToplamStok' as 'stst'  "
Netsis_SQL = Netsis_SQL + "          ,A.STOK_KODU as bizimstok "
Netsis_SQL = Netsis_SQL + "          ,A2.INGISIM as 'Description'  "
Netsis_SQL = Netsis_SQL + "          ,EN.ING as 'Item Group'  "
Netsis_SQL = Netsis_SQL + "          ,B2.GRUP_ISIM as Kod2   "
Netsis_SQL = Netsis_SQL + "          ,CASE WHEN [TOP_GIRIS_MIK] IS NULL THEN 0 ELSE [TOP_GIRIS_MIK] END - CASE WHEN [TOP_CIKIS_MIK] IS NULL THEN 0 ELSE [TOP_CIKIS_MIK] END AS 'Stok_Miktar'  "
Netsis_SQL = Netsis_SQL + "      FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON A.STOK_KODU=A2.[STOK_KODU]   "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] B1 ON [KOD_1]=B1.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=A.KOD_1  "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2 ON [KOD_2]=B2.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD3] B3 ON [KOD_3]=B3.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] B4 ON [KOD_4]=B4.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD5] B5 ON [KOD_5]=B5.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKPH] ST ON ST.[STOK_KODU]=A.STOK_KODU AND ( ST.[SUBE_KODU]=1 OR  ST.[SUBE_KODU]=2) and  ST.[DEPO_KODU]=0   "

Netsis_SQL = Netsis_SQL + "  		WHERE 1=1 "

                            ' madde koduna göre ara
                                y=0
                                if len(search_madde_kodu)>0 then 
                                    if instr(search_madde_kodu," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a2=Split(search_madde_kodu)
                                        for each x in a2
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A.[STOK_KODU] LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A.[STOK_KODU] LIKE '"&search_madde_kodu&"' "
                                    end if
                                end if 
                            ' end madde koduna göre  
                            ' madde adına göre ara
                                y=0
                                if len(search_madde_ad)>0 then                                 
                                    if instr(search_madde_ad," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a3=Split(search_madde_ad)
                                        for each x in a3
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A2.INGISIM LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A2.INGISIM LIKE '"&search_madde_ad&"' "
                                    end if
                                end if 
                            ' end madde adına göre

Netsis_SQL = Netsis_SQL + "      union all   "
Netsis_SQL = Netsis_SQL + "      SELECT  "
Netsis_SQL = Netsis_SQL + "           CASE  when ST.[DEPO_KODU]=12 then 'Hurda' else 'Karantina' end as 'stst'  "
Netsis_SQL = Netsis_SQL + "          ,A.STOK_KODU as bizimstok "
Netsis_SQL = Netsis_SQL + "          ,A2.INGISIM as 'Description'  "
Netsis_SQL = Netsis_SQL + "          ,EN.ING as 'Item Group'  "
Netsis_SQL = Netsis_SQL + "          ,B2.GRUP_ISIM as Kod2   "
Netsis_SQL = Netsis_SQL + "          ,CASE WHEN [TOP_GIRIS_MIK] IS NULL THEN 0 ELSE [TOP_GIRIS_MIK] END - CASE WHEN [TOP_CIKIS_MIK] IS NULL THEN 0 ELSE [TOP_CIKIS_MIK] END AS 'Stok_Miktar'  "
Netsis_SQL = Netsis_SQL + "      FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON A.STOK_KODU=A2.[STOK_KODU]   "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] B1 ON [KOD_1]=B1.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=A.KOD_1  "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2 ON [KOD_2]=B2.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD3] B3 ON [KOD_3]=B3.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] B4 ON [KOD_4]=B4.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD5] B5 ON [KOD_5]=B5.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKPH] ST ON ST.[STOK_KODU]=A.STOK_KODU AND ( ST.[SUBE_KODU]=1 OR  ST.[SUBE_KODU]=2) and  (ST.[DEPO_KODU]=12 OR ST.DEPO_KODU=66 OR ST.DEPO_KODU=6)   "

Netsis_SQL = Netsis_SQL + "  		WHERE 1=1 "

                            ' madde koduna göre ara
                                y=0
                                if len(search_madde_kodu)>0 then 
                                    if instr(search_madde_kodu," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a2=Split(search_madde_kodu)
                                        for each x in a2
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A.[STOK_KODU] LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A.[STOK_KODU] LIKE '"&search_madde_kodu&"' "
                                    end if
                                end if 
                            ' end madde koduna göre  
                            ' madde adına göre ara
                                y=0
                                if len(search_madde_ad)>0 then                                 
                                    if instr(search_madde_ad," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a3=Split(search_madde_ad)
                                        for each x in a3
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A2.INGISIM LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A2.INGISIM LIKE '"&search_madde_ad&"' "
                                    end if
                                end if 
                            ' end madde adına göre

Netsis_SQL = Netsis_SQL + "      union all   "


Netsis_SQL = Netsis_SQL + "	SELECT  "
Netsis_SQL = Netsis_SQL + "			'UretimEmri' as 'stst' "
Netsis_SQL = Netsis_SQL + "			,R.STOK_KODU as SKU "
Netsis_SQL = Netsis_SQL + "			,A2.INGISIM as Descr "
Netsis_SQL = Netsis_SQL + "			,EN.ING as ItemGroup "
Netsis_SQL = Netsis_SQL + "			,B2.GRUP_ISIM as Kod2   "
Netsis_SQL = Netsis_SQL + "			,isnull(R.MIKTAR,0)- isnull(URETIM.URETILEN,0) as Uretilecek "
Netsis_SQL = Netsis_SQL + "	FROM ["+currentDB+"].[dbo].[TBLISEMRI] R "
Netsis_SQL = Netsis_SQL + "	LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTSABIT] A3 ON A3.STOK_KODU=R.STOK_KODU "
Netsis_SQL = Netsis_SQL + "	LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON R.STOK_KODU=A2.[STOK_KODU]  "
Netsis_SQL = Netsis_SQL + "	LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=A3.KOD_1 "
Netsis_SQL = Netsis_SQL + "          LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2 ON A3.[KOD_2]=B2.[GRUP_KOD]     "
Netsis_SQL = Netsis_SQL + "	OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  R.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=R.STOK_KODU) AS URETIM "
Netsis_SQL = Netsis_SQL + "	WHERE (R.KAPALI='H' OR R.KAPALI IS NULL)  "
Netsis_SQL = Netsis_SQL + " "

                            ' madde koduna göre ara
                                y=0
                                if len(search_madde_kodu)>0 then 
                                    if instr(search_madde_kodu," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a2=Split(search_madde_kodu)
                                        for each x in a2
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" R.[STOK_KODU] LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND R.[STOK_KODU] LIKE '"&search_madde_kodu&"' "
                                    end if
                                end if 
                            ' end madde koduna göre  
                            ' madde adına göre ara
                                y=0
                                if len(search_madde_ad)>0 then                                 
                                    if instr(search_madde_ad," ") then 
                                        Netsis_SQL=Netsis_SQL+" AND ("
                                        a3=Split(search_madde_ad)
                                        for each x in a3
                                            if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                            Netsis_SQL=Netsis_SQL+" A2.INGISIM LIKE '"+x+"'"
                                            y=1
                                        next
                                        Netsis_SQL=Netsis_SQL+") "
                                    else
                                    Netsis_SQL=Netsis_SQL+" AND A2.INGISIM LIKE '"&search_madde_ad&"' "
                                    end if
                                end if 
                            ' end madde adına göre                            

Netsis_SQL = Netsis_SQL + "      )  "
Netsis_SQL = Netsis_SQL + "      Select  * from Liste    L"
Netsis_SQL = Netsis_SQL + "  	PIVOT (sum(QTY) FOR stst IN (ToplamStok,Karantina,Hurda,MusteriSip,TedarikSip,Ihtiyac,UretimEmri)) AS P                        "
                           

                            Netsis_SQL = Netsis_SQL + " Order by  SKU                               "
                            'Response.Write (netsis_sql)
                            'response.end

                        ' SQL ende
                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                            sira=0 
                            do until NetsisRecordSet.EOF 'OR sira>=5000
                                if sira=0 then                         %>
                                    <thead><tr> <%
                                    Response.Write("<th>Sıra</th>")
                                                                    if instr(UserLevel,"r")  THEN  %><th> </th>
                                                    <%  end if   
                                    for each x in  NetsisRecordSet.Fields
                                        Response.Write("<th>" & x.name & "</th>")
                                    next                    %>
                                    <th>Bakiye</th></tr></thead>  <%
                                end if 
                                sira=sira+1      
                                Response.Write(" <tr><td>"&sira&"</td>")
                                if instr(UserLevel,"r")  THEN  %>
                                                    <td><a  href="chart-SKU-ihtiyac.asp?SKU=<%=NetsisRecordSet("SKU")%>" title="İhtiyaç Grafiği <%=NetsisRecordSet("SKU")%>" target="_blank" >
                                                            <div class="badge badge-pill bg-danger">
                                                                <i class="bi bi-graph-down-arrow"></i> 
                                                            </div></a> </td>    
                                                    <%  end if   
                                for each x in  NetsisRecordSet.Fields
                                    'Response.Write(x.name)
                                    'Response.Write(" = ")
                                    if isnull(x.value) then eksilt=x.value else eksilt=replace(x.value,"#","[]")
                                    if x.name ="SKU" then eksilt=eksilt+"<a  href='NetsisBom.asp?doo=kullanimyeri&item="&NetsisRecordSet("SKU")&"' title='Stok kartı detayları / Kullanıldığı yerler' > <div class='badge badge-pill bg-warning'> <i class='bi bi-search'></i></div></a>"
                                    Response.Write("<td>" & eksilt & "</td>")
                                next
                                if isnull(NetsisRecordSet("ToplamStok")) then a1=0 else a1=cdbl(NetsisRecordSet("ToplamStok"))
                                if isnull(NetsisRecordSet("MusteriSip")) then  a2=0 else a2=cdbl(NetsisRecordSet("MusteriSip"))
                                if isnull(NetsisRecordSet("TedarikSip")) then  a4=0 else a4=cdbl(NetsisRecordSet("TedarikSip"))
                                if isnull(NetsisRecordSet("Ihtiyac")) then a3=0 else a3=cdbl(NetsisRecordSet("Ihtiyac"))
                                if isnull(NetsisRecordSet("UretimEmri")) then a5=0 else a5=cdbl(NetsisRecordSet("UretimEmri"))
                                aaa=a1+a2+a3+a4+a5
                                if aaa<0 then bbb="<div class='badge badge-pill bg-danger'>"&aaa&"</div>" 
                                if aaa=0 then bbb="<div class='badge badge-pill bg-secondary'>"&aaa&"</div>"
                                if aaa>0 then bbb="<div class='badge badge-pill bg-primary'>"&aaa&"</div>"
                               Response.Write(" <td>"&bbb&"</td></tr> ")
                                NetsisRecordSet.MoveNext
                            loop
                        NetsisRecordSet.close
                        Response.Write(" </table> ")

                        if sira=0 then response.write ("Kayıt bulunamadı...")     
                        if sira=5000 then response.write ("<tr><td colspan=5>Max. 5000 kayıt görüntülendi.</td></tr>")     %> 
                    </table>  <%
                end if  %>
            </div>
        </div> <% 
else
    Response.Write ("User level?")
end if
%> 
<script>
let table = new DataTable('#tblData', {
        "lengthMenu": [[10, 100 , -1], [ 10, 100, "All"]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->