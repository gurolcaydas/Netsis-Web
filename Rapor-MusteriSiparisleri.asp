<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<% BaslikHTML="Açık Müşteri Siparişleri" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"a") then 'needed level'   %>        
    <script type="text/javascript" src="include/xlsx.full.min.js"></script>
    <script type="text/javascript">
        function html_table_to_excel(type,str,str2) { // Excel
            var data = document.getElementById(str2);
            var file = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
            XLSX.write(file, { bookType: type, bookSST: true, type: 'base64' });
            XLSX.writeFile(file, str + '.' + type);
        }
    </script> 
    <div class="container-fluid" style="margin-top:80px"> <%
        %>
        <!-- #include file="./subs/dbcon.asp" -->
        <%
        search_siparis_no = BeniKoddanArindir(request.form("search_siparis_no"))
        search_bisiklet = BeniKoddanArindir(request.form("search_bisiklet"))
        search_bisiklet_kodu = BeniKoddanArindir(request.form("search_bisiklet_kodu"))
        search_cari_kod = BeniKoddanArindir(request.form("search_cari_kod"))
        search_cari = BeniKoddanArindir(request.form("search_cari"))
        search_AS = BeniKoddanArindir(request.form("search_AS"))
        if request.form("detayli")="on" then search_detayli ="checked" else search_detayli="" 
        if request.form("tarihli")="on" then search_tarihli ="checked" else search_tarihli="" 
        if request.form("fisnolu")="on" then search_fisnolu ="checked" else search_fisnolu="" 
        if len(search_siparis_no)=0 then search_siparis_no = request.querystring("search_siparis_no")        
        if url_doo="" or url_doo="list" then
            %>
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Açık Müşteri Siparişleri</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_cari_kod"  placeholder="Cari Kodu"  value="<%=search_cari_kod%>">
                            <input class="form-control" type="text" name="search_cari"  placeholder="Cari"  value="<%=search_cari%>">
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_fisnolu%> id="fisnolu" name="fisnolu" >
                            </div>
                            <input class="form-control" type="text" name="search_siparis_no" placeholder="Sipariş No"  value="<%=search_siparis_no%>">
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_detayli%> id="detayli" name="detayli" >
                            </div>
                            <input class="form-control" type="text" name="search_bisiklet_kodu" placeholder="Stok kodu"  value="<%=search_bisiklet_kodu%>">
                            <input class="form-control" type="text" name="search_bisiklet"  placeholder="Açıklama"  value="<%=search_bisiklet%>">
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_tarihli%> id="tarihli" name="tarihli" >
                                <label style="padding-left:5px;">Tarihli</label>
                            </div>
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Listele">
                        </div>
                    </div>                           
                </form> 
            <%
        end if
 
        if url_doo="list" and (search_bisiklet_kodu&search_bisiklet&search_cari_kod&search_cari&search_siparis_no<>"") then 'Sadece cari ve liste numaması ile arama'
            ' SQL 
                Netsis_SQL= " SELECT                             "
                if search_fisnolu ="checked" then 
                    Netsis_SQL=Netsis_SQL + " A.FISNO,  I.ISEMRINO as isemrino ,"
                end if
                Netsis_SQL=Netsis_SQL + " SUM(A.FIRMA_DOVTUT) Sevk, "
                'Netsis_SQL=Netsis_SQL + " SUM(URETIM.URETILEN) as 'uretildi', "

                if search_detayli ="checked" then 
                    Netsis_SQL=Netsis_SQL + " A.[STOK_KODU] as Item, "
                    Netsis_SQL=Netsis_SQL + " B.[STOK_ADI] as Descr , "
                end if
                Netsis_SQL=Netsis_SQL + "  SUM([STHAR_GCMIK]) as TotalOrder , "
                if search_tarihli ="checked" then 
                    Netsis_SQL=Netsis_SQL + " YEAR(STHAR_TESTAR) as DateYear, "
                    Netsis_SQL=Netsis_SQL + " MONTH(STHAR_TESTAR) as DateMonth , "
                end if
                Netsis_SQL=Netsis_SQL + " C.CARI_KOD as AccountN, "
                Netsis_SQL=Netsis_SQL + " C.CARI_ISIM as Account "
                Netsis_SQL=Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLSIPATRA] A WITH (NOLOCK) "
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] B  WITH (NOLOCK) ON B.STOK_KODU=A.STOK_KODU "
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] C  WITH (NOLOCK) ON C.CARI_KOD=A.STHAR_CARIKOD "
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSIPAMAS] D  WITH (NOLOCK) ON D.FATIRS_NO=A.FISNO "
                Netsis_SQL=Netsis_SQL + " LEFT JOIN  ["+currentDB+"].[dbo].TBLISEMRI I  WITH (NOLOCK) ON I.SIPARIS_NO=A.FISNO  AND I.STOK_KODU=A.STOK_KODU  "
                'Netsis_SQL=Netsis_SQL + " OUTER APPLY ( SELECT  U.URETSON_MAMUL, U.URETSON_SIPNO,SUM(ISNULL(URETSON_MIKTAR,0)) AS URETILEN FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  I.ISEMRINO=U.URETSON_SIPNO AND U.URETSON_MAMUL=A.STOK_KODU GROUP BY  U.URETSON_MAMUL,U.URETSON_SIPNO ) AS URETIM "

                Netsis_SQL=Netsis_SQL + " WHERE B.GRUP_KODU='FP1' AND A.SUBE_KODU=1 AND D.ISLETME_KODU=2 AND A.DEPO_KODU!='62' AND (I.KAPALI='H' OR I.KAPALI IS NULL)  "
                if search_detayli ="checked" then 
                    if len(search_bisiklet_kodu)>0 then     
                        if instr(search_bisiklet_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                            Netsis_SQL=Netsis_SQL+" AND A.STOK_KODU LIKE '"&search_bisiklet_kodu&"' " 
                        else 
                            Netsis_SQL=Netsis_SQL+" AND A.STOK_KODU LIKE '%" &search_bisiklet_kodu&"%' " 
                        end if 
                    end if 
                    if len(search_bisiklet)>0 then     
                        if instr(search_bisiklet,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                            Netsis_SQL=Netsis_SQL+" AND B.[STOK_ADI] LIKE '"&search_bisiklet&"' " 
                        else 
                            Netsis_SQL=Netsis_SQL+" AND B.[STOK_ADI] LIKE '%" &search_bisiklet&"%' " 
                        end if 
                    end if 
                end if
                if len(search_siparis_no)>0 then     
                    if instr(search_siparis_no,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND A.FISNO LIKE '"&search_siparis_no&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND A.FISNO LIKE '%" &search_siparis_no&"%' " 
                    end if 
                end if 
                if len(search_cari_kod)>0 then     
                    if instr(search_cari_kod,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND C.CARI_KOD LIKE '" &search_cari_kod&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND C.CARI_KOD LIKE '%" &search_cari_kod&"%' " 
                    end if 
                end if 
                if len(search_cari)>0 then     
                    if instr(search_cari,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '" &search_cari&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '%" &search_cari&"%' " 
                    end if 
                end if            
                Netsis_SQL=Netsis_SQL + " GROUP BY  C.CARI_ISIM, C.CARI_KOD "         
                if search_fisnolu ="checked" then Netsis_SQL=Netsis_SQL + ",A.FISNO, I.ISEMRINO "
                if search_tarihli ="checked" then Netsis_SQL=Netsis_SQL + ",YEAR(STHAR_TESTAR), MONTH(STHAR_TESTAR)"
                if search_detayli ="checked" then Netsis_SQL=Netsis_SQL + ", B.[STOK_ADI] , A.STOK_KODU "
                Netsis_SQL=Netsis_SQL + " ORDER BY  C.CARI_ISIM, C.CARI_KOD "
                if search_fisnolu ="checked" then Netsis_SQL=Netsis_SQL + ",A.FISNO, I.ISEMRINO "
                if search_tarihli ="checked" then Netsis_SQL=Netsis_SQL + ",YEAR(STHAR_TESTAR), MONTH(STHAR_TESTAR)"
                if search_detayli ="checked" then Netsis_SQL=Netsis_SQL + ", B.[STOK_ADI] , A.STOK_KODU "
            ' SQL ende
            'response.write(Netsis_SQL)
            'response.write("<br>"&search_detayli&"***"&search_tarihli&"***"&search_fisnolu&"***")
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            sira=0 
                do until NetsisRecordSet.EOF OR sira>=5000
 
                    if sira=0 then %>
                        <div class="container-fluid p-4"> 
                        <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>

                        <table class="table table-sm table-striped table-hover align-middle" id="tblData">  
                            <thead>
                                <th class="text-secondary"><%=sira%></th>
                                <% if search_fisnolu ="checked" then  %>
                                    <th class="small">Fiş No</th><th class="small">İş Emri No</th>
                                <% end if %>
                                <th class="small">Cari</th><th class="small" >Cari-</th>
                                <% if search_detayli ="checked" then  %>
                                    <th class="small" >Mamül</th><th class="small" >Mamül-</th>
                                <% end if %>
                                <th class="small">Miktar</th>
                                 <th class="small">Sevk Edilmiş</th> 
                                <% if search_tarihli ="checked" then  %>
                                    <th class="small" >Yıl</th><th class="small"  >Ay</th>                      
                                <% end if %>
                            </thead> <tbody>           <%
                    end if 
                    sira=sira+1                                     %>
                    <tr>
                        <td class="text-secondary"><%=sira%></td>
                        <% if search_fisnolu ="checked" then  %>
                            <td class="small"><%=NetsisRecordSet("FISNO")%></td>
                            <td class="small"><%=NetsisRecordSet("isemrino")%></td>
                        <% end if %>
                        <td class="small"><%=NetsisRecordSet("AccountN")%></td>
                        <td class="small"><%=NetsisRecordSet("Account")%></td>
                        <% if search_detayli ="checked" then  %>
                            <td class="small"><%=NetsisRecordSet("Item")%></td>
                            <td class="small"><%=NetsisRecordSet("Descr")%></td>
                        <% end if %>
                        <td class="small"><%=NetsisRecordSet("TotalOrder")%></td>
                        <td class="small"><%=NetsisRecordSet("Sevk")%></td>  
                        <% if search_tarihli ="checked" then  %>
                            <td class="small"><%=NetsisRecordSet("DateYear")%></td>
                            <td class="small"><%=NetsisRecordSet("DateMonth")%></td>                      
                        <% end if %>
                    </tr>                             <%
                    NetsisRecordSet.movenext
                Loop                                                
            NetsisRecordSet.close  
            if sira=0 then response.write ("Kayıt bulunamadı...")  
            %>  </tbody></table> <%   
            if sira=5000 then response.write ("Max. 5000 kayıt görüntülendi.")     %> 
             </div><%
        end if   
        %> 

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
<script>
let table = new DataTable('#tblData', {
        "lengthMenu": [[-1, 10, 20, 100], [ "All" ,10, 20, 100]]
   // options
});

</script>

<!-- #include file="./include/footer.asp" -->