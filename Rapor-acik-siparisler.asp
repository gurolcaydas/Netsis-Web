<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Açık Siparişler" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   

    search_kod2 = BeniKoddanArindir(request.form("search_kod2"))
    search_grup_kodu = BeniKoddanArindir(request.form("search_grup_kodu"))
    search_stok_kodu = BeniKoddanArindir(request.form("search_stok_kodu")) 
    search_stok_cari = BeniKoddanArindir(request.form("search_stok_cari")) %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Açık Siparişler.</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_stok_kodu"  placeholder="Stok Kodu"  value="<%=search_stok_kodu%>">
                            <input class="form-control" type="text" name="search_grup_kodu"  placeholder="Grup Kodu (FP1 CO1 PA1 NS1)"  value="<%=search_grup_kodu%>">
                            <input class="form-control" type="text" name="search_kod2"  placeholder="Kod 2"  value="<%=search_kod2%>">
                            <input class="form-control" type="text" name="search_stok_cari"  placeholder="Cari"  value="<%=search_stok_cari%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
    <%
    if len(search_stok_kodu&search_kod2&search_stok_cari&search_grup_kodu)>0 then 
    %>
        <div class="container-fluid p-4"> 
        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>

            <table class="table table-sm table-striped table-hover align-middle nowrap" id="tblData">         <%
                ' SQL   



