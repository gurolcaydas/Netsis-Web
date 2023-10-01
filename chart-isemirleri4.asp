<html>
<%
UserLevel=session("UserLevel")
if instr(UserLevel,"p") then 'needed level'   %> 


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
        <link1 href="include/netsisweb-bootstrap.css" rel="stylesheet">
        <link1 href="include/bootstrap.min.css" rel="stylesheet">

        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>   
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>   
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>   

        <script src="include/netsis.js"></script>          




        <link    rel="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"    type="text/css"  />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script    src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"    type="text/javascript"  ></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>          
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
        <canvas id="myChart2"  width="95%" height="45%"></canvas>
      </div>    
    </div>
  
        <!-- #include file="./subs/dbcon.asp" -->
        <%
 
Netsis_SQL =  "  SELECT SUBSTRING(A.STOK_KODU,3,2) as 'yil'   "
Netsis_SQL = Netsis_SQL + "  FROM [ISEMRITEST1910].[dbo].[TBLISEMRI] A  "
Netsis_SQL = Netsis_SQL + "  LEFT JOIN [ISEMRITEST1910].[dbo].[TBLSTSABIT] B ON A.STOK_KODU=B.STOK_KODU    "
Netsis_SQL = Netsis_SQL + "  WHERE KAPALI='H' AND B.GRUP_KODU='FP1' AND LEFT(A.STOK_KODU,1)!='Y' "
Netsis_SQL = Netsis_SQL + "  GROUP BY  SUBSTRING(A.STOK_KODU,3,2)  "
Netsis_SQL = Netsis_SQL + "  ORDER BY SUBSTRING(A.STOK_KODU,3,2) "

                NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                dim sirali(100)
                sirali2=0

                        do until NetsisRecordSet.EOF 
                        bunlar=bunlar & "[" & NetsisRecordSet("yil") & "],"
                        sirali2=sirali2+1
                        sirali(sirali2)=NetsisRecordSet("yil")
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close                                    
                 bunlar=(left(bunlar,len(bunlar)-1))               
                ' SQL   
Netsis_SQL = " SELECT * FROM ( "
Netsis_SQL = Netsis_SQL + " SELECT  month(A.[TARIH]) mmmm ,year(A.[TARIH]) yyyy ,Cast( month(A.[TARIH])as varchar(10)) +'-'+ cast(year(A.[TARIH]) as varchar(10)) as yyil ,sum(A.[MIKTAR]) as toplam,SUBSTRING(A.STOK_KODU,3,2) as 'yil'   "
Netsis_SQL = Netsis_SQL + " FROM [ISEMRITEST1910].[dbo].[TBLISEMRI] A  "
Netsis_SQL = Netsis_SQL + " LEFT JOIN [ISEMRITEST1910].[dbo].[TBLSTSABIT] B ON A.STOK_KODU=B.STOK_KODU    "
Netsis_SQL = Netsis_SQL + " WHERE KAPALI='H' AND B.GRUP_KODU='FP1'   AND LEFT(A.STOK_KODU,1)!='Y' "
Netsis_SQL = Netsis_SQL + " GROUP BY  month(A.[TARIH]) ,year(A.[TARIH])  ,SUBSTRING(A.STOK_KODU,3,2)         "
Netsis_SQL = Netsis_SQL + " ) AS S "
Netsis_SQL = Netsis_SQL + " PIVOT (sum(Toplam) FOR yil IN (" & bunlar & ")) AS P "
Netsis_SQL = Netsis_SQL + " ORDER BY yyyy,mmmm "
                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                    sira=1
                    b=" "
                    c=" "
                    dim adata(100)
                    do until NetsisRecordSet.EOF 
                    a="25"
                        for i=1 to sirali2
                                  adata(sirali(i))=adata(sirali(i)) & " " & (NetsisRecordSet(sirali(i)))  & ","
                        next 
                                  b=b & " """ & NetsisRecordSet("yyil") & """," 
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close
                benimdata2b=(left(b,len(b)-1))
                 for i=1 to 100
                    if len(adata(i))>0 then benimdata2x = benimdata2X & "{ label: 'MY"&i&"',  data: [" & (left(adata(i),len(adata(i))-1)) & " ],backgroundColor: 'rgba("&int(rnd()*255)&","&int(rnd()*255)&","&int(rnd()*255)&",1)',  fill:true },"
                 next
                  '  Response.Write benimdata2x 
                %>
  </body>

  <script>



    var ctx = document.getElementById("myChart2").getContext("2d");
    var myChart2 = new Chart(ctx, {
      type: "line",
      data: {
        labels: [<%=benimdata2b%>],
        datasets: [

          <%=benimdata2x%>
          
        ],
      },
      options: {
        scales: {
  
          y: {
            stacked: true
          }
        },
      
      },  
    });    
  </script>

  <%
else
    Response.redirect ("default.asp")
end if %>
</html>
