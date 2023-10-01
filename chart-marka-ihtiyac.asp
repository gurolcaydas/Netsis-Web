<html>
<%
UserLevel=session("UserLevel")
if instr(UserLevel,"r") then 'needed level'   %> 


     <head>

        <meta charset="utf-8">
        <meta http-equiv="Content-Language" content="tr">
        <META NAME="Generator" CONTENT="By hand">
        <META NAME="Author" CONTENT="Gurol">
        <meta name="copyright" content="Copyright ©2022 by Gurol, All Rights Reserved.">
        <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
        <title>NetsisWeb - <%=BaslikHTML%></title>
        <meta http-equiv='Content-Type' content='text/html; charset=utf-8' /> 
        <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
        <link rel="icon" type="image/ico" href="img/favicon-.ico"/>
        <link href='https://fonts.googleapis.com/css?family=Farro' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Libre+Barcode+128=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet"> 
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet"> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>   
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>   
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>  
        <script src="include/netsis.js"></script>         
        <link    rel="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"    type="text/css"  />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script    src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"    type="text/javascript"  ></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.2/Chart.min.js"></script>          
     </head>
  <style>
    .container {
      width: 100%;
      margin: 15px auto;
    }
    body {
      text-align: center;
      color: green;
    }
    h2 {
      text-align: center;
      font-family: "Verdana", sans-serif;
      font-size: 30px;
    }
  </style>
