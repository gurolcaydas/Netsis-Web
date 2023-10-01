<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Axapta" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"u") then 'needed level'   %>         
    <div class="container-fluid font-monospace" style="margin-top:80px"> <%
        %>
        <!-- #include file="./subs/dbconAX.asp" -->
        <%
        search_bisiklet = BeniKoddanArindir(request.form("search_bisiklet"))
        search_bisiklet_kodu = BeniKoddanArindir(request.form("search_bisiklet_kodu"))
        search_bom = BeniKoddanArindir(request.form("search_bom"))
        if search_bisiklet_kodu="" and url_item<>"" then search_bisiklet_kodu=url_item

        if url_doo="" or  url_doo="list"  then 'alanlar boş ise sakın arama'

            %>
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>AX Bom arama</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_bisiklet_kodu" placeholder="Stok kodu"  value="<%=search_bisiklet_kodu%>">
                            <input class="form-control" type="text" name="search_bisiklet"  placeholder="Açıklama"  value="<%=search_bisiklet%>">
                            <input class="form-control" type="text" name="search_bom"  placeholder="Bom ID"  value="<%=search_bom%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            <%
        end if 
        if url_doo="list"  then 'alanlar boş ise sakın arama'


            ' SQL
                AX_SQL= "SELECT TOP (1000) [TODATE]					  "
                AX_SQL=AX_SQL+"      ,A.[FROMDATE]							  "
                AX_SQL=AX_SQL+"      ,A.[ITEMID]								  "
                AX_SQL=AX_SQL+"      ,A.[BOMID]								  "
                AX_SQL=AX_SQL+"      ,D2.[DESCRIPTION]								  "
                AX_SQL=AX_SQL+"      ,A.[ACTIVE]								  "
                AX_SQL=AX_SQL+"      ,A.[MODIFIEDDATETIME]					  "
                AX_SQL=AX_SQL+"      ,A.[MODIFIEDBY]							  "
                AX_SQL=AX_SQL+"      ,A.[VERSIYONNODISPLAY]					  "
                AX_SQL=AX_SQL+"      ,A.[AGC_BOMIDCOPYFROM]					  "
                AX_SQL=AX_SQL+"  FROM [MicrosoftDynamicsAX].[dbo].[BOMVERSION] A "
            AX_SQL=AX_SQL+"LEFT JOIN  [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] C2 ON C2.[ITEMID]=A.[ITEMID]														   "
            AX_SQL=AX_SQL+"LEFT JOIN  (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION] WHERE [LANGUAGEID]='en-us') D2 ON D2.[PRODUCT]=C2.[PRODUCT] "

                AX_SQL=AX_SQL+"  WHERE 1=1 "
            ' SQL   

                if len(search_bisiklet_kodu)>0 then     
                    if instr(search_bisiklet_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        AX_SQL=AX_SQL+" AND A.[ITEMID] LIKE '"&search_bisiklet_kodu&"' " 
                    else 
                        AX_SQL=AX_SQL+" AND A.[ITEMID] LIKE '%" &search_bisiklet_kodu&"%' " 
                    end if 
                end if 

                if len(search_bisiklet)>0 then     
                    if instr(search_bisiklet,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        AX_SQL=AX_SQL+" AND [DESCRIPTION] LIKE '"&search_bisiklet&"' " 
                    else 
                        AX_SQL=AX_SQL+" AND [DESCRIPTION] LIKE '%" &search_bisiklet&"%' " 
                    end if 
                end if 

                if len(search_BOM)>0 then     
                    if instr(search_BOM,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        AX_SQL=AX_SQL+" AND [BOMID] LIKE '"&search_BOM&"' " 
                    else 
                        AX_SQL=AX_SQL+" AND [BOMID] LIKE '%" &search_BOM&"%' " 
                    end if 
                end if 


            AXRecordSet.Open AX_SQL, AXConnection ,0,1 
            sira=0 
                do until AXRecordSet.EOF OR sira>=250
                    if sira=0 then %>
                        <div class="container-fluid p-4"><h4>Bom Listesi </h4>
                        <table class="table table-sm table-striped table-hover align-middle"> 
                              <thead>              <tr>
                        <th>Stok kodu</th> 
                        <th>Açıklama</th> 
                        <th colspan=2>Bom</th> 
                        <th>Aktif</th> 
                        <th>Versiyon</th> 
                        <th>Tarih</th> 
                    </tr>     </thead> <%
                    end if 
                    sira=sira+1   
                    if AXRecordSet("ACTIVE")=1 then 
                        aktif="<i class='bi bi-check-circle-fill text-success'></i>" 
                        aktif2=   "class='fw-bold'"          
                    else 
                        aktif=""                  
                        aktif2= "" 
                    end if  %>
                    <tr>
                        <td><%=AXRecordSet("ITEMID")%></td> 
                        <td><%=AXRecordSet("DESCRIPTION")%></td> 
                        <td <%=aktif2%>><%=AXRecordSet("BOMID")%>
                                             <td class="pr-0 text-right">
                                            <a  href="?doo=bomlist&item=<%=AXRecordSet("BOMID")%>" title="AX Ürün Ağacı <%=AXRecordSet("ITEMID")%>" >
                                            <div class="badge badge-pill bg-secondary">
                                                <i class="bi bi-journal-text"></i> 
                                            </div>
                                            </a> 
                                            </td>
                        <td><%=aktif%></td> 
                        <td><%=AXRecordSet("VERSIYONNODISPLAY")%></td> 
                        <td><%=AXRecordSet("FROMDATE")%> - <%=AXRecordSet("TODATE")%></td>
                    </tr>                             <%
                    AXRecordSet.movenext
                Loop                                                
            AXRecordSet.close  
            if sira=250 then response.write ("<tr><td colspan=5>Max. 250 kayıt görüntülendi.</td></tr>")     %> 
            </table> </div><%
        end if

        if url_doo="bomlist"  then 'alanlar boş ise sakın arama'
            AX_SQL=AX_SQL+"SELECT 																																   "
            AX_SQL=AX_SQL+"		A.[ITEMID] as axBom																														   "
            AX_SQL=AX_SQL+"		,A.[BOMID] as axBomID																														   "
            AX_SQL=AX_SQL+"		,D2.[DESCRIPTION]	as axBomName																													   "
            AX_SQL=AX_SQL+"		,E.[ITEMGROUPID] as axBomItemGroup																												   "
            AX_SQL=AX_SQL+"		,A.[ACTIVE]		as axAktif																												   "
            AX_SQL=AX_SQL+"		,B.[LINENUM]																													   "
            AX_SQL=AX_SQL+"		,B.[ITEMID]	 as axItem																													   "
            AX_SQL=AX_SQL+"		,F.[BOMID]	as axItemBom																													   "
            AX_SQL=AX_SQL+"		,F.[ACTIVE]		as axItemAktif																												   "
            AX_SQL=AX_SQL+"		,B.[BOMQTY]																														   "
            AX_SQL=AX_SQL+"		,B.[UNITID]																														   "
            AX_SQL=AX_SQL+"		,C.[ITEMGROUPID]	as axItemGroup																											   "
            AX_SQL=AX_SQL+"		,C.[PRODUCT]																													   "
            AX_SQL=AX_SQL+"		,D.[DESCRIPTION] as itemdesc																												   "
            AX_SQL=AX_SQL+"FROM [MicrosoftDynamicsAX].[dbo].[BOMVERSION] A																						   "
            AX_SQL=AX_SQL+"LEFT JOIN [MicrosoftDynamicsAX].[dbo].[BOM] B ON B.[BOMID]=A.[BOMID]																	   "
            AX_SQL=AX_SQL+"LEFT JOIN  [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] C ON C.[ITEMID]=B.[ITEMID]														   "
            AX_SQL=AX_SQL+"LEFT JOIN  [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] C2 ON C2.[ITEMID]=A.[ITEMID]														   "
            AX_SQL=AX_SQL+"LEFT JOIN  (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION] WHERE [LANGUAGEID]='en-us') D ON D.[PRODUCT]=C.[PRODUCT] "
            AX_SQL=AX_SQL+"LEFT JOIN  (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION] WHERE [LANGUAGEID]='en-us') D2 ON D2.[PRODUCT]=C2.[PRODUCT] "
            AX_SQL=AX_SQL+"LEFT JOIN [MicrosoftDynamicsAX].[dbo].[BOMTABLE] E ON E.[BOMID]=A.[BOMID]															   "
            AX_SQL=AX_SQL+"LEFT JOIN (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[BOMVERSION] WHERE ACTIVE=1) F ON F.ITEMID=B.ITEMID															   "
            AX_SQL=AX_SQL+"WHERE A.[BOMID] ='"&url_item&"'  																						   "
            AX_SQL=AX_SQL+" ORDER BY B.LINENUM "

            AXRecordSet.Open AX_SQL, AXConnection ,0,1 
            sira=0 
                do until AXRecordSet.EOF OR sira>=250
                    if sira=0 then %>
                        <div class="container-fluid p-4"><h4>Bom Listesi </h4><h3><%=AXRecordSet("axBom")%></h3><h4><%=AXRecordSet("axBomName")%></h4>
                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                        <table class="table table-sm table-striped table-hover align-middle" id="tblData"> 
                              <thead>              <tr>
                        <th>Stok kodu</th> 
                        <th>Açıklama</th> 
                        <th colspan=2>Bom</th> 
                        <th>Madde</th> 
                        <th>Miktar</th> 
                    </tr>     </thead> <%
                    end if 
                    sira=sira+1     %>
                    <tr>
                        <td><%=AXRecordSet("axItem")%></td> 
                        <td><%=AXRecordSet("itemdesc")%></td> 
                        <td><%=AXRecordSet("axItemBom")%>

                                             <td class="pr-0 text-right">
                         <%
                        if LEN(AXRecordSet("axItemBom"))>0 then  %>
                                           <a  href="?doo=bomlist&item=<%=AXRecordSet("axItemBom")%>" title="AX Ürün Ağacı <%=AXRecordSet("axItem")%>" >
                                            <div class="badge badge-pill bg-secondary">
                                                <i class="bi bi-journal-text"></i> 
                                            </div>
                                            </a> 
                        <%
                        end if %>
                                            </td>
                        <td><%=AXRecordSet("axItemGroup")%></td> 
                        <td><%=AXRecordSet("BOMQTY")%>&nbsp;<%=AXRecordSet("UNITID")%></td>
                    </tr>                             <%
                    AXRecordSet.movenext
                Loop                                                
            AXRecordSet.close  
            if sira=250 then response.write ("<tr><td colspan=5>Max. 250 kayıt görüntülendi.</td></tr>")     %> 
            </table> </div><%

        end if

        if (url_doo="cost" or  url_doo="costsearch") AND instr(UserLevel,"s")  then 'alanlar boş ise sakın arama'
            search_costgroupID = BeniKoddanArindir(request.form("search_costgroupID"))
            search_supplier = BeniKoddanArindir(request.form("search_supplier"))
            search_item = BeniKoddanArindir(request.form("search_item"))
            search_date1 = request.form("search_date1")
            search_date2 = request.form("search_date2")

            %>
                <form class="form-horizontal" method="POST" action="?doo=cost">
                    <div class="container-fluid p-4"><h4>AX Maliyet Katsayı Analiz Raporu</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_supplier"  placeholder="Cari Hesap Kodu"  value="<%=search_supplier%>">
                            <input class="form-control" type="text" name="search_costgroupID" placeholder="Maliyet Grubu"  value="<%=search_costgroupID%>">
                            <input class="form-control" type="text" name="search_item"  placeholder="Stok Kodu"  value="<%=search_item%>">
                            <input class="form-control" type="date" name="search_date1"   value="<%=search_date1%>">
                            <input class="form-control" type="date" name="search_date2"   value="<%=search_date2%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            <%
        end if 

        if url_doo="cost" AND instr(UserLevel,"s")  then
            ' SQL
                AX_SQL=AX_SQL+" SELECT TOP 1000 [PURCHID] " 
                AX_SQL=AX_SQL+"       ,A.[VENDACCOUNT] " 
                AX_SQL=AX_SQL+"       ,B.[NAME] " 
                AX_SQL=AX_SQL+"       ,A.[ITEMID] " 
                AX_SQL=AX_SQL+"       ,A.[COSTGROUPID] " 
                AX_SQL=AX_SQL+"       ,A.[CURRENCYCODE] " 
                AX_SQL=AX_SQL+"       ,A.[PURCHPRICE] " 
                AX_SQL=AX_SQL+"       ,A.[PURCHPRICEMST] " 
                AX_SQL=AX_SQL+"       ,A.[QTY] " 
                AX_SQL=AX_SQL+"       ,A.[LINEAMOUNT] " 
                AX_SQL=AX_SQL+"       ,A.[LINEAMOUNTMST] " 
                AX_SQL=AX_SQL+"       ,A.[ITEMNAME] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP1_FEE] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP2_ARDIYE] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP3_CREDITNOTE] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP4_EKMASRAF] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP5_GUMVERGISI] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP6_GUMRUKCUKOMISYONCU] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP7_ICNAKLIYE] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP8_ISCILIK] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP9_ISKONTO] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP10_KOMISYON] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP11_LIMANICIMASRAFLAR] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP12_NAVLUN] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP13_ORDINO] " 
                AX_SQL=AX_SQL+"       ,A.[MARKUP14_SIGORTA] " 
                AX_SQL=AX_SQL+"       ,A.[INVOICEDATE] " 
                AX_SQL=AX_SQL+"       ,A.[INVOICEID] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP1_FEE] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP2_ARDIYE] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP3_CREDITNOTE] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP4_EKMASRAF] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP5_GUMVERGISI] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP6_GUMRUKCUKOMISYONCU] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP7_ICNAKLIYE] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP8_ISCILIK] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP9_ISKONTO] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP10_KOMISYON] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP11_LIMANICIMASRAFLAR] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP12_NAVLUN] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP13_ORDINO] " 
                AX_SQL=AX_SQL+"       ,A.[RATEMARKUP14_SIGORTA] " 
                AX_SQL=AX_SQL+"       ,A.[SUMMARKUP] " 
                AX_SQL=AX_SQL+"       ,A.[DLVMODEID] " 
                AX_SQL=AX_SQL+"       ,A.[CREATEDDATETIME] " 
                AX_SQL=AX_SQL+"       ,A.[CREATEDBY] " 
                AX_SQL=AX_SQL+"       ,A.[DATAAREAID] " 
                AX_SQL=AX_SQL+"       ,A.[RECVERSION] " 
                AX_SQL=AX_SQL+"       ,A.[PARTITION] " 
                AX_SQL=AX_SQL+"       ,A.[RECID] " 
                AX_SQL=AX_SQL+"       ,A.[UN_DECLARATION] " 
                AX_SQL=AX_SQL+"       ,A.[UN_ISTATISTIKITUTAR] " 
                AX_SQL=AX_SQL+"       ,A.[UN_DECLARATIONDATE] " 
                AX_SQL=AX_SQL+"       ,A.[DLVTERM] " 
                AX_SQL=AX_SQL+"   FROM [MicrosoftDynamicsAX].[dbo].[ERP_PURCHITEMCOSTREPORT] A " 
                AX_SQL=AX_SQL+"   LEFT JOIN [MicrosoftDynamicsAX].[dbo].[VENDTABLE] B ON A.[VENDACCOUNT]=B.[ACCOUNTNUM] "
                AX_SQL=AX_SQL+"   WHERE 1=1 " 
                if len(search_item)>0 then  AX_SQL=AX_SQL+"   AND A.ITEMID LIKE '%"&search_item&"%' " 
                if len(search_supplier)>0 then  AX_SQL=AX_SQL+"   AND A.VENDACCOUNT LIKE '%"&search_supplier&"%' " 
                if len(search_costgroupID)>0 then  AX_SQL=AX_SQL+"   AND A.COSTGROUPID LIKE '%"&search_costgroupID&"%' " 
                if len(search_date1)>0 then  AX_SQL=AX_SQL+"   AND UN_DECLARATIONDATE>='"&search_date1&"' " 
                if len(search_date2)>0 then  AX_SQL=AX_SQL+"   AND UN_DECLARATIONDATE<='"&search_date2&"' " 
            ' SQL end
            'response.write(AX_SQL)
            'response.write(search_date1&" "&search_date2)

            AXRecordSet.Open AX_SQL, AXConnection ,0,1 
            sira=0 
                do until AXRecordSet.EOF OR sira>=1000
                    if sira=0 then %>
                        <div class="container-fluid p-4"><h4>Katsayılar </h4>
                        <table class="table table-sm table-striped table-hover align-middle"> 
                              <thead>              <tr>
                                <th>PURCHID</th>
                                <th>VENDACCOUNT</th>
                                <th>Cari</th>
                                <th>ITEMID</th>
                                <th>COSTGROUPID</th>
                                <th>CURRENCYCODE</th>
                                <th>PURCHPRICE</th>
                                <th>PURCHPRICEMST</th>
                                <th>QTY</th>
                                <th>LINEAMOUNT</th>
                                <th>LINEAMOUNTMST</th>
                                <th>ITEMNAME</th>
                                <th> 1 FEE</th>
                                <th> 2 ARDIYE</th>
                                <th> 3 CREDITNOTE</th>
                                <th> 4 EKMASRAF</th>
                                <th> 5 GUMVERGISI</th>
                                <th> 6 GUMRUKCUKOMISYONCU</th>
                                <th> 7 ICNAKLIYE</th>
                                <th> 8 ISCILIK</th>
                                <th> 9 ISKONTO</th>
                                <th> 10 KOMISYON</th>
                                <th> 11 LIMANICIMASRAFLAR</th>
                                <th> 12 NAVLUN</th>
                                <th> 13 ORDINO</th>
                                <th> 14 SIGORTA</th>
                                <th>INVOICEDATE</th>
                                <th>INVOICEID</th>
                                <th>RATE 1 FEE</th>
                                <th>RATE 2 ARDIYE</th>
                                <th>RATE 3 CREDITNOTE</th>
                                <th>RATE 4 EKMASRAF</th>
                                <th>RATE 5 GUMVERGISI</th>
                                <th>RATE 6 GUMRUKCUKOMISYONCU</th>
                                <th>RATE 7 ICNAKLIYE</th>
                                <th>RATE 8 ISCILIK</th>
                                <th>RATE 9 ISKONTO</th>
                                <th>RATE 10 KOMISYON</th>
                                <th>RATE 11 LIMANICIMASRAFLAR</th>
                                <th>RATE 12 NAVLUN</th>
                                <th>RATE 13 ORDINO</th>
                                <th>RATE 14 SIGORTA</th>
                                <th>SUM </th>
                                <th>DLVMODEID</th>
                                <th>CREATEDDATETIME</th>
                                <th>CREATEDBY</th>
                                <th>DATAAREAID</th>
                                <th>RECVERSION</th>
                                <th>PARTITION</th>
                                <th>RECID</th>
                                <th>UN DECLARATION</th>
                                <th>UN ISTATISTIKITUTAR</th>
                                <th>UN DECLARATIONDATE</th>
                                <th>DLVTERM</th>
                            </tr>     
                            </thead> <%
                    end if 
                    sira=sira+1   
                    %>
                    <tr class="text-nowrap">
                        <td><%=AXRecordSet("PURCHID")%></td> 
                        <td><%=AXRecordSet("VENDACCOUNT")%></td> 
                        <td><%=AXRecordSet("NAME")%></td> 
                        <td><strong><%=AXRecordSet("ITEMID")%></strong></td> 
                        <td><%=AXRecordSet("COSTGROUPID")%></td> 
                        <td><%=AXRecordSet("CURRENCYCODE")%></td> 
                        <td><%=AXRecordSet("PURCHPRICE")%></td> 
                        <td><%=AXRecordSet("PURCHPRICEMST")%></td> 
                        <td><%=AXRecordSet("QTY")%></td> 
                        <td><%=AXRecordSet("LINEAMOUNT")%></td> 
                        <td><%=AXRecordSet("LINEAMOUNTMST")%></td> 
                        <td><%=AXRecordSet("ITEMNAME")%></td> 
                        <td><%=AXRecordSet("MARKUP1_FEE")%></td> 
                        <td><%=AXRecordSet("MARKUP2_ARDIYE")%></td> 
                        <td><%=AXRecordSet("MARKUP3_CREDITNOTE")%></td> 
                        <td><%=AXRecordSet("MARKUP4_EKMASRAF")%></td> 
                        <td><%=AXRecordSet("MARKUP5_GUMVERGISI")%></td> 
                        <td><%=AXRecordSet("MARKUP6_GUMRUKCUKOMISYONCU")%></td> 
                        <td><%=AXRecordSet("MARKUP7_ICNAKLIYE")%></td> 
                        <td><%=AXRecordSet("MARKUP8_ISCILIK")%></td> 
                        <td><%=AXRecordSet("MARKUP9_ISKONTO")%></td> 
                        <td><%=AXRecordSet("MARKUP10_KOMISYON")%></td> 
                        <td><%=AXRecordSet("MARKUP11_LIMANICIMASRAFLAR")%></td> 
                        <td><%=AXRecordSet("MARKUP12_NAVLUN")%></td> 
                        <td><%=AXRecordSet("MARKUP13_ORDINO")%></td> 
                        <td><%=AXRecordSet("MARKUP14_SIGORTA")%></td> 
                        <td><%=AXRecordSet("INVOICEDATE")%></td> 
                        <td><%=AXRecordSet("INVOICEID")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP1_FEE")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP2_ARDIYE")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP3_CREDITNOTE")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP4_EKMASRAF")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP5_GUMVERGISI")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP6_GUMRUKCUKOMISYONCU")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP7_ICNAKLIYE")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP8_ISCILIK")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP9_ISKONTO")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP10_KOMISYON")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP11_LIMANICIMASRAFLAR")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP12_NAVLUN")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP13_ORDINO")%></td> 
                        <td><%=AXRecordSet("RATEMARKUP14_SIGORTA")%></td> 
                        <td><%=AXRecordSet("SUMMARKUP")%></td> 
                        <td><%=AXRecordSet("DLVMODEID")%></td> 
                        <td><%=AXRecordSet("CREATEDDATETIME")%></td> 
                        <td><%=AXRecordSet("CREATEDBY")%></td> 
                        <td><%=AXRecordSet("DATAAREAID")%></td> 
                        <td><%=AXRecordSet("RECVERSION")%></td> 
                        <td><%=AXRecordSet("PARTITION")%></td> 
                        <td><%=AXRecordSet("RECID")%></td> 
                        <td><%=AXRecordSet("UN_DECLARATION")%></td> 
                        <td><%=AXRecordSet("UN_ISTATISTIKITUTAR")%></td> 
                        <td><%=AXRecordSet("UN_DECLARATIONDATE")%></td> 
                        <td><%=AXRecordSet("DLVTERM")%></td> 

                    </tr>                             <%
                    AXRecordSet.movenext
                Loop                                                
            AXRecordSet.close  
            if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> </div><%


        end if

        AXConnection.Close
        Set AXRecordSet = Nothing
        Set AXConnection = Nothing %>
    </div> <%
else
    Response.Write ("User level?")
end if


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
<!-- #include file="./include/footer.asp" -->