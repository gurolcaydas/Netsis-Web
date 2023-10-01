<html>
<%
UserLevel=session("UserLevel")
if instr(UserLevel,"s") then 'needed level'   %> 


     <head>

        <meta charset="utf-8">
        <meta http-equiv="Content-Language" content="tr">
        <META NAME="Generator" CONTENT="By hand">
        <META NAME="Author" CONTENT="Gurol">
        <meta name="copyright" content="Copyright ©2022 by Gurol, All Rights Reserved.">
        <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
        <title>NetsisWeb - Jobs Done</title>
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

        <!-- #include file="./subs/dbcon.asp" -->  
<body style="font-size: 14px; "  >                
                            <%
                                search_user = (request.form("search_user"))
                                'Response.Write (search_user&"***")
                            %>
    <div class="panel panel-default">
            <div class="container-fluid p-4">  
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Jobs Done</h3>
                        <div class="input-group">
                            <select class="form-control" name="search_user">
                                <option>Seç</option> <%
                                ' SQL   
                                    Netsis_SQL= " with liste as ( "
                                    Netsis_SQL=Netsis_SQL + " SELECT DISTINCT       [KAYITYAPANKUL] "
                                    Netsis_SQL=Netsis_SQL + "   FROM ["+currentDB+"].[dbo]..[TBLSTOKURM] "
                                    Netsis_SQL=Netsis_SQL + "   UNION ALL "
                                    Netsis_SQL=Netsis_SQL + " SELECT DISTINCT       [DUZELTMEYAPANKUL] "
                                    Netsis_SQL=Netsis_SQL + "   FROM ["+currentDB+"].[dbo].[TBLSTOKURM] "
                                    Netsis_SQL=Netsis_SQL + "   ) "
                                    Netsis_SQL=Netsis_SQL + "   select DISTINCT * from liste "
                                    Netsis_SQL=Netsis_SQL + " order by KAYITYAPANKUL "
                                ' SQL ende            
                                'Response.Write (Netsis_SQL)
                                NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                                    do until NetsisRecordSet.EOF 
                                    if NetsisRecordSet("KAYITYAPANKUL")=search_user then 
                                        Response.Write (" <option selected>"&NetsisRecordSet("KAYITYAPANKUL")&"</option>")
                                    else 
                                        Response.Write (" <option>"&NetsisRecordSet("KAYITYAPANKUL")&"</option>")
                                        end if 
                                        NetsisRecordSet.MoveNext
                                    loop
                                NetsisRecordSet.close %>
                            </select>
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            </div>
      <div>
        <canvas id="myChart" width="100%" height="10%"></canvas>
    </div>
    <div>
        <canvas id="myChart2"  width="100%" height="10%"></canvas>
      </div>    
    <div>
        <canvas id="myChart3"  width="100%" height="10%"></canvas>
      </div>    
    <div>
        <canvas id="myChart4"  width="100%" height="10%"></canvas>
      </div>    
    </div>





        <%






                ' SQL   
                    Netsis_SQL=" SELECT  "
                    Netsis_SQL=Netsis_SQL+" 		[KAYITYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+" 		,FORMAT ([KAYITTARIHI], 'yy-MM-dd') as recdate "
                    Netsis_SQL=Netsis_SQL+" 		,COUNT([INCKEYNO]) as Toplam "
                    Netsis_SQL=Netsis_SQL+"   FROM ["+currentDB+"].[dbo].[TBLSTOKURM] "
                    Netsis_SQL=Netsis_SQL+"   WHERE  [KAYITYAPANKUL] = '"&search_user&"' "
                    Netsis_SQL=Netsis_SQL+"   group by       [KAYITYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+"   ,FORMAT ([KAYITTARIHI], 'yy-MM-dd') "
                    Netsis_SQL=Netsis_SQL+" ORDER BY FORMAT ([KAYITTARIHI], 'yy-MM-dd') "
                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                    sira=0 

                    a=" "
                    b=" "

                    do until NetsisRecordSet.EOF 
                            if isnull(NetsisRecordSet("Toplam")) then 
                            else
                            a=a & " " & NetsisRecordSet("Toplam") & ","                                                  
                            b=b & " """ & NetsisRecordSet("recdate") & ""","
                            end if 
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close
                benimdata1a=(left(a,len(a)-1))
                benimdata1b=(left(b,len(b)-1))



                ' SQL   
                    Netsis_SQL=" SELECT  " 
                    Netsis_SQL=Netsis_SQL+"  [DUZELTMEYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+"  ,FORMAT ([DUZELTMETARIHI], 'yy-MM-dd') as editdate "
                    Netsis_SQL=Netsis_SQL+"  ,COUNT([INCKEYNO]) as toplam "
                    Netsis_SQL=Netsis_SQL+"  FROM ["+currentDB+"].[dbo].[TBLSTOKURM] "
                    Netsis_SQL=Netsis_SQL+"   WHERE  [DUZELTMEYAPANKUL] = '"&search_user&"' "
                    Netsis_SQL=Netsis_SQL+"  group by    "
                    Netsis_SQL=Netsis_SQL+"  [DUZELTMEYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+"  ,FORMAT ([DUZELTMETARIHI], 'yy-MM-dd')  "
                    Netsis_SQL=Netsis_SQL+"  ORDER BY  FORMAT ([DUZELTMETARIHI], 'yy-MM-dd')  "
                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                    sira=0 
                    a=" "
                    b=" "

                    do until NetsisRecordSet.EOF 
                            if isnull(NetsisRecordSet("Toplam")) then 
                            else
                            a=a & " " & NetsisRecordSet("Toplam") & ","                                                  
                            b=b & " """ & NetsisRecordSet("editdate") & ""","
                            end if 
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close
                benimdata2a=(left(a,len(a)-1))
                benimdata2b=(left(b,len(b)-1))

                ' SQL   

                    Netsis_SQL="   SELECT  "
                    Netsis_SQL=Netsis_SQL+"   [KAYITYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+"   ,FORMAT ([KAYITTARIHI], 'yy-MM-dd') as recdate "
                    Netsis_SQL=Netsis_SQL+"   ,COUNT(INGISIM) as toplam "
                    Netsis_SQL=Netsis_SQL+"   FROM  ["+currentDB+"].[dbo].[TBLSTSABITEK] "
                    Netsis_SQL=Netsis_SQL+"   WHERE  [KAYITYAPANKUL] = '"&search_user&"' "
                    Netsis_SQL=Netsis_SQL+"   group by       [KAYITYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+"   ,FORMAT ([KAYITTARIHI], 'yy-MM-dd') "
                    Netsis_SQL=Netsis_SQL+"   ORDER BY FORMAT ([KAYITTARIHI], 'yy-MM-dd')    "


                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                    sira=0 
                    a=" "
                    b=" "

                    do until NetsisRecordSet.EOF 
                            if isnull(NetsisRecordSet("Toplam")) then 
                            else
                            a=a & " " & NetsisRecordSet("Toplam") & ","                                                  
                            b=b & " """ & NetsisRecordSet("recdate") & ""","
                            end if 
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close
                benimdata3a=(left(a,len(a)-1))
                benimdata3b=(left(b,len(b)-1))

                ' SQL   

                    Netsis_SQL=" SELECT  " 
                    Netsis_SQL=Netsis_SQL+"  [DUZELTMEYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+"  ,FORMAT ([DUZELTMETARIHI], 'yy-MM-dd') as editdate "
                    Netsis_SQL=Netsis_SQL+"  ,COUNT([INGISIM]) as toplam "
                    Netsis_SQL=Netsis_SQL+"  FROM ["+currentDB+"].[dbo].[TBLSTSABITEK] "
                    Netsis_SQL=Netsis_SQL+"   WHERE  [DUZELTMEYAPANKUL] = '"&search_user&"' "
                    Netsis_SQL=Netsis_SQL+"  group by    "
                    Netsis_SQL=Netsis_SQL+"  [DUZELTMEYAPANKUL] "
                    Netsis_SQL=Netsis_SQL+"  ,FORMAT ([DUZELTMETARIHI], 'yy-MM-dd')  "
                    Netsis_SQL=Netsis_SQL+"  ORDER BY  FORMAT ([DUZELTMETARIHI], 'yy-MM-dd')  "
                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection 
                    sira=0 
                    a=" "
                    b=" "

                    do until NetsisRecordSet.EOF 
                            if isnull(NetsisRecordSet("Toplam")) then 
                            else
                            a=a & " " & NetsisRecordSet("Toplam") & ","                                                  
                            b=b & " """ & NetsisRecordSet("editdate") & ""","
                            end if 
                        NetsisRecordSet.MoveNext
                    loop
                NetsisRecordSet.close
                benimdata4a=(left(a,len(a)-1))
                benimdata4b=(left(b,len(b)-1))



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
            label: "Reçete Satırı Kayıt",
            data: [<%=benimdata1a%>],
            backgroundColor: "rgba(153,205,1,0.6)",
          },
       
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
            label: "Reçete Satırı Düzeltme",
            data: [<%=benimdata2a%>],
            backgroundColor: "rgba(153,1,205,0.4)",
          },
       
        ],
      },
    });  


    var ctx = document.getElementById("myChart3").getContext("2d");
    var myChart3 = new Chart(ctx, {
      type: "line",
      data: {
        labels: [<%=benimdata3b%>],
        datasets: [
          {
            label: "Stok Kartı Açılış",
            data: [<%=benimdata3a%>],
            backgroundColor: "rgba(205,153,1,0.4)",
          },
       
        ],
      },
    });  

    var ctx = document.getElementById("myChart4").getContext("2d");
    var myChart4 = new Chart(ctx, {
      type: "line",
      data: {
        labels: [<%=benimdata4b%>],
        datasets: [
          {
            label: "Stok Kartı Düzeltme",
            data: [<%=benimdata4a%>],
            backgroundColor: "rgba(205,1,153,0.4)",
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
