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
        <canvas id="myChart" width="95%" height="15%"></canvas>
    </div>
    <div>
        <canvas id="myChart2"  width="95%" height="33%"></canvas>
      </div>    
    </div>
  
        <!-- #include file="./subs/dbcon.asp" -->
        <%
                        currentDB=Session("currentDB")
        'currentDB="db2022"
                ' SQL   
                    Netsis_SQL= " SELECT  "
                    Netsis_SQL=Netsis_SQL+" 	 MONTH( U.URETSON_TARIH) as Ayy "
                    Netsis_SQL=Netsis_SQL+" 	, SUM(U.URETSON_MIKTAR) as Toplam "
                    Netsis_SQL=Netsis_SQL+" FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].dbo.TBLSTSABIT S WITH (NOLOCK) ON S.Stok_kodu=U.URETSON_MAMUL "
                    Netsis_SQL=Netsis_SQL+" WHERE S.GRUP_KODU='FP1' "
                    Netsis_SQL=Netsis_SQL+" GROUP BY	 MONTH( U.URETSON_TARIH)   ORDER BY  MONTH( U.URETSON_TARIH)"
                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                    sira=0 
                    gercektoplam=0
                    kumulatif=0
                    a=""
                    b=""
                    c=""
                    d=""
                    do until NetsisRecordSet.EOF 
                            if isnull(NetsisRecordSet("Toplam")) then 
                            else
                            a=a & " " & NetsisRecordSet("Toplam") & ","
                            b=b & " """ & NetsisRecordSet("Ayy") & ""","
                            sira=sira+1
                            gercektoplam=gercektoplam+cint(NetsisRecordSet("Toplam"))
                            kumulatif=kumulatif+cint(NetsisRecordSet("Toplam"))
                            ort=int(gercektoplam/sira)
                            c=c & " " & ort & ","      
                            d=d & " " & kumulatif & ","      
                                                   
                             end if 
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close
                benimdata1a=(left(a,len(a)-1))
                benimdata1b=(left(b,len(b)-1))
                benimdata1c=(left(c,len(c)-1))
                benimdata1d=(left(d,len(d)-1))

                ' SQL   
                    Netsis_SQL= "  SELECT  "
                    Netsis_SQL=Netsis_SQL+" 	 U.URETSON_TARIH as 'Tarih' "
                    Netsis_SQL=Netsis_SQL+" 	, SUM(U.URETSON_MIKTAR) as Toplam "
                    Netsis_SQL=Netsis_SQL+" FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].dbo.TBLSTSABIT S WITH (NOLOCK) ON S.Stok_kodu=U.URETSON_MAMUL "
                    Netsis_SQL=Netsis_SQL+" WHERE S.GRUP_KODU='FP1' "
                    Netsis_SQL=Netsis_SQL+" GROUP BY	 U.URETSON_TARIH   ORDER BY U.URETSON_TARIH "
                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                    sira=0 
                    sira2=0
                    sira3=0
                    Dim array1(22)
                    gercektoplam=0
                    a=" "
                    b=" "
                    c=" "
                    d=" "
                    e=" "
                    for i=1 to 22
                    array1(i)=0
                    next 
                    do until NetsisRecordSet.EOF 


 
                            if isnull(NetsisRecordSet("Toplam")) then 
                            else
                              a=a & " " & NetsisRecordSet("Toplam") & ","
                              b=b & " """ & NetsisRecordSet("Tarih") & ""","
                              sira=sira+1
                              gercektoplam=gercektoplam+cint(NetsisRecordSet("Toplam"))
                              ort=int(gercektoplam/sira)
                              if  cint(NetsisRecordSet("Toplam"))>300 then
                                gercektoplam2=gercektoplam2+cint(NetsisRecordSet("Toplam"))
                                sira2=sira2+1
                                ort2=int(gercektoplam2/sira2)


                                sira3=sira3+1
                                if sira3>22 then sira3=1
                                array1(sira3)=cint(NetsisRecordSet("Toplam"))
                                ortort=0
                                for i=1 to 22
                                ortort=ortort+array1(i)
                                next                            
                              end if 
                              c=c & " " & ort & "," 
                              d=d & " " & ort2 & "," 
                              e=e & " " & cint(ortort/22) & ","  
                            end if 
   
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close
                benimdata2a=(left(a,len(a)-1)) ' son virgülü sil
                benimdata2b=(left(b,len(b)-1))
                benimdata2c=(left(c,len(c)-1))
                benimdata2d=(left(d,len(d)-1))
                benimdata2e=(left(e,len(e)-1))



                %>
  </body>

  <script>

    var ctx = document.getElementById("myChart").getContext("2d");
    var myChart = new Chart(ctx, {
      type: "line",
      
      data: {
        labels: [<%=benimdata1b%>],
        datasets: [
          {
            label: "Monthly Production",
            data: [<%=benimdata1a%>],
            backgroundColor: "rgba(153,205,1,0.6)",
          },
          {
            label: "Average <%=currentDB%>",
            data: [<%=benimdata1c%>],
            backgroundColor: "rgba(205,153,1,0.6)",
          },             
          // {
          //   label: "Total",
          //   data: [<%=benimdata1d%>],
          //   backgroundColor: "rgba(205,1,153,0.2)",
          // },              
        ],
      },

    });


    var ctx = document.getElementById("myChart2").getContext("2d");
    var myChart2 = new Chart(ctx, {
      type: "line",
      data: {
        labels: [<%=benimdata2b%>],
        datasets: [
          {
            label: "Daily Production",
            data: [<%=benimdata2a%>],
            backgroundColor: "rgba(153,1,205,0.4)",
          },
          {
            label: "Average",
            data: [<%=benimdata2c%>],
            backgroundColor: "rgba(205,153,1,0.3)",
          },          
          {
            label: "Average (>300)",
            data: [<%=benimdata2d%>],
            backgroundColor: "rgba(153,153,153,0.3)",
          },          
          {
            label: "1 month Average",
            data: [<%=benimdata2e%>],
            backgroundColor: "rgba(53,53,253,0.5)",
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