<body style="font-size: 14px; "  >                
    <div class="panel panel-default">
      <div>
        <canvas id="myChart" width="100%" height="40%"></canvas>
    </div>
 
    </div>
            <div class="container-fluid p-4"> 
            <table class="table table-sm table-striped table-hover align-middle">   
  
        <!-- #include file="./subs/dbcon.asp" -->
        <%
                        currentDB=Session("currentDB")
        'currentDB="db2022"
        aranan=request.querystring("SKU")
                ' SQL   
                    Netsis_SQL = "with liste as ( "
                    Netsis_SQL = Netsis_SQL + "	SELECT  DISTINCT  "
                    Netsis_SQL = Netsis_SQL + "		'Work Order' as 'Status' "
                    Netsis_SQL = Netsis_SQL + "		,C.[ISEMRINO] as 'Info'  "
                    Netsis_SQL = Netsis_SQL + "		,C.[HAM_KODU] as 'SKU' "
                    Netsis_SQL = Netsis_SQL + "		,A2.INGISIM as 'Descr'	 "
                    Netsis_SQL = Netsis_SQL + "		,EN.ING as 'ItemGroup' "
                    Netsis_SQL = Netsis_SQL + "		,K2.GRUP_ISIM as 'Sources' "
                    Netsis_SQL = Netsis_SQL + "		,D.TARIH as 'Whenn' "
                    Netsis_SQL = Netsis_SQL + "		,-C.[MIKTAR]*(D.MIKTAR-isnull(( SELECT SUM( U2.URETSON_MIKTAR) as toplam  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U2 WITH (NOLOCK) WHERE  C.ISEMRINO =U2.URETSON_SIPNO AND U2.URETSON_MAMUL=C.MAMUL_KODU ),0)) as QTY "
                    Netsis_SQL = Netsis_SQL + "		FROM ["+currentDB+"].[dbo].[TBLISEMRIREC] C "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN ["+currentDB+"].[dbo].[TBLISEMRI] D ON D.ISEMRINO=C.ISEMRINO  "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E ON C.[HAM_KODU]=E.[STOK_KODU] "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON C.[HAM_KODU]=A2.[STOK_KODU]  "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] K2 ON K2.GRUP_KOD=E.KOD_2 "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=E.KOD_1 "
                    Netsis_SQL = Netsis_SQL + "		WHERE C.ISEMRINO IN ( SELECT A.[ISEMRINO] FROM ["+currentDB+"].[dbo].[TBLISEMRI] A ) AND GEC_FLAG =0 AND D.KAPALI = 'H'  "
                    Netsis_SQL = Netsis_SQL + "union all  "
                    Netsis_SQL = Netsis_SQL + "	SELECT  "
                    Netsis_SQL = Netsis_SQL + "		'Supply Order' as 'Status' "
                    Netsis_SQL = Netsis_SQL + "		,[FISNO] as 'nerde' "
                    Netsis_SQL = Netsis_SQL + "		,A.[STOK_KODU] as 'SKU' "
                    Netsis_SQL = Netsis_SQL + "		,A2.INGISIM as 'Desc.' "
                    Netsis_SQL = Netsis_SQL + "		,EN.ING as 'Item Group' "
                    Netsis_SQL = Netsis_SQL + "		,B2.GRUP_ISIM as Kod2  "
                    Netsis_SQL = Netsis_SQL + "		,[STHAR_TESTAR] as 'whenn' "
                    'Netsis_SQL = Netsis_SQL + "		,isnull([STHAR_GCMIK],0) - isnull([FIRMA_DOVTUT] ,0) as 'QTY' "
                    Netsis_SQL = Netsis_SQL + "   ,(case WHEN A.STHAR_FTIRSIP =6 then -1 ELSE +1 end) * (isnull([STHAR_GCMIK],0) - isnull([FIRMA_DOVTUT] ,0)) as 'QTY' "
                    Netsis_SQL = Netsis_SQL + "	FROM ["+currentDB+"].[dbo].[TBLSIPATRA] A "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTSABIT] A3 ON A3.STOK_KODU=A.STOK_KODU "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON A.STOK_KODU=A2.[STOK_KODU]  "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=A3.KOD_1 "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2 ON A3.[KOD_2]=B2.[GRUP_KOD]  "
                    Netsis_SQL = Netsis_SQL + "   LEFT JOIN ["+currentDB+"].[dbo].[TBLISEMRI] B WITH (NOLOCK) ON FISNO=SIPARIS_NO AND B.STOK_KODU=A.[STOK_KODU]  "
                    'Netsis_SQL = Netsis_SQL + "	WHERE A.SUBE_KODU='1' AND (isnull(A.[STHAR_GCMIK],0) - isnull(A.[FIRMA_DOVTUT] ,0) )>0  AND B.KAPALI!='E'"
                    Netsis_SQL = Netsis_SQL + " WHERE A.SUBE_KODU='1'  AND (B.KAPALI='H' OR B.KAPALI IS NULL) AND (case WHEN A.STHAR_FTIRSIP =6 then -1 ELSE +1 end) * (isnull([STHAR_GCMIK],0) - isnull([FIRMA_DOVTUT] ,0))!=0 "

                    Netsis_SQL = Netsis_SQL + "union all "
                    Netsis_SQL = Netsis_SQL + "	SELECT "
                    Netsis_SQL = Netsis_SQL + "		'On Hand' as 'Status' "
                    Netsis_SQL = Netsis_SQL + "		,CASE WHEN ST.[SUBE_KODU]=2 THEN 'PnA WareHouse' ELSE 'Component WareHouse' END  as 'Nerede' "
                    Netsis_SQL = Netsis_SQL + "		,A.STOK_KODU "
                    Netsis_SQL = Netsis_SQL + "		,A2.INGISIM as 'Desc.' "
                    Netsis_SQL = Netsis_SQL + "		,EN.ING as 'Item Group' "
                    Netsis_SQL = Netsis_SQL + "		,B2.GRUP_ISIM as Kod2  "
                    Netsis_SQL = Netsis_SQL + "		,'' as 'Durum' "
                    Netsis_SQL = Netsis_SQL + "		,isnull([TOP_GIRIS_MIK],0) - isnull([TOP_CIKIS_MIK],0) AS 'Stok_Miktar' "
                    Netsis_SQL = Netsis_SQL + "	FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A    "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON A.STOK_KODU=A2.[STOK_KODU]  "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] B1 ON [KOD_1]=B1.[GRUP_KOD]    "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=A.KOD_1 "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2 ON [KOD_2]=B2.[GRUP_KOD]    "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD3] B3 ON [KOD_3]=B3.[GRUP_KOD]    "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] B4 ON [KOD_4]=B4.[GRUP_KOD]    "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD5] B5 ON [KOD_5]=B5.[GRUP_KOD]    "
                    Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKPH] ST ON ST.[STOK_KODU]=A.STOK_KODU AND ( ST.[SUBE_KODU]=1 OR  ST.[SUBE_KODU]=2) and  ST.[DEPO_KODU]=0  "
                    
                    Netsis_SQL = Netsis_SQL + "union all  "
                    Netsis_SQL = Netsis_SQL + "			SELECT  "
                    Netsis_SQL = Netsis_SQL + "					'Production' as 'Status' "
                    Netsis_SQL = Netsis_SQL + "					,ISEMRINO as Info "
                    Netsis_SQL = Netsis_SQL + "					,R.STOK_KODU as SKU "
                    Netsis_SQL = Netsis_SQL + "					,A2.INGISIM as Descr "
                    Netsis_SQL = Netsis_SQL + "					,EN.ING as ItemGroup "
                    Netsis_SQL = Netsis_SQL + "					,R.SIPARIS_NO as Sources "
                    Netsis_SQL = Netsis_SQL + "					,R.TEPETARIH as Whenn "
                    Netsis_SQL = Netsis_SQL + "					,isnull(R.MIKTAR,0)- isnull(URETIM.URETILEN,0) as Uretilecek "
                    Netsis_SQL = Netsis_SQL + "			FROM ["+currentDB+"].[dbo].[TBLISEMRI] R "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTSABIT] A3 ON A3.STOK_KODU=R.STOK_KODU "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2 ON R.STOK_KODU=A2.[STOK_KODU]  "
                    Netsis_SQL = Netsis_SQL + "			LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] EN ON EN.GRUP_KOD=A3.KOD_1 "
                    Netsis_SQL = Netsis_SQL + "			OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  R.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=R.STOK_KODU) AS URETIM "
                    Netsis_SQL = Netsis_SQL + "		WHERE (R.KAPALI='H' OR R.KAPALI IS NULL) "
                    Netsis_SQL = Netsis_SQL + ") "
                    Netsis_SQL = Netsis_SQL + "Select SKU,Descr,ItemGroup,Whenn,sum(isnull(QTY,0)) as Cumulative, Status,Sources from Liste   "
                    Netsis_SQL = Netsis_SQL + "WHERE Sources LIKE '%"&aranan&"%' "
                    Netsis_SQL = Netsis_SQL + "GROUP BY SKU,Descr,ItemGroup,Whenn, Status ,Sources "
                    Netsis_SQL = Netsis_SQL + "Order by whenn, SKU "

                NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                    kumulatif=0 
                    a=""
                    b=""
                    c=""
                    d=""
                    toplamlar=0
                    do until NetsisRecordSet.EOF           
                            if isnull(NetsisRecordSet("Cumulative")) then  
                            else 
                              a=a & " " & NetsisRecordSet("Cumulative") & ","
                              b=b & " """ & NetsisRecordSet("Whenn") & """," 
                              kumulatif=kumulatif+cdbl(NetsisRecordSet("Cumulative"))
                              d=d & " " & kumulatif & ","     
                              if sira=0 then         %>
                                  <thead><tr> <%
                                  Response.Write("<th>Sıra</th>")
                                  for each x in  NetsisRecordSet.Fields
                                      Response.Write("<th>" & x.name & "</th>")
                                  next    %>
                                  <th>Toplam</th></tr></thead>  <%
                              end if 
                              sira=sira+1      
                              Response.Write(" <tr><td>"&sira&"</td>")
                              for each x in  NetsisRecordSet.Fields
                                  'Response.Write(x.name)
                                  'Response.Write(" = ")
                                  Response.Write("<td class='text-nowrap'>" & x.value &"</td>")
                                  
                              next                                       
                              toplamlar=toplamlar+cdbl(NetsisRecordSet("Cumulative"))     
                              Response.Write("<td class='text-nowrap'>" & toplamlar &"</td>")
                              Response.Write(" </tr> ")                           
                            end if  
                        NetsisRecordSet.MoveNext
                    loop

                NetsisRecordSet.close
                Response.Write(" </table> ")
                'response.end
                benimdata1a=(left(a,len(a)-1))
                benimdata1b=(left(b,len(b)-1))
                benimdata1d=(left(d,len(d)-1)) %>
  </body>

  <script>

    var ctx = document.getElementById("myChart").getContext("2d");
    var myChart = new Chart(ctx, {
      type: "bar",
      data: {
        labels: [<%=benimdata1b%>],
        datasets: [
          {
            label: "Usage/Order <%=currentDB%>",
            data: [<%=benimdata1a%>],
            backgroundColor: "rgba(153,205,1,0.6)",
         
          },         
          {
            label: "Stock Level",
            data: [<%=benimdata1d%>],
            backgroundColor: "rgba(205,1,153,0.2)",   
            type: 'line',
          },              
        ],
      },       
    });


  </script>

  <%
else
    Response.redirect ("default.asp")
end if %>
</html>
