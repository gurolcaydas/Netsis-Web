                    <!-- #include file="./dbcon.asp" -->
                    <%
                 
        url_item = request.querystring("item")      %>  

                               <table class="table table-sm table-striped table-hover align-middle">                        <%
        Netsis_SQL=" "
        Netsis_SQL=Netsis_SQL+"SELECT 									   "
        Netsis_SQL=Netsis_SQL+"      [FIYATLISTEKODU]					   "
        Netsis_SQL=Netsis_SQL+"      ,[STOKKODU]						   "
        Netsis_SQL=Netsis_SQL+"      ,[A_S]								   "
        Netsis_SQL=Netsis_SQL+"      ,[FIYAT1]							   "
        Netsis_SQL=Netsis_SQL+"      ,[FIYATDOVIZTIPI]					   "
        Netsis_SQL=Netsis_SQL+"      ,[BASTAR]							   "
        Netsis_SQL=Netsis_SQL+"      ,[BITTAR]							   "
        Netsis_SQL=Netsis_SQL+"      ,[OLCUBR]							   "
        Netsis_SQL=Netsis_SQL+"      ,[CARI_ISIM] 						   "
        Netsis_SQL=Netsis_SQL+"      ,A.[FIYATGRUBU]					   "
        Netsis_SQL=Netsis_SQL+"      ,C.[CARI_ISIM]					   "
        Netsis_SQL=Netsis_SQL+"  FROM [db2022].[dbo].[TBLSTOKFIAT] A	   "
        Netsis_SQL=Netsis_SQL+"	 LEFT JOIN [db2022].[dbo].[TBLFIATGRUP] B ON B.[FGRUP]=A.[FIYATGRUBU]   "
        Netsis_SQL=Netsis_SQL+"	 LEFT JOIN [db2022].[dbo].[TBLCASABIT] C ON B.[FGRUP]=C.[CARI_KOD]    "
        Netsis_SQL=Netsis_SQL+"  WHERE [STOKKODU] = '"&url_item&"'		   "
        Netsis_SQL=Netsis_SQL+"  ORDER BY [BASTAR]						   "
        sira=0
        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
            do until NetsisRecordSet.EOF OR sira>=250
                if sira=0 then 'başlık yaz '
                    response.write("<tr>")
                    response.write "<th>Sıra</th>"
                    response.write "<th>Fiyat Listesi</th>"
                    response.write "<th>Madde Kodu</th>"
                    response.write "<th>A</th>"
                    response.write "<th>Fiyat</th>"
                    response.write "<th>Başlangıç</th>"
                    response.write "<th>Bitiş</th>"
                    response.write "<th>Ölçü Birimi</th>"
                    response.write "<th>Cari</th>"
                    response.write("</tr>")
                    Response.ContentType = "text/html"
                    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
                    Response.CodePage = 65001
                    Response.CharSet = "UTF-8"   
                end if
                Sira=sira+1

                response.write("<tr>")
                response.write(" <td>"&Sira&"</td>")
                response.write("<td>"&NetsisRecordSet("FIYATLISTEKODU")&"</td>")
                response.write("<td>"&NetsisRecordSet("STOKKODU")&"</td>")
                response.write("<td>"&NetsisRecordSet("A_S")&"</td>")
                response.write("<td>"&NetsisRecordSet("FIYAT1")&" "&parabirimi(NetsisRecordSet("FIYATDOVIZTIPI"))&"</td>")
                response.write("<td>"&NetsisRecordSet("BASTAR")&"</td>")
                response.write("<td>"&NetsisRecordSet("BITTAR")&"</td>")
                response.write("<td>"&NetsisRecordSet("OLCUBR")&"</td>")
                response.write("<td>"&NetsisRecordSet("FIYATGRUBU")&" "&NetsisRecordSet("CARI_ISIM")&"</td>")
                response.write(" </tr>")
                NetsisRecordSet.movenext


      

                                        Loop
                                    NetsisRecordSet.close    
                                    if sira=0 then Response.write("null")                     %>
                                </table> <%
    NetsisConnection.Close
    Set NetsisRecordSet = Nothing
    Set NetsisConnection = Nothing
                
    function BeniKoddanArindir(bunuYaz)
            bunuYaz = Replace(bunuYaz, "<", "&lt;")
            bunuYaz = Replace(bunuYaz, ">", "&gt;")
            bunuYaz = Replace(bunuYaz, ",", "&sbquo;")
            bunuYaz = Replace(bunuYaz, "'", "&apos;")
            'bunuYaz = Replace(bunuYaz, CHR(132), "&rdquo;")
            BeniKoddanArindir=bunuYaz
    end function
    function parabirimi(t1)
        parabirimi="---"
        SELECT Case t1
        case 0
        parabirimi="TRL"
        case 1
        parabirimi="USD"
        case 2
        parabirimi="EUR"
        case 3
        parabirimi="JPY"
        case 4
        parabirimi="SEK"
        case 5
        parabirimi="GBP"
        case 6
        parabirimi="CHF"
        case 7
        parabirimi="RMB"
        case 8
        parabirimi="---"
        case 9
        parabirimi="TWD"
        end Select
    end function
%>