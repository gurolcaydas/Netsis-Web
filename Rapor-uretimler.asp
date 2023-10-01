<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Üretimler" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"p") then 'needed level'   
    search_aciklamasi = BeniKoddanArindir(request.form("search_aciklamasi"))
    search_grup_kodu = BeniKoddanArindir(request.form("search_grup_kodu"))
    search_tarih = BeniKoddanArindir(request.form("search_tarih")) 
    search_stok_kodu = BeniKoddanArindir(request.form("search_stok_kodu")) 
    search_siparis_no = BeniKoddanArindir(request.form("search_siparis_no")) 
    if request.form("detayli")="on" then search_detayli ="checked" else search_detayli=""  
    if request.form("tarihli")="on" then search_tarihli ="checked" else search_tarihli="" 
    if request.form("SKUlu")="on" then search_SKUlu ="checked" else search_SKUlu="" 
    if len(url_doo)=0 then 
        search_grup_kodu="FP1"
        search_tarihli="checked"
    end if

    %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h5>Aylara Göre</h5>
            <table class="table table-sm table-striped table-hover align-middle nowrap" id="aylik">         <%
                ' SQL   
                    Netsis_SQL= " SELECT * FROM (SELECT  "
                    Netsis_SQL=Netsis_SQL+" 	 MONTH( U.URETSON_TARIH) as Ayy "
                    Netsis_SQL=Netsis_SQL+" 	, SUM(U.URETSON_MIKTAR) as Toplam "
                    Netsis_SQL=Netsis_SQL+" FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].dbo.TBLSTSABIT S WITH (NOLOCK) ON S.Stok_kodu=U.URETSON_MAMUL "
                    Netsis_SQL=Netsis_SQL+" WHERE S.GRUP_KODU='FP1' "
                    Netsis_SQL=Netsis_SQL+" GROUP BY	 MONTH( U.URETSON_TARIH) ) AS S "
                    Netsis_SQL=Netsis_SQL+" PIVOT (sum(Toplam) FOR Ayy IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS P  "
                ' SQL ende            
                'Response.Write (Netsis_SQL)
                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=10000
                        if sira=0 then                         %>
                            <thead><tr> <%
                            for each x in  NetsisRecordSet.Fields
                                Response.Write("<th>" & x.name & "</th>")
                            next                    %>
                            </tr></thead>  <%
                        end if 
                        sira=sira+1      
                        Response.Write(" <tr>")
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
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>Üretimler</h3>
                        <div class="input-group">
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_tarihli%> id="tarihli" name="tarihli" >
                                <label style="padding-left:5px;">Tarihli</label>
                            </div>                        
                            <input class="form-control" type="date" name="search_tarih"  placeholder="Tarih"  value="<%=search_tarih%>">
                            <input class="form-control" type="text" name="search_grup_kodu"  placeholder="Grup Kodu (FP1 CO1 PA1 NS1)"  value="<%=search_grup_kodu%>">
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_SKUlu%> id="SKUlu" name="SKUlu" >
                            </div>                            
                            <input class="form-control" type="text" name="search_stok_kodu"  placeholder="Stok Kodu"  value="<%=search_stok_kodu%>">
                            <input class="form-control" type="text" name="search_aciklamasi"  placeholder="Stok Açıklaması"  value="<%=search_aciklamasi%>">
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_detayli%> id="detayli" name="detayli" >
                            </div>                            
                            <input class="form-control" type="text" name="search_siparis_no"  placeholder="Sipariş No"  value="<%=search_siparis_no%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
    <%
    if len(search_stok_kodu&search_aciklamasi&search_siparis_no&search_grup_kodu)>0 then 
    %>
        <div class="container-fluid p-4"> 
        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>

            <table class="table table-sm table-striped table-hover align-middle nowrap" id="tblData">         <%
                ' SQL   



Netsis_SQL="SELECT  "
if search_tarihli ="checked" then 
    Netsis_SQL=Netsis_SQL+"	U.URETSON_TARIH as 'Tarih' ,"
end if 
Netsis_SQL=Netsis_SQL+" S.GRUP_KODU 'Tip' "
if search_SKUlu ="checked" then 
    Netsis_SQL=Netsis_SQL+"	, U.URETSON_MAMUL as 'SKU' "
    Netsis_SQL=Netsis_SQL+"	, S.STOK_ADI 'Açıklama' "
end if 


Netsis_SQL=Netsis_SQL+"	, SUM(U.URETSON_MIKTAR) as 'Teslim Miktarı' "
if search_detayli ="checked" then 
    Netsis_SQL=Netsis_SQL+"	, U.URETSON_SIPNO  as 'Sipariş No' "
end if
Netsis_SQL=Netsis_SQL+"FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) "
Netsis_SQL=Netsis_SQL+"LEFT JOIN ["+currentDB+"].dbo.TBLSTSABIT S WITH (NOLOCK) ON S.Stok_kodu=U.URETSON_MAMUL "
Netsis_SQL=Netsis_SQL+"WHERE 1=1 "

if LEN(search_tarih)>0  then Netsis_SQL=Netsis_SQL+"   AND U.URETSON_TARIH ='"&search_tarih&"'"
if len(search_stok_kodu)>0 then Netsis_SQL=Netsis_SQL+"   AND U.URETSON_MAMUL LIKE '"&search_stok_kodu&"' "
if len(search_aciklamasi)>0 then Netsis_SQL=Netsis_SQL+"   AND  S.STOK_ADI LIKE '"&search_aciklamasi&"' "
if search_detayli ="checked" then 
    if len(search_siparis_no)>0 then Netsis_SQL=Netsis_SQL+"   AND U.URETSON_SIPNO LIKE '"&search_siparis_no&"' "
end if  
if len(search_grup_kodu)>0 then Netsis_SQL=Netsis_SQL+"   AND S.GRUP_KODU LIKE '"&search_grup_kodu&"' "

Netsis_SQL=Netsis_SQL+"GROUP BY	S.GRUP_KODU "
if search_SKUlu ="checked" then Netsis_SQL=Netsis_SQL+",U.URETSON_MAMUL , S.STOK_ADI "
if search_tarihli ="checked" then Netsis_SQL=Netsis_SQL+", U.URETSON_TARIH "
if search_detayli ="checked" then Netsis_SQL=Netsis_SQL+", U.URETSON_SIPNO "
if search_tarihli ="checked" then Netsis_SQL=Netsis_SQL+"ORDER BY	U.URETSON_TARIH DESC "

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
                            if x.name="Tarih" then
                            Response.Write("<td>" & formatdatetime(x.value,1) & "</td>")
                            else
                            Response.Write("<td>" & x.value & "</td>")
                            end if
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