<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<% BaslikHTML="Recete" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level' 
    if request.form("released")="on" then search_released ="checked" else search_released="" 
    if request.form("unreleased")="on" then search_unreleased ="checked" else search_unreleased="" 
    if url_doo<>"list" then 
    search_released ="checked"
    search_unreleased ="checked"

    end if
    search_madde_kodu = BeniKoddanArindir(temizle(request.form("search_madde_kodu")))
    search_madde_ad = BeniKoddanArindir(temizle(request.form("search_madde_ad")))
    search_madde = BeniKoddanArindir(temizle(request.form("search_madde"))) %> 
    <script type="text/javascript" src="include/xlsx.full.min.js"></script>
    <script type="text/javascript">
        function html_table_to_excel(type,str,str2) { // Excel
            var data = document.getElementById(str2);
            var file = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
            XLSX.write(file, { bookType: type, bookSST: true, type: 'base64' });
            XLSX.writeFile(file, str + '.' + type);
        }
    </script>
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
        <div class="container-fluid p-4"> <h3></h3>


            <form class="form-horizontal" method="POST" action="?doo=list">
                <div class="container-fluid p-4"><h4>Reçete Göster</h4> 
                    <div class="input-group">
                        <input class="form-control" type="text" name="search_madde_kodu" placeholder="Stok Kodu" value="<%=search_madde_kodu%>">
                        <input class="form-control" type="text" name="search_madde_ad" placeholder="Stok Adı" value="<%=search_madde_ad%>">
                        <input class="form-control" type="text" name="search_madde" placeholder="Madde" value="<%=search_madde%>">
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_released%> id="released" name="released" >
                                <label style="padding-left:5px;">Released</label>
                            </div>     
                            <div class="input-group-text">
                                <input class="form-check-input mt-0" type="checkbox" <%=search_unreleased%> id="unreleased" name="unreleased" >
                                <label style="padding-left:5px;">Unreleased</label>
                            </div>                                                    
                        <input class="btn btn-secondary" type="submit" name="B1" value="Ara">
                    </div>
                </div> 
            </form>  
            <%
            if url_doo="list" then 
                %>
                                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel eski</button>
                <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                <table class="table table-sm table-striped table-hover align-middle" id="tblData"> 
                                <thead><tr> 
                                <th>Sort_order</th>
                                <th>Level</th>
                                <th>Kod 5</th>
                                <th>Üretici Kodu</th>
                                <th>AB Code</th>
                                <th>AB Descriction</th>
                                <th>Reçete</th>
                                <th>Reç.açıklama</th>
                                <th>Item Code</th>
                                <th>Item Group</th>
                                <th>Item Description</th>
                                <th>QTY</th>
                                <th>Unit</th>
                                <th>Released</th>
                                <th>Supplier Code</th>
                                <th>AB Descriction EN</th> 
                                <th>Item Group EN</th>
                                <th>Item Description EN</th>
                                
                                </tr></thead> 
                            <%
                a1=Split(search_madde_kodu)
                for each search_madde_kodu2 in a1
                    ' SQL Rapor-CariStokEksik.asp
                        Netsis_SQL=" With Liste as ( "
                        Netsis_SQL=Netsis_SQL+" SELECT "
                        Netsis_SQL=Netsis_SQL+" CAST('_' + A.[OPNO] as varchar(250)) as SortOrder "
                        Netsis_SQL=Netsis_SQL+" ,CAST(1 AS INT) as LeveL "
                        Netsis_SQL=Netsis_SQL+" ,A.[MAMUL_KODU] "
                        Netsis_SQL=Netsis_SQL+" ,A.[HAM_KODU] "
                        Netsis_SQL=Netsis_SQL+" ,A.[MIKTAR] "
                        Netsis_SQL=Netsis_SQL+" ,A.[STOK_MALIYET] "
                        Netsis_SQL=Netsis_SQL+" ,CAST(A.[MAMUL_KODU] as varchar(250)) as agac "
                        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A "
                        Netsis_SQL=Netsis_SQL+" WHERE [GEC_FLAG]=0 "
                        Netsis_SQL=Netsis_SQL+" AND [MAMUL_KODU] like '"&search_madde_kodu2&"' "
                        Netsis_SQL=Netsis_SQL+" UNION ALL "
                        Netsis_SQL=Netsis_SQL+" SELECT "
                        Netsis_SQL=Netsis_SQL+" CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2 "
                        Netsis_SQL=Netsis_SQL+" , CAST(C.[LeveL]+1 as INT) as Level2 "
                        Netsis_SQL=Netsis_SQL+" ,B.[MAMUL_KODU] "
                        Netsis_SQL=Netsis_SQL+" ,B.[HAM_KODU] "
                        Netsis_SQL=Netsis_SQL+" ,B.[MIKTAR] "
                        Netsis_SQL=Netsis_SQL+" ,B.[STOK_MALIYET] "
                        Netsis_SQL=Netsis_SQL+" ,CAST(C.[agac] as varchar(250)) as agac2 "
                        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKURM] B "
                        Netsis_SQL=Netsis_SQL+" JOIN Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU] "
                        Netsis_SQL=Netsis_SQL+" WHERE [GEC_FLAG]=0 "
                        Netsis_SQL=Netsis_SQL+" ) "
                        Netsis_SQL=Netsis_SQL+" SELECT "
                        Netsis_SQL=Netsis_SQL+" Y.SortOrder as 'Sort_order' "
                        Netsis_SQL=Netsis_SQL+" ,Y.Level as 'Seviye' "
                        Netsis_SQL=Netsis_SQL+" ,E3.KOD_5 as 'Kod_5' "
                        Netsis_SQL=Netsis_SQL+" ,E3.URETICI_KODU as 'Üretici_kodu' "
                        Netsis_SQL=Netsis_SQL+" ,Y.agac as 'Ana_mamul' "
                        Netsis_SQL=Netsis_SQL+" ,E3.[STOK_ADI] as 'Mamül' "
                        Netsis_SQL=Netsis_SQL+" ,Y.[MAMUL_KODU] as 'Recete' "
                        Netsis_SQL=Netsis_SQL+" ,E2.[STOK_ADI] as 'Reçete açıklama' "
                        Netsis_SQL=Netsis_SQL+" ,Y.[HAM_KODU] as 'Madde_kodu' "
                        Netsis_SQL=Netsis_SQL+" ,G.[GRUP_ISIM] as 'Madde_grubu' "
                        Netsis_SQL=Netsis_SQL+" ,E.[STOK_ADI] as 'Stok_Adi' "
                        Netsis_SQL=Netsis_SQL+" ,Y.[MIKTAR] as 'Miktar' "
                        Netsis_SQL=Netsis_SQL+" ,E.[OLCU_BR1] as 'Br.' "
                        'Netsis_SQL=Netsis_SQL+" ,AX2.[DESCRIPTION] as 'Axapta_ad' "
                        Netsis_SQL=Netsis_SQL+" ,Y.[STOK_MALIYET] as 'Maliyet' " 
                        Netsis_SQL=Netsis_SQL+" ,E.[URETICI_KODU] as 'Üretici Kodu'"
                        Netsis_SQL=Netsis_SQL+" ,E3ek.[INGISIM] as 'Mamül_EN' "
                        Netsis_SQL=Netsis_SQL+" ,Gen.[ING] as 'Madde_grubu_EN' "
                        Netsis_SQL=Netsis_SQL+" ,Ek.[INGISIM] as 'Stok_EN' "
                        Netsis_SQL=Netsis_SQL+" from Liste Y "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E ON Y.[HAM_KODU]=E.[STOK_KODU] "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E2 ON Y.[MAMUL_KODU]=E2.[STOK_KODU] "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E3 ON Y.agac=E3.[STOK_KODU] "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] E3ek ON Y.agac=E3ek.[STOK_KODU] "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] Ek ON Y.HAM_KODU=Ek.[STOK_KODU] "
                         
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] G ON E.[KOD_1]=G.[GRUP_KOD] "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[PLT_KOD1_ENG] Gen ON E.[KOD_1]=Gen.[GRUP_KOD] "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] AX ON AX.ITEMID=Y.HAM_KODU "
                        Netsis_SQL=Netsis_SQL+" LEFT JOIN (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION] WHERE [LANGUAGEID]='en-us') AX2 ON AX2.[PRODUCT]=AX.[PRODUCT] "
                        Netsis_SQL=Netsis_SQL+" WHERE 1=1 "
                        ' madde adına göre ara
                            y=0
                            if len(search_madde_ad)=0 then search_madde_ad="%"
                            if instr(search_madde_ad," ") then 
                                Netsis_SQL=Netsis_SQL+" AND ("
                                a3=Split(search_madde_ad)
                                for each x in a3
                                    if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                    Netsis_SQL=Netsis_SQL+" E3.[STOK_ADI] LIKE '"+x+"'"
                                    y=1
                                next
                                Netsis_SQL=Netsis_SQL+") "
                            else
                            Netsis_SQL=Netsis_SQL+" AND E3.[STOK_ADI] LIKE '"&search_madde_ad&"' "
                            end if
                        ' end madde adına göre

                        ' madde koduna göre ara
                            y=0
                            if len(search_madde)>0 then 
                                if instr(search_madde," ") then 
                                    Netsis_SQL=Netsis_SQL+" AND ("
                                    a2=Split(search_madde)
                                    for each x in a2
                                        if y=1 then Netsis_SQL=Netsis_SQL+" OR "
                                        Netsis_SQL=Netsis_SQL+" Y.[HAM_KODU] LIKE '"+x+"'"
                                        y=1
                                    next
                                    Netsis_SQL=Netsis_SQL+") "
                                else
                                Netsis_SQL=Netsis_SQL+" AND Y.[HAM_KODU] LIKE '"&search_madde&"' "
                                end if
                            end if 
                        ' end madde koduna göre


                        if search_unreleased="checked" AND search_released="checked" then 
                            Netsis_SQL=Netsis_SQL+""
                        else
                            if search_unreleased="checked"  then Netsis_SQL=Netsis_SQL+" AND Y.[STOK_MALIYET]='M' "
                            if search_released="checked"  then Netsis_SQL=Netsis_SQL+" AND Y.[STOK_MALIYET]='S' "
                        end if


                        Netsis_SQL=Netsis_SQL+" ORDER BY Y.agac , SortOrder "
                    ' SQL ende
                    'Response.Write (Netsis_SQL)
                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                        sira=0 
                        do until NetsisRecordSet.EOF OR sira>=50000

                            sira=sira+1 
                            Response.Write(" <tr>")
                            for each x in NetsisRecordSet.Fields
                                'Response.Write(x.name) 
                                'Response.Write(" = ")
                                Response.Write("<td>") ' # karekteri exceli yarıda kesiyor
                                if len(x.value)>0 then Response.Write(Replace(x.value, "#", "&bull;")) ' # karekteri exceli yarıda kesiyor
                                Response.Write("</td>") ' # karekteri exceli yarıda kesiyor
                            next
                            NetsisRecordSet.MoveNext
                        loop
                        Response.Write(" </tr> ")
                    NetsisRecordSet.close
                next 
                    %> 
                </table> 
                <%
                if sira=0 then response.write ("Kayıt bulunamadı...") 
                if sira=50000 then response.write ("Max. 50000 kayıt görüntülendi.") 
            end if
            %>
        </div>
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
    <script>
let table = new DataTable('#tblData', {
    "lengthMenu": [[-1, 10, 20, 100], [ "All" ,10, 20, 100]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->