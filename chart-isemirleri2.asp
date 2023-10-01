<html> <%
UserLevel=session("UserLevel")
if instr(UserLevel,"p") then 'needed level'     %> 
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
        <link rel="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" type="text/css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript" ></script>
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
    <body style="font-size: 14px; "    >  
        <!-- #include file="./subs/dbcon.asp" -->
        <%
                currentDB=Session("currentDB")
        'currentDB="db2022"
        markalar2 = request.form("markalar1")
        Netsis_SQL = " SELECT SUBSTRING(A.STOK_KODU,1,2) as 'marka' "
        Netsis_SQL = Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLISEMRI] A "
        Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON A.STOK_KODU=B.STOK_KODU "
        Netsis_SQL = Netsis_SQL + " WHERE KAPALI='H' AND B.GRUP_KODU='FP1' AND LEFT(A.STOK_KODU,1)!='Y' "
        Netsis_SQL = Netsis_SQL + " GROUP BY SUBSTRING(A.STOK_KODU,1,2) "
        Netsis_SQL = Netsis_SQL + " ORDER BY SUBSTRING(A.STOK_KODU,1,2) "
        NetsisRecordSet.Open Netsis_SQL, NetsisConnection    
            dim sirali(100)
            sirali2=0
            do until NetsisRecordSet.EOF 
                bunlar=bunlar & "" & NetsisRecordSet("marka") & ","
                if instr(markalar2,NetsisRecordSet("marka")) OR len(markalar2)=0 then 
                    sirali2=sirali2+1
                    sirali(sirali2)=NetsisRecordSet("marka")
                    bunlar2=bunlar2 & "" & NetsisRecordSet("marka") & ","
                    isaretli="checked" 
                else 
                    isaretli=""
                end if 
                markalar=markalar+"<span class='input-group-text' id=''><input type='checkbox' name='markalar1'  ID='markalar1' value='"+NetsisRecordSet("marka")+"' "&isaretli&"  style='margin-right:10px;' aria-label='"+NetsisRecordSet("marka")+"'>"&NetsisRecordSet("marka")&"</span>"
                NetsisRecordSet.MoveNext
            loop
        NetsisRecordSet.close                                                                        
        bunlar=(left(bunlar,len(bunlar)-1))     
        bunlar2=(left(bunlar2,len(bunlar2)-1))     
        %>
        <form method='post'  action="chart-isemirleri2.asp">
            <div class="input-group-prepend">
                <div class="input-group-text">
                    <%=markalar%>
                    <button class="btn btn-secondary"  type="submit"  name="B1"  id="button-addon2"><i class="bi bi-arrow-return-left"></i></button> <span><%=markalar2%></span>
                </div>
                  
            </div> 
        </form>
        <div class="panel panel-default">
            <div>
                <canvas id="myChart2"    width="100%" height="45%"></canvas>
            </div>        
        </div>  <%
        ' SQL     
        Netsis_SQL = " SELECT * FROM ( "
        Netsis_SQL = Netsis_SQL + " SELECT month(A.[TARIH]) mmmm ,year(A.[TARIH]) yyyy ,Cast( month(A.[TARIH])as varchar(10)) +'-'+ cast(year(A.[TARIH]) as varchar(10)) as yyil ,sum(A.[MIKTAR]) as toplam,SUBSTRING(A.STOK_KODU,1,2) as 'marka' "
        Netsis_SQL = Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLISEMRI] A "
        Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B ON A.STOK_KODU=B.STOK_KODU "
        Netsis_SQL = Netsis_SQL + " WHERE KAPALI='H' AND B.GRUP_KODU='FP1' AND LEFT(A.STOK_KODU,1)!='Y' "
         if len(markalar2)>0 then 
             Netsis_SQL = Netsis_SQL + " AND ( "
             tam=0
             markalar3=Split(markalar2)
                 for each hermarka in markalar3
                     if tam=1 then Netsis_SQL = Netsis_SQL + " OR "
                     Netsis_SQL = Netsis_SQL + "  LEFT(A.STOK_KODU,2)='" & replace(hermarka,",","") & "' "
                     tam=1
                'Response.Write (hermarka&"-"&markalar2&"*"&bunlar&"-"&bunlar2&"*"&"<br>")
                 next
             Netsis_SQL = Netsis_SQL + " )"
         end if 
         if len(markalar2)=0 then markalar2=bunlar
        Netsis_SQL = Netsis_SQL + " GROUP BY month(A.[TARIH]) ,year(A.[TARIH]) ,SUBSTRING(A.STOK_KODU,1,2) "
        Netsis_SQL = Netsis_SQL + " ) AS S "
        Netsis_SQL = Netsis_SQL + " PIVOT (sum(Toplam) FOR marka IN ("&markalar2&")) AS P "
        Netsis_SQL = Netsis_SQL + " ORDER BY yyyy,mmmm "
        ' SQL ende                        
        'Response.Write (Netsis_SQL)
        NetsisRecordSet.Open Netsis_SQL, NetsisConnection    
            sira=1
            b=" "
            c=" "
            dim adata(100)
            do until NetsisRecordSet.EOF 
                for i=1 to sirali2
                    adata(i)=adata(i) & " " & (NetsisRecordSet(sirali(i)))    & ","
                next 
                b=b & " """ & NetsisRecordSet("yyil") & """," 
                NetsisRecordSet.MoveNext
            loop
        NetsisRecordSet.close
        benimdata2b=(left(b,len(b)-1)) 
        for i=1 to 100
            if len(adata(i))>0 then benimdata2x = benimdata2X & "{ label: '"&sirali(i)&"',    data: [" & (left(adata(i),len(adata(i))-1)) & " ],backgroundColor: 'rgba("&int(rnd()*255)&","&int(rnd()*255)&","&int(rnd()*255)&",0.6)',    fill:true },"
        next
        'Response.Write &benimdata2b&"<br>"&benimdata2x 
        %> 
    </body>
    <script> 
        var ctx = document.getElementById("myChart2").getContext("2d");
        var myChart2 = new Chart(ctx, {
            type: "bar",
            data: {
                labels: [<%=benimdata2b%>],
                datasets: [<%=benimdata2x%>],
                },
            options: {
                    plugins: {
                        title: {
                            display: true,
                            text: '<%=currentDB%>'
                        },
                    },
                responsive: true,
                scales: {
                    x: { stacked: true, },
                    y: { stacked: true }
                    }    
                },    
            });        
    </script> <%
else
        Response.redirect ("default.asp")
end if %>    

</html>