Netsis_SQL="SELECT  "
' **********************************************************************'
Netsis_SQL=Netsis_SQL+"F.STHAR_TARIH as 'Irsaliye_Tarihi' "
Netsis_SQL=Netsis_SQL+",F.STHAR_SIPNUM as 'Irsaliye_No' "
Netsis_SQL=Netsis_SQL+",F.STRA_SIPKONT as 'Sira2' "
Netsis_SQL=Netsis_SQL+",F.STHAR_GCMIK as 'Miktar2' "
Netsis_SQL=Netsis_SQL+",CASE "
Netsis_SQL=Netsis_SQL+"	WHEN F.OLCUBR=1  THEN E.OLCU_BR1 "
Netsis_SQL=Netsis_SQL+"	WHEN F.OLCUBR=2  THEN E.OLCU_BR2 "
Netsis_SQL=Netsis_SQL+"	WHEN F.OLCUBR=3  THEN E.OLCU_BR3 "
Netsis_SQL=Netsis_SQL+"	ELSE NULL "
Netsis_SQL=Netsis_SQL+"END AS 'Birim2' "
Netsis_SQL=Netsis_SQL+",F.STHAR_NF as 'Fiyat2_TL' "
Netsis_SQL=Netsis_SQL+",F.STHAR_DOVFIAT as 'Fiyat2_Doviz' "
Netsis_SQL=Netsis_SQL+",CASE "
Netsis_SQL=Netsis_SQL+"	WHEN F.STHAR_DOVTIP=0  THEN 'TRY' "
Netsis_SQL=Netsis_SQL+"	WHEN F.STHAR_DOVTIP=1  THEN 'USD' "
Netsis_SQL=Netsis_SQL+"	WHEN F.STHAR_DOVTIP=2  THEN 'EUR' "
Netsis_SQL=Netsis_SQL+"	WHEN F.STHAR_DOVTIP=3  THEN 'YEN' "
Netsis_SQL=Netsis_SQL+"	WHEN F.STHAR_DOVTIP=7  THEN 'RMB' "
Netsis_SQL=Netsis_SQL+"	WHEN F.STHAR_DOVTIP=9  THEN 'TWD' "
Netsis_SQL=Netsis_SQL+"	ELSE NULL "
Netsis_SQL=Netsis_SQL+"END AS 'Doviz2' "
'**************************************************************************'
Netsis_SQL=Netsis_SQL+",Y.STOK_KODU as 'Stok_Kodu' "
Netsis_SQL=Netsis_SQL+",E.STOK_ADI as 'Stok_Adi' "
Netsis_SQL=Netsis_SQL+",E.GRUP_KODU as 'Grup_Kodu' "
Netsis_SQL=Netsis_SQL+",G.GRUP_ISIM as 'Madde_grubu' "
Netsis_SQL=Netsis_SQL+",G2.GRUP_ISIM as 'Kod2' "
' **********************************************************************'
Netsis_SQL=Netsis_SQL+",Y.STHAR_TARIH as 'Siparis_Tarihi' "
Netsis_SQL=Netsis_SQL+",Y.FISNO as 'Siparis_No' "
Netsis_SQL=Netsis_SQL+",Y.SIRA as 'Sira' "
Netsis_SQL=Netsis_SQL+",Y.STHAR_GCMIK as 'Miktar' "
Netsis_SQL=Netsis_SQL+",CASE "
Netsis_SQL=Netsis_SQL+"	WHEN Y.OLCUBR=1  THEN E.OLCU_BR1 "
Netsis_SQL=Netsis_SQL+"	WHEN Y.OLCUBR=2  THEN E.OLCU_BR2 "
Netsis_SQL=Netsis_SQL+"	WHEN Y.OLCUBR=3  THEN E.OLCU_BR3 "
Netsis_SQL=Netsis_SQL+"	ELSE NULL "
Netsis_SQL=Netsis_SQL+"END AS 'Birim' "
Netsis_SQL=Netsis_SQL+",Y.STHAR_NF as 'Fiyat_TL' "
Netsis_SQL=Netsis_SQL+",Y.STHAR_GCKOD as 'GC' "
Netsis_SQL=Netsis_SQL+",Y.STHAR_CARIKOD as 'Cari_Kod' "
Netsis_SQL=Netsis_SQL+",C.CARI_ISIM as 'Cari' "
Netsis_SQL=Netsis_SQL+",Y.STHAR_DOVFIAT as 'Fiyat_Doviz' "
Netsis_SQL=Netsis_SQL+",CASE "
Netsis_SQL=Netsis_SQL+"	WHEN Y.STHAR_DOVTIP=0  THEN 'TRY' "
Netsis_SQL=Netsis_SQL+"	WHEN Y.STHAR_DOVTIP=1  THEN 'USD' "
Netsis_SQL=Netsis_SQL+"	WHEN Y.STHAR_DOVTIP=2  THEN 'EUR' "
Netsis_SQL=Netsis_SQL+"	WHEN Y.STHAR_DOVTIP=3  THEN 'YEN' "
Netsis_SQL=Netsis_SQL+"	WHEN Y.STHAR_DOVTIP=7  THEN 'RMB' "
Netsis_SQL=Netsis_SQL+"	WHEN Y.STHAR_DOVTIP=9  THEN 'TWD' "
Netsis_SQL=Netsis_SQL+"	ELSE NULL "
Netsis_SQL=Netsis_SQL+"END AS 'Doviz' "
'**************************************************************************'
Netsis_SQL=Netsis_SQL+"FROM "+currentDB+".dbo.TBLSIPATRA Y WITH (NOLOCK) "
Netsis_SQL=Netsis_SQL+"LEFT JOIN "+currentDB+".dbo.TBLSTSABIT E WITH (NOLOCK) ON Y.STOK_KODU=E.STOK_KODU "
Netsis_SQL=Netsis_SQL+"LEFT JOIN "+currentDB+".dbo.TBLSTHAR F WITH (NOLOCK) ON F.STHAR_SIPNUM=Y.FISNO  AND (F.SUBE_KODU=1 OR F.SUBE_KODU=2) AND F.STOK_KODU=Y.STOK_KODU AND Y.SIRA=F.STRA_SIPKONT "
Netsis_SQL=Netsis_SQL+"LEFT JOIN "+currentDB+".dbo.TBLCASABIT C WITH (NOLOCK) ON C.CARI_KOD=Y.STHAR_CARIKOD "
Netsis_SQL=Netsis_SQL+"LEFT JOIN "+currentDB+".dbo.TBLSTOKKOD1 G ON E.KOD_1=G.GRUP_KOD "
Netsis_SQL=Netsis_SQL+"LEFT JOIN "+currentDB+".dbo.TBLSTOKKOD2 G2 ON E.KOD_2=G2.GRUP_KOD "
Netsis_SQL=Netsis_SQL+"WHERE  (Y.SUBE_KODU=1 OR Y.SUBE_KODU=2) "
if len(search_stok_kodu)>0 then Netsis_SQL=Netsis_SQL+"   AND Y.STOK_KODU LIKE '"&search_stok_kodu&"' "
if len(search_kod2)>0 then Netsis_SQL=Netsis_SQL+"   AND  G2.GRUP_ISIM LIKE '"&search_kod2&"' "
if len(search_stok_cari)>0 then Netsis_SQL=Netsis_SQL+"   AND C.CARI_ISIM LIKE '"&search_stok_cari&"' "
if len(search_grup_kodu)>0 then Netsis_SQL=Netsis_SQL+"   AND E.GRUP_KODU LIKE '"&search_grup_kodu&"' "

Netsis_SQL=Netsis_SQL+"ORDER BY 	Y.STHAR_TARIH , F.STHAR_TARIH "

                ' SQL ende            
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=10000
                        if sira=0 then                         %>
                            <thead><tr> <%
                            Response.Write("<th>Sıra</th>")
                            for each x in  NetsisRecordSet.Fields
                                Response.Write("<th>" & x.name & "</th>")
                            next                    %>
                            </tr></thead>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr><td>"&sira&"</td>")
                        for each x in  NetsisRecordSet.Fields
                            'Response.Write(x.name)
                            'Response.Write(" = ")
                            Response.Write("<td>" & x.value & "</td>")
                        next
                        NetsisRecordSet.MoveNext
                    loop
                    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=10000 then response.write ("<tr><td colspan=5>Max. 10000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>
        <%
        end if
        %>
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