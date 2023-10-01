<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="BoM"  
%> 
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->    
    <script type="text/javascript" src="include/xlsx.full.min.js"></script>
    <script type="text/javascript">
        function html_table_to_excel(type,str,str2) { // Excel
            var data = document.getElementById(str2);
            var file = XLSX.utils.table_to_book(data, {sheet: "sheet1"});
            XLSX.write(file, { bookType: type, bookSST: true, type: 'base64' });
            XLSX.writeFile(file, str + '.' + type);
        }
    </script> 
    <%
        if instr(UserLevel,"u") then 'needed level'' view &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'            %>         
            <div class="container-fluid" style="margin-top:80px"> <%
                if url_function="view" or  url_function="" then
                    %>
                    <!-- #include file="./subs/dbcon.asp" -->
                    <%
                    search_bisiklet = BeniKoddanArindir(request.form("search_bisiklet"))
                    search_bisiklet_kodu = BeniKoddanArindir(request.form("search_bisiklet_kodu"))
                    search_uretici_kodu = BeniKoddanArindir(request.form("search_uretici_kodu"))
                    search_madde_kodu = BeniKoddanArindir(request.form("search_madde_kodu"))
                    search_Accell_kodu = BeniKoddanArindir(request.form("search_Accell_kodu"))
                    search_madde_kodu1 = BeniKoddanArindir(request.form("search_madde_kodu1"))
                    search_grup_kodu = BeniKoddanArindir(request.form("search_grup_kodu"))
                    ' sayfa = request.querystring("sayfa")
                    ' if sayfa=0 then sayfa=1
                    ' sSayfa=cint(sayfa)                    
                    ' arama1=""
                    if len(search_uretici_kodu)=0 then     search_uretici_kodu =  request.querystring("search_uretici_kodu")
                    if len(search_bisiklet_kodu)=0 then     search_bisiklet_kodu =  request.querystring("search_bisiklet_kodu") 
                    if len(search_bisiklet)=0 then          search_bisiklet =       request.querystring("search_bisiklet")
                    if len(search_grup_kodu)=0 then         search_grup_kodu =      request.querystring("search_grup_kodu")
                    if len(search_madde_kodu)=0 then        search_madde_kodu =     request.querystring("search_madde_kodu")
                    if len(search_Accell_kodu)=0 then        search_Accell_kodu =     request.querystring("search_Accell_kodu")
                    if len(search_madde_kodu1)=0 then        search_madde_kodu1 =     request.querystring("search_madde_kodu1")
                    ' if len(search_bisiklet_kodu)>0 then     arama1=arama1+"&search_bisiklet_kodu=" &    search_bisiklet_kodu
                    ' if len(search_bisiklet)>0 then          arama1=arama1+"&search_bisiklet=" &         search_bisiklet
                    ' if len(search_grup_kodu)>0 then         arama1=arama1+"&search_grup_kodu=" &        search_grup_kodu
                    ' if len(search_madde_kodu)>0 then        arama1=arama1+"&search_madde_kodu=" &       search_madde_kodu
                    ' if len(search_madde_kodu1)>0 then        arama1=arama1+"&search_madde_kodu1=" &       search_madde_kodu1

                    if url_doo="" or url_doo="bikelist" then
                        %>                                 
                            <form method="POST" action="?doo=bikelist">
                                <div class="container-fluid p-4"><strong>Reçeteler ve ilk maddeler</strong>         
                                    <div class="input-group">
                                        <input class="form-control" type="text" name="search_bisiklet_kodu" placeholder="Stok Kodu"  value="<%=search_bisiklet_kodu%>">
                                        <input class="form-control" type="text" name="search_bisiklet"  placeholder="Açıklama"  value="<%=search_bisiklet%>">
                                        <input class="form-control" type="text" name="search_grup_kodu"  placeholder="FP1/CO1" value="<%=search_grup_kodu%>">
                                        <input class="form-control" type="text" name="search_madde_kodu1"  placeholder="Kod 1" value="<%=search_madde_kodu1%>">
                                        <input class="form-control" type="text" name="search_madde_kodu"  placeholder="Kod 2" value="<%=search_madde_kodu%>">
                                        <input class="form-control" type="text" name="search_Accell_kodu"  placeholder="Global Article Code" value="<%=search_Accell_kodu%>">
                                        <input class="form-control" type="text" name="search_uretici_kodu"  placeholder="Üretici Kodu" value="<%=search_uretici_kodu%>">
                                        <input class="btn btn-secondary" type="submit"  name="B1" value="Listele">
                                    </div>
                        <%
                    end if

                    if url_doo="bikelist" and (search_bisiklet_kodu&search_grup_kodu&search_madde_kodu&search_bisiklet&search_uretici_kodu&search_madde_kodu1&search_Accell_kodu<>"") then 'alanlar boş ise sakın arama'


                         ' SQL
                            Netsis_SQL=" SELECT " 
                            Netsis_SQL=Netsis_SQL+" A.[STOK_KODU] " 
                            Netsis_SQL=Netsis_SQL+" ,A.[STOK_ADI] " 
                            Netsis_SQL=Netsis_SQL+" ,A.[URETICI_KODU] " 
                            Netsis_SQL=Netsis_SQL+" ,A.[GRUP_KODU] " 
                            Netsis_SQL=Netsis_SQL+" ,B1.[GRUP_ISIM] AS KOD1 " 
                            Netsis_SQL=Netsis_SQL+" ,B2.[GRUP_ISIM] AS KOD2 " 
                            Netsis_SQL=Netsis_SQL+" ,B3.[GRUP_ISIM] AS KOD3 " 
                            Netsis_SQL=Netsis_SQL+" ,B4.[GRUP_ISIM] AS KOD4 " 
                            Netsis_SQL=Netsis_SQL+" ,EK.[KULL8S] AS GlobalCode " 
                            Netsis_SQL=Netsis_SQL+" ,A.KOD_5 AS KOD5 " 
                            Netsis_SQL=Netsis_SQL+" ,Z.Toplam " 
                            Netsis_SQL=Netsis_SQL+" ,Z2.Toplam2 " 
                            Netsis_SQL=Netsis_SQL+" ,ST.[TOP_GIRIS_MIK] as 'GirisS1' "
                            Netsis_SQL=Netsis_SQL+" ,ST.[TOP_CIKIS_MIK] as 'CikisS1' "
                            Netsis_SQL=Netsis_SQL+" ,ST2.[TOP_GIRIS_MIK] as 'GirisS2' "
                            Netsis_SQL=Netsis_SQL+" ,ST2.[TOP_CIKIS_MIK] as 'CikisS2' "
                            Netsis_SQL=Netsis_SQL+" ,ST3.[TOP_GIRIS_MIK] as 'GirisS3' "
                            Netsis_SQL=Netsis_SQL+" ,ST3.[TOP_CIKIS_MIK] as 'CikisS3' "
                            Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A  with (NOLOCK) " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] EK  with (NOLOCK) ON EK.[STOK_KODU]=A.STOK_KODU "                            
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] B1  with (NOLOCK) ON [KOD_1]=B1.[GRUP_KOD] " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2  with (NOLOCK) ON [KOD_2]=B2.[GRUP_KOD] " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD3] B3  with (NOLOCK) ON [KOD_3]=B3.[GRUP_KOD] " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] B4  with (NOLOCK) ON [KOD_4]=B4.[GRUP_KOD] " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD5] B5  with (NOLOCK) ON [KOD_5]=B5.[GRUP_KOD] " 
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKPH] ST  with (NOLOCK) ON ST.[STOK_KODU]=A.STOK_KODU AND ST.[SUBE_KODU]=1 and ST.[DEPO_KODU]=0"                            
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKPH] ST2  with (NOLOCK) ON ST2.[STOK_KODU]=A.STOK_KODU AND ST2.[SUBE_KODU]=2 and ST2.[DEPO_KODU]=0"                            
                            Netsis_SQL = Netsis_SQL + "		LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKPH] ST3 ON ST3.[STOK_KODU]=A.STOK_KODU AND ( ST3.[SUBE_KODU]=1 OR  ST3.[SUBE_KODU]=2) and  (ST3.[DEPO_KODU]=101 OR ST3.[DEPO_KODU]=66  )  "
                            Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT COUNT(*) as toplam FROM ["+currentDB+"].[dbo].[TBLSTOKURM]  with (NOLOCK) WHERE [MAMUL_KODU]=A.[STOK_KODU] AND GEC_FLAG=0) Z " 
                            Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT COUNT(*) as toplam2 FROM ["+currentDB+"].[dbo].[TBLSTOKURM]  with (NOLOCK) WHERE [HAM_KODU]=A.[STOK_KODU] AND GEC_FLAG=0) Z2 " 
                            Netsis_SQL=Netsis_SQL+" WHERE 1=1 "

                            if len(search_uretici_kodu)>0 then     
                                if instr(search_uretici_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND A.[URETICI_KODU] LIKE '" &search_uretici_kodu&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND A.[URETICI_KODU] LIKE '%" &search_uretici_kodu&"%' " 
                                end if 
                            end if 
                            if len(search_bisiklet_kodu)>0 then     
                                if instr(search_bisiklet_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND A.[STOK_KODU] LIKE '" &search_bisiklet_kodu&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND A.[STOK_KODU] LIKE '%" &search_bisiklet_kodu&"%' " 
                                end if 
                            end if 
                            if len(search_bisiklet)>0 then     
                                if instr(search_bisiklet,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND A.[STOK_ADI] LIKE '" &search_bisiklet&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND A.[STOK_ADI] LIKE '%" &search_bisiklet&"%' " 
                                end if 
                            end if 
                            if len(search_grup_kodu)>0 then     
                                if instr(search_grup_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND A.[GRUP_KODU] LIKE '" &search_grup_kodu&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND A.[GRUP_KODU] LIKE '%" &search_grup_kodu&"%' " 
                                end if 
                            end if 



                            if len(search_Accell_kodu)>0 then     
                                if instr(search_Accell_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND EK.[KULL8S] LIKE '" &search_Accell_kodu&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND EK.[KULL8S] LIKE '%" &search_Accell_kodu&"%' " 
                                end if 
                            end if                             
                            if len(search_madde_kodu)>0 then     
                                if instr(search_madde_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND B2.[GRUP_ISIM] LIKE '" &search_madde_kodu&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND B2.[GRUP_ISIM] LIKE '%" &search_madde_kodu&"%' " 
                                end if 
                            end if 
                            if len(search_madde_kodu1)>0 then     
                                if instr(search_madde_kodu1,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                                    Netsis_SQL=Netsis_SQL+" AND B1.[GRUP_ISIM] LIKE '" &search_madde_kodu1&"' " 
                                else 
                                    Netsis_SQL=Netsis_SQL+" AND B1.[GRUP_ISIM] LIKE '%" &search_madde_kodu1&"%' " 
                                end if 
                            end if 

                            Netsis_SQL=Netsis_SQL+" ORDER BY A.[STOK_KODU],A.[GRUP_KODU],B1.[GRUP_ISIM],B2.[GRUP_ISIM],A.[STOK_ADI] " 
                        ' SQL ende

                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1  
                        %>
                                </div>
                            </form>
               
                            <div class="table-responsive p-4">   
                        <button class="btn btn-success m-2" onclick="html_table_to_excel('xlsx','filename','tblBikeList')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>                           
                                <table class="table table-sm table-striped table-hover align-middle nowrap" id="tblBikeList">
                                    <thead>
                                    <tr>
                                        <th  style="text-align:center;">#</th>
                                        <th  style="text-align:center;">Kod_</th>
                                        <th  style="text-align:center;">BoM</th>
                                        <th  style="text-align:center;">SKU</th>
                                        <th  style="text-align:center;">Açıklama</th>
                                        <th style="text-align:center;">Grup</th>
                                        <th style="text-align:center;">Stok</th>
                                        <%
                                        if instr(UserLevel,"s") then
                                        %>
                                        <th style="text-align:center;">Stok(P&A)</th>
                                        <th style="text-align:center;" title="Kontrol ve Karantina depo">Stok(K&K)</th>
                                        <%
                                        end if
                                        %>
                                        <th style="text-align:center;">Kod1</th>
                                        <th style="text-align:center;">Kod2</th>
                                        <th style="text-align:center;">Kod3</th>
                                        <th style="text-align:center;">Kod4</th>
                                        <th style="text-align:center;">Kod5</th>
                                        <th style="text-align:center;">Global Code</th>
                                        <th style="text-align:center;">Üretici Kodu</th>
                                    </tr>
                                    </thead><tbody>
                                    <%
                                    sira=0 
                                    do until NetsisRecordSet.EOF OR sira>=5000
                                        sira=sira+1                            
                                        response.write("<tr>")
                                        response.write("<td>"&sira&"</td>")
                                        response.write("<td>"&replace(NetsisRecordSet("STOK_KODU"),search_bisiklet_kodu,"<mark>"&search_bisiklet_kodu&"</mark>",1,-1,1)&"</td>")
                                        if NetsisRecordSet("Toplam")>0 then  %>
                                            <td class="pr-0 text-right">
                                                <a  href="?doo=bomlist&item=<%=NetsisRecordSet("STOK_KODU")%>" title="Ürün Ağacı" >
                                                <div class="badge badge-pill bg-primary">
                                                    <i class="bi bi-journal-text"></i> <%=NetsisRecordSet("Toplam")%>
                                                </div></a> 
                                            </td> <%
                                        else
                                            response.write("<td>")
                                            response.write("</td>")
                                        end if  %>
                                            <td class="pr-0 text-right">
                                                <a  href="?doo=kullanimyeri&item=<%=NetsisRecordSet("STOK_KODU")%>" title="Stok kartı detayları / Kullanıldığı yerler" >                                  
                                             <%                                                       
                                            if NetsisRecordSet("GRUP_KODU")="FP1" then   %>
                                                                             
                                                <div class="badge badge-pill bg-success">
                                                    <i class="bi bi-bicycle"></i>
                                                </div>  <%

                                            else %>
                                                <div class="badge badge-pill bg-warning">
                                                <i class="bi bi-search"></i> <%=NetsisRecordSet("Toplam2")%>
                                                </div> <%

                                            end if  %>
                                            </a> </td>   <%         
                                   
                                        response.write("<td>")
                                        if len(search_bisiklet)>0 then response.write(replace(NetsisRecordSet("STOK_ADI"),search_bisiklet,"<mark>"&search_bisiklet&"</mark>",1,-1,1)) else response.write(NetsisRecordSet("STOK_ADI"))
                                        response.write("</td>")
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("GRUP_KODU"))
                                        response.write("</td>")
                                        if ISNULL(NetsisRecordSet("GirisS3")) OR ISNULL(NetsisRecordSet("CikisS3")) then bakiyeKontrolDepo=0 else  bakiyeKontrolDepo=CDbl(NetsisRecordSet("GirisS3"))-CDbl(NetsisRecordSet("CikisS3"))
                                        if ISNULL(NetsisRecordSet("GirisS1")) OR ISNULL(NetsisRecordSet("CikisS1")) then bakiye=0 else  bakiye=CDbl(NetsisRecordSet("GirisS1"))-CDbl(NetsisRecordSet("CikisS1"))-bakiyeKontrolDepo
                                        response.write("<td style='text-align:center;'>"&bakiye&"</td>")
                                        if instr(UserLevel,"s") then 
                                            if ISNULL(NetsisRecordSet("GirisS2")) OR ISNULL(NetsisRecordSet("CikisS2")) then bakiye2=0 else  bakiye2=CDbl(NetsisRecordSet("GirisS2"))-CDbl(NetsisRecordSet("CikisS2"))
                                            response.write("<td style='text-align:center;'>"&bakiye2&"</td>")
                                            response.write ("<td style='text-align:center;'  title='Kontrol ve Karantina depo'><span class='bg-secondary'>("&bakiyeKontrolDepo&")</span></td>")
                                        end if
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("KOD1")&"</td>")
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("KOD2")&"</td>")
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("KOD3")&"</td>")
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("KOD4")&"</td>")
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("KOD5")&"</td>")
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("GlobalCode")&"</td>")                                        
                                        response.write("<td style='text-align:center;'>"&NetsisRecordSet("URETICI_KODU")&"</td></tr>")
                                        NetsisRecordSet.movenext
                                    Loop
                                    %>
                                </tbody></table>
                            </div>                    <%
                        NetsisRecordSet.close                   
                    end if 

                    if url_doo="bomlist" then  %>
                        <div class="list-group"> <%
                                ' SQL
                                    Netsis_SQL="SELECT "
                                    Netsis_SQL=Netsis_SQL +" A.[STOK_KODU] "
                                    Netsis_SQL=Netsis_SQL +" ,[URETICI_KODU] "
                                    Netsis_SQL=Netsis_SQL +" ,[STOK_ADI] "
                                    Netsis_SQL=Netsis_SQL +" ,[GRUP_KODU] "
                                    Netsis_SQL=Netsis_SQL +" ,[DEPO_KODU]"
                                    Netsis_SQL=Netsis_SQL +" ,[OLCU_BR1] "
                                    Netsis_SQL=Netsis_SQL +" ,[OLCU_BR2] "
                                    Netsis_SQL=Netsis_SQL +" ,[OLCU_BR3] "
                                    Netsis_SQL=Netsis_SQL +" ,[PAY_1] "
                                    Netsis_SQL=Netsis_SQL +" ,[PAYDA_1] "
                                    Netsis_SQL=Netsis_SQL +" ,[PAY2] "
                                    Netsis_SQL=Netsis_SQL +" ,[PAYDA2] "
                                    Netsis_SQL=Netsis_SQL +" ,B1.[GRUP_ISIM] AS KOD1 "
                                    Netsis_SQL=Netsis_SQL +" ,B2.[GRUP_ISIM] AS KOD2 "
                                    Netsis_SQL=Netsis_SQL +" ,B3.[GRUP_ISIM] AS KOD3 "
                                    Netsis_SQL=Netsis_SQL +" ,B4.[GRUP_ISIM] AS KOD4 "
                                    Netsis_SQL=Netsis_SQL +" ,A.KOD_5 AS KOD5 "
                                    Netsis_SQL=Netsis_SQL +" ,A2.[INGISIM] "
                                    Netsis_SQL=Netsis_SQL +" ,A2.[KAYITTARIHI] "
                                    Netsis_SQL=Netsis_SQL +" ,A2.[KAYITYAPANKUL] "
                                    Netsis_SQL=Netsis_SQL +" ,A2.[DUZELTMETARIHI] "
                                    Netsis_SQL=Netsis_SQL +" ,A2.[DUZELTMEYAPANKUL] "
                                    Netsis_SQL=Netsis_SQL +" ,C1.[AX_STOKBILGISI_1_TR] as ESKITR"
                                    Netsis_SQL=Netsis_SQL +" ,C1.[AX_STOKBILGISI_2_EN] as ESKIEN"
                                    
                                    Netsis_SQL=Netsis_SQL +" ,C2.[BILGI] as ESKITR2"
                                    Netsis_SQL=Netsis_SQL +" FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A with (NOLOCK) "
                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2  with (NOLOCK) ON A.[STOK_KODU]=A2.[STOK_KODU] "
                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] B1  with (NOLOCK) ON [KOD_1]=B1.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2  with (NOLOCK) ON [KOD_2]=B2.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD3] B3  with (NOLOCK) ON [KOD_3]=B3.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] B4  with (NOLOCK) ON [KOD_4]=B4.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD5] B5  with (NOLOCK) ON [KOD_5]=B5.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[GRL_STOKACIK] C1  with (NOLOCK) ON A.[STOK_KODU]=C1.[Kod] "

                                    Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKBIL]  C2  with (NOLOCK) ON A.[STOK_KODU]=C2.[STOK_KODU] "                                    
                                    Netsis_SQL=Netsis_SQL +" WHERE A.[STOK_KODU]='"&url_item&"' "
                                ' SQL ende
                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                say=0                          %>
                                <div class="list-group">      <!-- Bomlist Reçete -->                
                                    <div class="container-fluid p-4"><h5 class="d-print-none">Reçete Ara</h5>
                                        <form method='get'>
                                            <div class="input-group mb-3 d-print-none">  
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text bg-primary text-white">Madde Kodu:</span>
                                                </div>
                                                <input type='hidden' name='doo' value='bomlist'>          
                                                <input type="text" class="form-control" name='item' value='<%=url_item%>'  placeholder="SKU#" aria-label="SKU#" aria-describedby="button-addon2">
                                                <button class="btn btn-secondary"  type="submit"  name="B1"  id="button-addon2">Ara</button>
                                            </div>                                  
                                        </form> 
                                    </div>
                                    <div class="container-fluid p-4"> <!-- Künye -->
                                        <h2><%=url_item%></h2> <%
                                        do until NetsisRecordSet.EOF OR say=1
                                            say=1        %>
                                                <ol class="list-group list-group-horizontal  pt-1">
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'  >
                                                    <div class='ms-2 me-auto'>Grup Kodu<div class='fw-bold'><%=NetsisRecordSet("GRUP_KODU")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 1<div class='fw-bold'><%=NetsisRecordSet("KOD1")%> <span><%=cizimlink%></span></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 2<div class='fw-bold'><%=NetsisRecordSet("KOD2")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 3<div class='fw-bold'><%=NetsisRecordSet("KOD3")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 4<div class='fw-bold'><%=NetsisRecordSet("KOD4")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 5<div class='fw-bold'><%=NetsisRecordSet("KOD5")%></div></div></li>                   

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'>
                                                    <div class='ms-2 me-auto'>Üretici Kodu<div class='fw-bold'><%=NetsisRecordSet("URETICI_KODU")%></div>
                                                    </div></li>
                                                </ol>
                                                <ol class="list-group pt-1">
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-success align-items-start'>
                                                    <div class='ms-2 me-auto'>Stok Adı
                                                        <div class='fw-bold h5'><%=NetsisRecordSet("STOK_ADI")%>
                                                            <a  href="?doo=kullanimyeri&item=<%=url_item%>" title="Kullanıldığı Yerler" >
                                                                <div class="badge badge-pill bg-warning">
                                                                    <i class="bi bi-search"></i> 
                                                                </div>
                                                            </a> 
                                                        </div>                                                     
                                                    <div class=''><%=NetsisRecordSet("INGISIM")%></div> 
                                                    <hr><div class=''>
                                                    <%
                                                    if LEN(NetsisRecordSet("ESKITR2"))>0 then  response.write(Replace(NetsisRecordSet("ESKITR2"),vbCrLf, "<br/>"))
                                                    %>
                                                    
                                                    </div></div>
                                                    <div class='ms-2 me-auto'>
                                                        <% if instr(UserLevel,"m") then 'stok kartı database görüntüsü &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'            %>         
                                                            <div class="badge badge-pill bg-success" data-bs-toggle="modal" data-bs-target="#exampleModal2" onclick="showStokKart('<%=url_item%>')">
                                                                <i class="bi bi-arrows-fullscreen"></i>
                                                            </div>
                                                            <!-- Modal -->     
                                                            <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModal2Label" aria-hidden="true">
                                                                <div class="modal-dialog modal-xl">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title"  id="fiyatlarbaslik2"></h5>
                                                                        </div>
                                                                        <div class="modal-body" id="fiyatlar2">
                                                                            ...
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>                                                        
                                                        <% end if %>
                                                    <div class='small'>Rec: &nbsp;<%=NetsisRecordSet("KAYITTARIHI")%>&nbsp;<%=NetsisRecordSet("KAYITYAPANKUL")%></div>
                                                    <div class='small'>Edit:&nbsp;<%=NetsisRecordSet("DUZELTMETARIHI")%>&nbsp;<%=NetsisRecordSet("DUZELTMEYAPANKUL")%></div></div>
                                                    </li>
                                                </ol>      
                                                <ol class="list-group list-group-horizontal pt-1" >                                               

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Depo<div class='fw-bold'><%=NetsisRecordSet("DEPO_KODU")%></div></div></li>                   

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Ölçü Birimleri<div><strong>
                                                    <%
                                                    response.write( NetsisRecordSet("OLCU_BR1")&"</strong> ")
                                                    if len(NetsisRecordSet("OLCU_BR2"))>0 then response.write( "= "&NetsisRecordSet("PAY_1")&"/"&NetsisRecordSet("PAYDA_1")&" "&NetsisRecordSet("OLCU_BR2") )
                                                    if len(NetsisRecordSet("OLCU_BR3"))>0 then response.write( "= "&NetsisRecordSet("PAY2")&"/"&NetsisRecordSet("PAYDA2")&" "&NetsisRecordSet("OLCU_BR3") )
                                                    
                                                    %></div></div></li>          
                                                    
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>-<div class='fw-bold'> </div></div></li>                   

            
                                                </ol>     <%
                                        Loop       %>
                                    </div>
                                </div>                        <% ' bomlist reçete
                            NetsisRecordSet.close
                            if say=0 and url_item<>"" then Response.Redirect "NetsisBom.asp?doo=bikelist&search_bisiklet_kodu=" & url_item                %>
                        </div>
                        <div class="container-fluid p-4">  <!-- bomlist iş emri -->
                            <h2><%=url_item%></h2>  

                            <table class="table table-sm table-striped table-hover align-middle"> <% ' *************************************** üretim emri reçete [TBLSTOKURS]??  <--> [TBLSTOKURM] Reçete'
                                ' SQL
                                    Netsis_SQL= " With Liste as ( "
                                    Netsis_SQL=Netsis_SQL+" SELECT "
                                    Netsis_SQL=Netsis_SQL+" CAST(A.[OPNO] as varchar(250)) as SortOrder "
                                    Netsis_SQL=Netsis_SQL+" ,CAST(1 AS INT) as LeveL "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,A.[HAM_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MIKTAR] "
                                    Netsis_SQL=Netsis_SQL+" ,A.[STOK_MALIYET] "
        
                                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKURM] A  with (NOLOCK) "
                                    Netsis_SQL=Netsis_SQL+" WHERE A.[MAMUL_KODU]='"&url_item&"' AND A.[GEC_FLAG]=0"
                                    Netsis_SQL=Netsis_SQL+" "
                                    Netsis_SQL=Netsis_SQL+" UNION ALL "
                                    Netsis_SQL=Netsis_SQL+" "
                                    Netsis_SQL=Netsis_SQL+" SELECT "
                                    Netsis_SQL=Netsis_SQL+" CAST(C.[SortOrder] +'.'+ B.[OPNO] as varchar(250)) as Sort2 "
                                    Netsis_SQL=Netsis_SQL+" , CAST(C.[LeveL]+1 as INT) as Level2 "
                                    Netsis_SQL=Netsis_SQL+" ,B.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,B.[HAM_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,B.[MIKTAR] "
                                    Netsis_SQL=Netsis_SQL+" ,B.[STOK_MALIYET] "
                                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKURM] B  with (NOLOCK) "
                                    Netsis_SQL=Netsis_SQL+" "
                                    Netsis_SQL=Netsis_SQL+" Join Liste as C on C.[HAM_KODU] = B.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" WHERE B.[GEC_FLAG]=0"
                                    Netsis_SQL=Netsis_SQL+" ) "
                                    Netsis_SQL=Netsis_SQL+" Select Y.SortOrder "
                                    Netsis_SQL=Netsis_SQL+" ,Y.Level "
                                    Netsis_SQL=Netsis_SQL+" ,Y.[MAMUL_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,Y.[HAM_KODU] "
                                    Netsis_SQL=Netsis_SQL+" ,G.[GRUP_ISIM] "
                                    Netsis_SQL=Netsis_SQL+" ,E.[STOK_ADI] "
                                    Netsis_SQL=Netsis_SQL+" ,Y.[MIKTAR] "
                                    Netsis_SQL=Netsis_SQL+" ,E.[OLCU_BR1] "
                                    Netsis_SQL=Netsis_SQL+" ,K.[GRUP_ISIM] as 'Tedarikci' "
                                    Netsis_SQL=Netsis_SQL+" ,Z.[FIYAT1] "
                                    Netsis_SQL=Netsis_SQL+" ,Z.[FIYATDOVIZTIPI] "
                                    Netsis_SQL=Netsis_SQL+" ,Z.[OLCUBR] "
                                    Netsis_SQL=Netsis_SQL+" ,J.[OPKODU] as 'Operasyon_kodu' "
                                    Netsis_SQL=Netsis_SQL+" ,J.[OPISIM] as 'Operasyon' "
                                    Netsis_SQL=Netsis_SQL+" ,J.[OPMIK] as 'Operasyon_miktar' "
                                    Netsis_SQL=Netsis_SQL+" ,H.[MIKTAR] as 'Alt_Urun' " 
                                    Netsis_SQL=Netsis_SQL+" ,Y.[STOK_MALIYET] as 'Maliyet' " 
                                    Netsis_SQL=Netsis_SQL+" from Liste Y "
                                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP 1 [FIYAT1],[FIYATDOVIZTIPI],[OLCUBR] FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT]  with (NOLOCK) WHERE Y.HAM_KODU=[STOKKODU] ORDER BY [BASTAR] DESC) Z "
                                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP 1 [MIKTAR] FROM ["+currentDB+"].[dbo].[TBLSTOKURM]  with (NOLOCK) WHERE Y.[HAM_KODU]=[MAMUL_KODU] ) H "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E  with (NOLOCK) ON Y.[HAM_KODU]=E.[STOK_KODU] "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLOPERATIONS_KATALOG] J  with (NOLOCK) ON Y.[HAM_KODU]=J.[OPKODU] "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] K  with (NOLOCK) ON E.[KOD_2]=K.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] G  with (NOLOCK) ON E.[KOD_1]=G.[GRUP_KOD] "
                                    Netsis_SQL=Netsis_SQL+" ORDER BY SortOrder "
                                ' SQL ende
                                sira=0
                                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1                        
                                    do until NetsisRecordSet.EOF
                                        if sira=0 then %>
                                            <thead><tr>
                                                <th>Sıra</th>
                                                <th colspan=5>Kod</th>
                                                <th colspan=1>Stok Adı</th>
                                                <th colspan=2>Kod 2</th>
                                                <th colspan=2>Miktar</th>
                                                <th colspan=1></th>
                                            </tr></thead>                                 <%
                                        end if
                                        Sira=sira+1                      
                                        renkli=" class='text-danger' "
                                        Select Case NetsisRecordSet("LeveL")
                                        Case 1
                                        renkli=" class='text-danger' "      
                                        Case 2
                                        renkli=" class='text-secondary' "
                                        Case 3
                                        renkli=" class='text-success' "                                          
                                        Case 4
                                        renkli=" class='text-primary' "
                                        end Select  
                                        response.write("<tr>")  
                                            response.write(" <td>"&Sira&"</td>")
                                            response.write(" <td " & renkli & " >")
                                                for i=1 to (NetsisRecordSet("Level")-1)*3
                                                    response.write("&nbsp;")
                                                next
                                            response.write("<b>"&NetsisRecordSet("HAM_Kodu")&"</b></td>")
                                            if NetsisRecordSet("Alt_Urun") then %>
                                                <td class="pr-0 text-right">
                                                    <a  href="?doo=bomlist&item=<%=NetsisRecordSet("HAM_Kodu")%>" title="Ürün Ağacı <%=NetsisRecordSet("HAM_Kodu")%>" >
                                                        <div class="badge badge-pill bg-primary">
                                                            <i class="bi bi-journal-text"></i> 
                                                        </div>
                                                    </a> 
                                                </td>    <%
                                            else 
                                                response.write("<td></td>")                            
                                            end if %>
                                                <td class="pr-0 text-right">
                                                    <a  href="?doo=kullanimyeri&item=<%=NetsisRecordSet("HAM_Kodu")%>" title="Kullanıldığı Yerler" >
                                                    <div class="badge badge-pill bg-warning">
                                                        <i class="bi bi-search"></i> 
                                                    </div></a> 
                                                </td>   <%              
                                            Dim bunutaz
                                            bunutaz=NetsisRecordSet("HAM_Kodu")
                                            if NetsisRecordSet("FIYAT1") then                                  %>
                                                <td>   <!-- Button trigger modal -->
                                                    <div class="badge badge-pill bg-success" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="showHint('<%=bunutaz%>')">
                                                        <i class="bi bi-currency-exchange"></i>
                                                    </div>
                                                </td>    <%
                                            else                                                             %>
                                                <td>   <!-- Button trigger modal -->
                                                    <div class="badge badge-pill bg-secondary">
                                                        <i class="bi bi-currency-exchange"></i>
                                                    </div>    
                                                </td>                            <%
                                            end if
                                               %><!-- Modal -->   
                                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title"  id="fiyatlarbaslik"></h5>
                                                        </div>
                                                        <div class="modal-body" id="fiyatlar">
                                                            ...
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>                                                        
                                            <%
                                            response.write(" <td " & renkli & " >")
                                                for i=1 to (NetsisRecordSet("Level")-1)*3
                                                    response.write("&nbsp;")
                                                next
                                            'if LEFT(NetsisRecordSet("GRUP_ISIM"),5)="KADRO" OR LEFT(NetsisRecordSet("GRUP_ISIM"),5)="CATAL" then kadroDWG="<a target='_blank' href='http://qdms.accellbisiklet.com.tr/QDMSNET/Document/DokumanGoruntuleme.aspx?ROWINDEX=0&PAGEINDEX=0&kod="&NetsisRecordSet("HAM_Kodu")&"'><img  width='16' height='16'  src='img/icons/icons8-Design.png' title='Teknik Çizim' /></a>" else kadroDWG=""
                                                'http://qdms.accellbisiklet.com.tr/QDMSNET/Document/DokumanGoruntuleme.aspx?ROWINDEX=0&PAGEINDEX=0&kod='
                                            response.write(" <b>"&NetsisRecordSet("GRUP_ISIM")&"</b> "&kadroDWG&"</td>")
                                            if NetsisRecordSet("STOK_ADI")<>"" then response.write(" <td>"&NetsisRecordSet("STOK_ADI")&"</td>") else response.write(" <td>"&NetsisRecordSet("Operasyon")&"</td>") 
                                            response.write(" <td>"&NetsisRecordSet("Tedarikci")&"</td>")
                                            response.write(" <td>"&NetsisRecordSet("MIKTAR")&"</td>")
                                            response.write(" <td>"&NetsisRecordSet("OLCU_BR1")&"</td>")
                                            response.write(" <td>"&NetsisRecordSet("Maliyet")&"</td>")
                                            ' response.write(" <td>")
                                            ' 'if NetsisRecordSet("FIYAT1") then response.write(" "&NetsisRecordSet("FIYAT1")&" ["&NetsisRecordSet("FIYATDOVIZTIPI")&"] <font color='orange'>["&NetsisRecordSet("OLCUBR")&"]</font>") 
                                            ' response.write("</td>")
                                        response.write("</tr>")
                                        NetsisRecordSet.movenext
                                    Loop
                                NetsisRecordSet.close %>
                            </table>
                        </div><% ' end bomlist iş emri
                    end if ' end Bomlist 

                    if url_doo="kullanimyeri" then  %> 
                        <div class="list-group"> <!-- SKU# -->     <%
                            ' SQL
                                Netsis_SQL="SELECT "
                                Netsis_SQL=Netsis_SQL +" A.[STOK_KODU] "
                                Netsis_SQL=Netsis_SQL +" ,[URETICI_KODU] "
                                Netsis_SQL=Netsis_SQL +" ,DBO.TRK4(STOK_ADI) AS STOK_ADI"
                                Netsis_SQL=Netsis_SQL +" ,[GRUP_KODU] "
                                Netsis_SQL=Netsis_SQL +" ,[DEPO_KODU]"
                                Netsis_SQL=Netsis_SQL +" ,[OLCU_BR1] "
                                Netsis_SQL=Netsis_SQL +" ,[OLCU_BR2] "
                                Netsis_SQL=Netsis_SQL +" ,[OLCU_BR3] "
                                Netsis_SQL=Netsis_SQL +" ,[PAY_1] "
                                Netsis_SQL=Netsis_SQL +" ,[PAYDA_1] "
                                Netsis_SQL=Netsis_SQL +" ,[PAY2] "
                                Netsis_SQL=Netsis_SQL +" ,[PAYDA2],BARKOD1,EN,BOY,GENISLIK,GUMRUKTARIFEKODU   "
                                Netsis_SQL=Netsis_SQL +" ,B1.[GRUP_ISIM] AS KOD1 "
                                Netsis_SQL=Netsis_SQL +" ,B2.[GRUP_ISIM] AS KOD2 "
                                Netsis_SQL=Netsis_SQL +" ,B3.[GRUP_ISIM] AS KOD3 "
                                Netsis_SQL=Netsis_SQL +" ,B4.[GRUP_ISIM] AS KOD4 "
                                Netsis_SQL=Netsis_SQL +"  ,A.KOD_5 AS KOD5 "
                                Netsis_SQL=Netsis_SQL +" ,Z.TOPLAM "
                                Netsis_SQL=Netsis_SQL +" ,Z2.TOPLAM2 "
                                Netsis_SQL=Netsis_SQL +" ,A2.[INGISIM] "
                                Netsis_SQL=Netsis_SQL +" ,A2.[KAYITTARIHI] "
                                Netsis_SQL=Netsis_SQL +" ,A2.[KAYITYAPANKUL] "
                                Netsis_SQL=Netsis_SQL +" ,A2.[DUZELTMETARIHI] "
                                Netsis_SQL=Netsis_SQL +" ,A2.[DUZELTMEYAPANKUL] "
                                Netsis_SQL=Netsis_SQL +" ,A2.[KULL8S] "
                                Netsis_SQL=Netsis_SQL +" ,C1.[BILGI] as ESKITR"
                                Netsis_SQL=Netsis_SQL +" , AX.DS_OZELSART"
                               
								'Netsis_SQL=Netsis_SQL +" ,C1.[AX_STOKBILGISI_2_EN] as ESKIEN"
                                Netsis_SQL=Netsis_SQL +" FROM ["+currentDB+"].[dbo].[TBLSTSABIT] A with (NOLOCK) "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABITEK] A2  with (NOLOCK) ON A.[STOK_KODU]=A2.[STOK_KODU] "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] B1  with (NOLOCK) ON [KOD_1]=B1.[GRUP_KOD] "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD2] B2  with (NOLOCK) ON [KOD_2]=B2.[GRUP_KOD] "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD3] B3  with (NOLOCK) ON [KOD_3]=B3.[GRUP_KOD] "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] B4  with (NOLOCK) ON [KOD_4]=B4.[GRUP_KOD] "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD5] B5  with (NOLOCK) ON [KOD_5]=B5.[GRUP_KOD] "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKBIL]  C1  with (NOLOCK) ON A.[STOK_KODU]=C1.[STOK_KODU] "
                                Netsis_SQL=Netsis_SQL +" LEFT JOIN [MicrosoftDynamicsAX].[dbo].[INVENTTABLE]  AX ON AX.ITEMID=A.STOK_KODU "
                               
                                '["+currentDB+"].[dbo].[GRL_STOKACIK]"
                                Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT COUNT(*) as toplam FROM ["+currentDB+"].[dbo].[TBLSTOKURM]  with (NOLOCK) WHERE [MAMUL_KODU]=A.[STOK_KODU] AND GEC_FLAG=0) Z " 
                                Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT COUNT(*) as toplam2 FROM ["+currentDB+"].[dbo].[TBLISEMRIREC]  with (NOLOCK) WHERE [MAMUL_KODU]=A.[STOK_KODU] AND GEC_FLAG=0) Z2 " 
                                Netsis_SQL=Netsis_SQL +" WHERE A.[STOK_KODU]='"&url_item&"' "
                                'response.write(Netsis_SQL)
                            ' SQL ende
                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                say=0                    %>
                                    <div class="container-fluid p-4"><strong>Stok Kartı Detayları</strong>
                                        <form method='get'>
                                            <div class="input-group mb-3 d-print-none">  
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text bg-warning">Madde Kodu:</span>
                                                </div>
                                                <input type='hidden' name='doo' value='kullanimyeri'>          
                                                <input type="text" class="form-control" name='item' value='<%=url_item%>'  placeholder="SKU#" aria-label="SKU#" aria-describedby="button-addon2">
                                                <button class="btn btn-secondary"  type="submit"  name="B1"  id="button-addon2">Ara</button>
                                            </div>                                  
                                        </form>
                                    </div>
                                    <div class="container-fluid p-4"> <!-- SKU# -->
                                        <h2><%=url_item%></h2>         <%
                                        do until NetsisRecordSet.EOF OR say=1
                                            if NetsisRecordSet("KOD1")="KADRO" then cizimlink="<a target='_blank' title='Teknik Çizim' href='http://qdms.accellbisiklet.com.tr/QDMSNET/Document/DokumanGoruntuleme.aspx?kod="&NetsisRecordSet("URETICI_KODU")&"'><div class='badge badge-pill bg-danger'><i class='bi bi-wrench'></i></div></a>" else cizimlink=""
                                            say=1                                %>               
                                            <!-- Künye -->
                                                <ol class="list-group list-group-horizontal  pt-1">
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'  >
                                                    <div class='ms-2 me-auto'>Grup Kodu<div class='fw-bold'><%=NetsisRecordSet("GRUP_KODU")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 1<div class='fw-bold'><%=NetsisRecordSet("KOD1")%> <span><%=cizimlink%></span></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 2<div class='fw-bold'><%=NetsisRecordSet("KOD2")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 3<div class='fw-bold'><%=NetsisRecordSet("KOD3")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 4<div class='fw-bold'><%=NetsisRecordSet("KOD4")%></div></div></li>

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Kod 5<div class='fw-bold'><%=NetsisRecordSet("KOD5")%></div></div></li>                   

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Global A. Code<div class='fw-bold'><%=NetsisRecordSet("KULL8S")%></div></div></li>                   

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'>
                                                    <div class='ms-2 me-auto'>Üretici Kodu<div class='fw-bold'><%=NetsisRecordSet("URETICI_KODU")%></div>
                                                    </div></li>
                                                </ol>
                                                <ol class="list-group pt-1">
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-success align-items-start'>
                                                    <div class='ms-2 me-auto'>Stok Adı<div class='fw-bold h5'><%=NetsisRecordSet("STOK_ADI")%></div>
                                                    
                                                    <% if NetsisRecordSet("TOPLAM")>0 THEN  %>
                                                        <a  href="?doo=bomlist&item=<%=url_item%>" title="Ürün Ağacı <%=url_item%>" >
                                                            <div class="badge badge-pill bg-primary">
                                                                <i class="bi bi-journal-text"></i> 
                                                            </div></a> 
                                                    <%  end if  %>
                                                    <% if NetsisRecordSet("TOPLAM2")>0 THEN  %>
                                                            <div class="badge badge-pill bg-warning" data-bs-toggle="modal" data-bs-target="#exampleModal3" onclick="showAltBom('<%=url_item%>')">
                                                                <i class="bi bi-journal-text"></i> 
                                                            </div>
                                                            <!-- Modal -->     
                                                            <div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModal3Label" aria-hidden="true">
                                                                <div class="modal-dialog modal-xl">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title"  id="fiyatlarbaslik3"></h5>
                                                                        </div>
                                                                        <div class="modal-body" id="fiyatlar3">
                                                                            ...
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>     
                                                    <%  end if  %>
                                                    <% if instr(UserLevel,"u")  THEN  %>
                                                    <a  href="chart-SKU-ihtiyac.asp?SKU=<%=url_item%>" title="İhtiyaç Grafiği <%=url_item%>" target="_blank" >
                                                            <div class="badge badge-pill bg-danger">
                                                                <i class="bi bi-graph-down-arrow"></i> 
                                                            </div></a>     
                                                    <%  end if  %>
                                                                                                         
                                                    <div class=''><%=NetsisRecordSet("INGISIM")%></div><hr>
                                                    <div class=''><% 
                                                    if LEN(NetsisRecordSet("ESKITR"))>0 then  response.write(Replace(NetsisRecordSet("ESKITR"),vbCrLf, "<br/>"))
                                                    %></div></div>
                                                    <div class='ms-2 me-auto'>
                                                        <% if instr(UserLevel,"m") then 'stok kartı database görüntüsü &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'            %>         
                                                            <div class="badge badge-pill bg-success" data-bs-toggle="modal" data-bs-target="#exampleModal2" onclick="showStokKart('<%=url_item%>')">
                                                                <i class="bi bi-arrows-fullscreen"></i>
                                                            </div>
                                                            <!-- Modal -->     
                                                            <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModal2Label" aria-hidden="true">
                                                                <div class="modal-dialog modal-xl">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title"  id="fiyatlarbaslik2"></h5>
                                                                        </div>
                                                                        <div class="modal-body" id="fiyatlar2">
                                                                            ...
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>                                                        
                                                        <% end if %>
                                                    <div class='small'>Rec: &nbsp;<%=NetsisRecordSet("KAYITTARIHI")%>&nbsp;<%=NetsisRecordSet("KAYITYAPANKUL")%></div>
                                                    <div class='small'>Edit:&nbsp;<%=NetsisRecordSet("DUZELTMETARIHI")%>&nbsp;<%=NetsisRecordSet("DUZELTMEYAPANKUL")%></div></div>
                                                    </li>
                                                </ol>      
                                                <ol class="list-group list-group-horizontal pt-1" >                                               

                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Depo<div class='fw-bold'><%=NetsisRecordSet("DEPO_KODU")%></div></div></li>                   
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Barkod<div class='fw-bold'><%=NetsisRecordSet("BARKOD1")%></div></div></li>                   
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Tariff<div class='fw-bold'><%=NetsisRecordSet("GUMRUKTARIFEKODU")%></div></div></li>                   
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Ölçüler<div class='fw-bold'><%=NetsisRecordSet("EN")%>x<%=NetsisRecordSet("BOY")%>x<%=NetsisRecordSet("GENISLIK")%></div></div></li>                   
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>Ölçü Birimleri<div><strong>
                                                    <%
                                                    response.write( NetsisRecordSet("OLCU_BR1")&"</strong> ")
                                                    if len(NetsisRecordSet("OLCU_BR2"))>0 then response.write( "= "&NetsisRecordSet("PAY_1")&"/"&NetsisRecordSet("PAYDA_1")&" "&NetsisRecordSet("OLCU_BR2") )
                                                    if len(NetsisRecordSet("OLCU_BR3"))>0 then response.write( "= "&NetsisRecordSet("PAY2")&"/"&NetsisRecordSet("PAYDA2")&" "&NetsisRecordSet("OLCU_BR3") )
                                                    
                                                    %></div></div></li>          
                                                    <%
                                                        if  instr(UserLevel,"r") then
                                                    %>
                                                    <li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start' >
                                                    <div class='ms-2 me-auto'>
                                                        Eski AX Notu<div class='text-warning'> <%=NetsisRecordSet("DS_OZELSART")%></div></div></li>                   
                                                    <%
                                                    end if
                                                    %>
            
                                                </ol>                                               
                            
                                            <%
                                        Loop    %> 
                                    </div> <%
                            NetsisRecordSet.close
                            if say=0 and url_item<>"" then Response.Redirect "NetsisBom.asp?doo=bikelist&search_bisiklet_kodu=" & url_item     %>                           
                        </div>                   
                         <%
                        if url_item<>"" then                                                        %>
                            <div class="list-group"> <!-- Müşteri SKU#  -->     <%
                                ' SQL
                                    Netsis_SQL="SELECT top 10"
                                    Netsis_SQL=Netsis_SQL +"   [STOK_KODU]							 "
                                    Netsis_SQL=Netsis_SQL +"       ,[MUSTERI_KODU]						 "
                                    Netsis_SQL=Netsis_SQL +"       ,B.[CARI_ISIM]						 "
                                    Netsis_SQL=Netsis_SQL +"       ,[MUSTERI_STOKKODU]					 "
                                    Netsis_SQL=Netsis_SQL +"       ,[MUSTERI_ACIKLAMA]					 "
                                    Netsis_SQL=Netsis_SQL +"       ,[MODEL_CODE]						 "
                                    Netsis_SQL=Netsis_SQL +"   FROM ["+currentDB+"].[dbo].[ACCELL_CARISTOK]  with (NOLOCK) "
                                    Netsis_SQL=Netsis_SQL +"   LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] B  with (NOLOCK) ON B.[CARI_KOD]=[MUSTERI_KODU] "
                                    Netsis_SQL=Netsis_SQL +" WHERE [STOK_KODU]='"&url_item&"' "
                                ' SQL ende
                                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                    say=0                    %>
                                    <div class="container-fluid p-4">                                
                                        <strong>Müşterideki Stok Karti Bilgileri <a class="badge bg-success" href="#demo6" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                                        <div id="demo6" class="collapse">   
                                        
                                        
                                        
                                        
                                        
                                                                <!-- Müşteri SKU# --> <%
                                        do until NetsisRecordSet.EOF OR say=10                    
                                                if say=0 then 
                                                response.write("<table class='table table-sm table-striped table-hover'><tr>")
                                                response.write("<th>Sıra</th>")          
                                                response.write("<th>Müşteri</th>")          
                                                response.write("<th>Müşteri Stok Kodu</th>")          
                                                response.write("<th>Müşteri Açıklama</th>")          
                                                response.write("<th>Müşteri Model Kodu</th>")          
                                                response.write("</tr>")          
                                            end if 
                                            say=say+1
                                                response.write("<tr>")
                                                response.write("<td>"&say&"</td>")
                                                response.write("<td>"&NetsisRecordSet("MUSTERI_KODU")&" "&NetsisRecordSet("CARI_ISIM")&"</td>")
                                                response.write("<td>"&NetsisRecordSet("MUSTERI_STOKKODU")&"</td>")
                                                response.write("<td>"&NetsisRecordSet("MUSTERI_ACIKLAMA")&"</td>")
                                                response.write("<td>"&NetsisRecordSet("MODEL_CODE")&"</td>")
                                                response.write("<tr>")
                                                NetsisRecordSet.movenext
                                            Loop   
                                                response.write("</table>")
                                                if say=0 then response.write("null") %> 
                                    </div></div> <%
                                NetsisRecordSet.close   %>                           
                            </div>                                                                             
                            <div class="container-fluid p-4"> <!--Stok durumu -->
                                <strong>Stok</strong>                           
                                <table class='table table-sm table-striped table-hover'> <%
                                    ' SQL
                                        Netsis_SQL="SELECT "
                                        Netsis_SQL=Netsis_SQL+" [STOK_KODU] "
                                        Netsis_SQL=Netsis_SQL+" ,A.[SUBE_KODU] "
                                        Netsis_SQL=Netsis_SQL+" ,B.[DEPO_ISMI] " 
                                        Netsis_SQL=Netsis_SQL+" ,B.[DEPO_KODU] " 
                                        Netsis_SQL=Netsis_SQL+" ,[CEVRIM] "
                                        Netsis_SQL=Netsis_SQL+" ,[TOP_GIRIS_MIK] "
                                        Netsis_SQL=Netsis_SQL+" ,[TOP_CIKIS_MIK] "
                                        Netsis_SQL=Netsis_SQL+" ,[STOK_DAGITIM] "
                                        Netsis_SQL=Netsis_SQL+" ,[MUS_TOP_SIPARIS] "
                                        Netsis_SQL=Netsis_SQL+" ,[MUS_TOP_SIPARIS]-MUS_TOP_TESLIM as MusSip "
                                        Netsis_SQL=Netsis_SQL+" ,[SAT_TOP_SIPARIS] "
                                        Netsis_SQL=Netsis_SQL+" ,[SAT_TOP_SIPARIS]-SAT_TOP_TESLIM as SatSip " 
                                        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKPH] A  with (NOLOCK) "
                                        Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].[TBLSTOKDP] B  with (NOLOCK) ON A.[DEPO_KODU]=B.[DEPO_KODU] " 
                                        Netsis_SQL=Netsis_SQL+" WHERE [STOK_KODU]='"&url_item&"' "
                                        if instr(UserLevel,"s") then Netsis_SQL=Netsis_SQL+" " else Netsis_SQL=Netsis_SQL+" AND A.[DEPO_KODU]!=101 "
                                        if instr(UserLevel,"s") then Netsis_SQL=Netsis_SQL+" AND (A.[SUBE_KODU]=1 OR A.[SUBE_KODU]=2 )" else Netsis_SQL=Netsis_SQL+" AND (A.[SUBE_KODU]=1)" 
                                        
                                    ' SQL ende
                                    sira=0 
                                    bakiye=0
                                    gizlidepo=0
                                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                        do until NetsisRecordSet.EOF
                                            if sira=0 then 
                                                response.write("<tr>")
                                                response.write("<th>Sira</th>")
                                                response.write("<th> Stok </th>")  
                                                response.write("<th> Depo </th>")  
                                                response.write("<th> Bakiye </th>")  
                                                response.write("<th> Giriş </th>")  
                                                response.write("<th> Çıkış </th>")
                                                if instr(UserLevel,"s") then 'needed level'' view &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'           
                                                    response.write("<th> Stok Dağıtım </th>")  
                                                    response.write("<th> Müşteri Sipariş </th>")  
                                                    response.write("<th> Satıcı Sipariş </th>")  
                                                    response.write("<th> Çevrim </th>")  
                                                    response.write("<th> Şube </th>")  
                                                end if 
                                                response.write("</tr>")
                                            end if 
                                            Sira=sira+1
                                            bakiye=bakiye+CDbl(NetsisRecordSet("TOP_GIRIS_MIK"))-CDbl(NetsisRecordSet("TOP_CIKIS_MIK"))
                                            sipbakiye=sipbakiye+CDbl(NetsisRecordSet("SatSip"))
                                            msipbakiye=msipbakiye+CDbl(NetsisRecordSet("MusSip"))
                                            if NetsisRecordSet("DEPO_KODU")=101 then 
                                                karalar=" class='bg-secondary' " 
                                                gizlidepo=CDbl(NetsisRecordSet("TOP_GIRIS_MIK"))-CDbl(NetsisRecordSet("TOP_CIKIS_MIK"))
                                            else 
                                                karalar=""
                                            end if 
                                            response.write("<tr "&karalar&">")
                                            response.write("<td>"&Sira&"</td>")
                                            response.write("<td>"&NetsisRecordSet("STOK_KODU")&"</td>")  
                                            if isnull(NetsisRecordSet("DEPO_KODU")) then Response.Write ("<td>"&NetsisRecordSet("DEPO_KODU")&"Toplam</td>") else response.write("<td>"&NetsisRecordSet("DEPO_KODU")&" "&NetsisRecordSet("DEPO_ISMI")&"</td>")  
                                            response.write("<td>"&CDbl(NetsisRecordSet("TOP_GIRIS_MIK"))-CDbl(NetsisRecordSet("TOP_CIKIS_MIK"))&"</td>")  
                                            response.write("<td>"&NetsisRecordSet("TOP_GIRIS_MIK")&"</td>")  
                                            response.write("<td>"&NetsisRecordSet("TOP_CIKIS_MIK")&"</td>")                                              
                                            if instr(UserLevel,"s") then 'needed level'' view &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'           
                                                response.write("<td>"&NetsisRecordSet("STOK_DAGITIM")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("MusSip")&" ("&NetsisRecordSet("MUS_TOP_SIPARIS")&")</td>")  
                                                response.write("<td>"&NetsisRecordSet("SatSip")&" ("&NetsisRecordSet("SAT_TOP_SIPARIS")&")</td>")  
                                                response.write("<td>"&NetsisRecordSet("CEVRIM")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("SUBE_KODU")&"</td>")  
                                            end if 
                                            response.write("</tr>")
                                            NetsisRecordSet.movenext
                                        Loop
                                    NetsisRecordSet.close   
                                            response.write("<tr><td colspan=2></td><td><b>Toplam</b></td><td><b>"&Bakiye&" ")
                                                if instr(UserLevel,"s") then response.write (" ("&bakiye-gizlidepo&") ")
                                            response.write("</b></td><td colspan=3></td><td ><b>"&msipbakiye&"</b></td><td colspan=3><b>"&sipbakiye&"</b></td>")  
                                            response.write("</tr>")                                               
                                    if sira=0 then Response.write("")                              %>
                                </table>
                            </div>

                            <div class="container-fluid p-4"> <!--Stok Hareketleri AŞ-->
                                <strong>Stok Hareketleri (AŞ.)  <a class="badge bg-success" href="#demo4" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                                    <div id="demo4" class="collapse">
                                    <span>Toplam.</span>                                    
                                    <table class='table table-sm table-striped table-hover '  style="width:50%"> 
                                        

                                                <%  ' SQL                                  
                                                Netsis_SQL = " WITH liste as ( "
                                                Netsis_SQL = Netsis_SQL + " SELECT A.[STOK_KODU],A.STHAR_HTUR,sum(A.[STHAR_GCMIK]) as toplam,A.[STHAR_GCKOD]"
                                                Netsis_SQL = Netsis_SQL + " ,CASE 												 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='A' THEN 'Devir' 				 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='J' THEN 'Fatura' 			 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='H' THEN 'İrsaliye' 			 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='B' THEN 'Depo Transferi' 		 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='N' THEN 'Faturalaşmış İrsaliye' "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='L' THEN 'İade' 					 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='C' THEN 'Üretim' 				 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='D' THEN 'Muhtelif' 				 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='E' THEN 'Maliyet' 				 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='F' THEN 'Konsinye' 				 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='G' THEN 'Mühtahsil' 				 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='I' THEN 'Kapalı Fatura' 			 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='K' THEN 'Müşteri Faturası' 		 "
                                                Netsis_SQL = Netsis_SQL + " WHEN A.STHAR_HTUR='M' THEN 'Zayi İade' 				 "
                                                Netsis_SQL = Netsis_SQL + " ELSE '?' 											 "
                                                Netsis_SQL = Netsis_SQL + " END as 'HareketTipi' 								 				 "
                                                Netsis_SQL = Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLSTHAR] A	 WITH (NOLOCK) "
                                                'Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLFATUIRS] B WITH (NOLOCK) ON B.FATIRS_NO=A.IRSALIYE_NO "
                                                Netsis_SQL = Netsis_SQL + " WHERE STOK_KODU ='"&url_item&"' AND A.SUBE_KODU=1 	 "
                                                Netsis_SQL = Netsis_SQL + " GROUP BY A.[STOK_KODU],A.STHAR_HTUR ,A.[STHAR_GCKOD]"
                                                Netsis_SQL = Netsis_SQL + " )						 	 "
                                                Netsis_SQL = Netsis_SQL + " SELECT TOP 5000 * from liste "
                                                Netsis_SQL = Netsis_SQL + " PIVOT (sum(toplam) FOR [STHAR_GCKOD] IN (G,C)) as P "
                                                                                  
                                        ' SQL ende
                                        sira=0 
                                        bakiye=0
                                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                            do until NetsisRecordSet.EOF
                                                if sira=0 then 
                                                    response.write("<tr>")
                                                    response.write("<th> Sira </th>")
                                                    response.write("<th> Stok </th>")  
                                                    response.write("<th> Hareket Tipi </th>")  
                                                    response.write("<th> Giriş </th>")  
                                                    response.write("<th> Çıkış </th>")
                                                    response.write("</tr>")
                                                end if 
                                                Sira=sira+1
                                                response.write("<tr>")
                                                response.write("<td>"&Sira&"</td>")
                                                response.write("<td>"&NetsisRecordSet("STOK_KODU")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("HareketTipi")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("G")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("C")&"</td>")                                              
                                                response.write("</tr>")
                                                NetsisRecordSet.movenext
                                            Loop
                                        NetsisRecordSet.close   
                                        if sira=0 then Response.write("null")                              %>
                                    </table>                                  
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    <span>Hareketler kümülatif gösteriliyor. Netsis'e göre daha az satır görünecektir.</span>                                    
                                    <table class='table table-sm table-striped table-hover'> <%
                                        ' SQL

                                        Netsis_SQL=" WITH liste as ( "
                                        Netsis_SQL=Netsis_SQL+" SELECT A.[STOK_KODU],A.[STHAR_TARIH],A.[STHAR_SIPNUM],A.[STHAR_ACIKLAMA],A.[IRSALIYE_NO],A.STHAR_HTUR,A.[OLCUBR],sum(A.[STHAR_GCMIK]) as toplam,A.[STHAR_GCKOD],A.STHAR_DOVFIAT,A.STHAR_DOVTIP,A.STHAR_NF,A.F_YEDEK3,A.F_YEDEK4 "
                                        Netsis_SQL=Netsis_SQL+" ,CASE 												   "
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='A' THEN 'Devir' 				   "
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='J' THEN 'Fatura' 			   "
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='H' THEN 'İrsaliye' 			   "
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='B' THEN 'Depo Transferi' 		   "
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='N' THEN 'Faturalaşmış İrsaliye' "
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='L' THEN 'İade' 					"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='C' THEN 'Üretim' 				"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='D' THEN 'Muhtelif' 				"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='E' THEN 'Maliyet' 				"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='F' THEN 'Konsinye' 				"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='G' THEN 'Mühtahsil' 				"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='I' THEN 'Kapalı Fatura' 			"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='K' THEN 'Müşteri Faturası' 		"
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='M' THEN 'Zayi İade' 				"
                                        Netsis_SQL=Netsis_SQL+"     ELSE '?' 											"
                                        Netsis_SQL=Netsis_SQL+" END    as  'HareketTipi'  								"                                    
                                        Netsis_SQL=Netsis_SQL+" ,CASE 												   "
                                        Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR IN ('A','J','H','C') THEN '' 				   "
                                        Netsis_SQL=Netsis_SQL+"     ELSE 'bg-secondary fst-italic' 											"
                                        Netsis_SQL=Netsis_SQL+" END    as  'ArkaPlan'  								"                                    
                                        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTHAR] A	 WITH (NOLOCK) "
                                        'Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLFATUIRS] B WITH (NOLOCK) ON B.FATIRS_NO=A.IRSALIYE_NO "
                                        Netsis_SQL=Netsis_SQL+" WHERE STOK_KODU ='"&url_item&"' AND A.SUBE_KODU=1 	"
                                        'Netsis_SQL1=Netsis_SQL+"AND STHAR_HTUR NOT IN ('N')	 "
                                        Netsis_SQL=Netsis_SQL+" GROUP BY A.[STOK_KODU],A.[STHAR_SIPNUM],A.[STHAR_ACIKLAMA],A.[IRSALIYE_NO],A.STHAR_HTUR,A.[STHAR_TARIH],A.[STHAR_GCKOD],A.[OLCUBR],A.STHAR_DOVFIAT,A.STHAR_DOVTIP,A.STHAR_NF,A.F_YEDEK3,A.F_YEDEK4 )						  	  "
                                        Netsis_SQL=Netsis_SQL+" SELECT TOP 5000 * from liste"
                                        Netsis_SQL=Netsis_SQL+" PIVOT (sum(toplam) FOR [STHAR_GCKOD] IN (G,C)) as P  ORDER BY [STHAR_TARIH] "                                    
                                        ' SQL ende
                                        sira=0 
                                        bakiye=0
                                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                            do until NetsisRecordSet.EOF
                                                if sira=0 then 
                                                    response.write("<tr>")
                                                    response.write("<th> Sira </th>")
                                                    response.write("<th> Stok </th>")  
                                                    response.write("<th> Tarih </th>")  
                                                    response.write("<th> Sipariş No </th>")  
                                                    response.write("<th> Açıklama </th>")  
                                                    response.write("<th> İrsaliye No </th>")  
                                                    'response.write("<th> Dosya No </th>")  
                                                    response.write("<th> Maliyet Fiyat </th>")  
                                                    response.write("<th> Fatura Fiyat </th>")  
                                                    response.write("<th> Döviz Tipi</th>")  
                                                    response.write("<th> Maliyet Fiyat ₺ </th>")  
                                                    response.write("<th> Fatura Fiyat ₺ </th>")  
                                                    response.write("<th> Hareket Tipi </th>")  
                                                    response.write("<th> Hareket </th>")  
                                                    response.write("<th> Giriş </th>")  
                                                    response.write("<th> Çıkış </th>")
                                                    response.write("<th> Ölçü Birimi </th>")
                                                    response.write("</tr>")
                                                end if 
                                                Sira=sira+1
                                                if LEN(NetsisRecordSet("ArkaPlan"))=0 OR instr(UserLevel,"s") then 
                                                    response.write("<tr class='"&NetsisRecordSet("ArkaPlan")&"'>")
                                                    response.write("<td>"&Sira&"</td>")
                                                    response.write("<td>"&NetsisRecordSet("STOK_KODU")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("STHAR_TARIH")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("STHAR_SIPNUM")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("STHAR_ACIKLAMA")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("IRSALIYE_NO")&"</td>")  
                                                    'response.write("<td>"&NetsisRecordSet("EXPORTREFNO")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("STHAR_DOVFIAT")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("F_YEDEK3")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("STHAR_DOVTIP")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("STHAR_NF")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("F_YEDEK4")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("HareketTipi")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("STHAR_HTUR")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("G")&"</td>")  
                                                    response.write("<td>"&NetsisRecordSet("C")&"</td>")                                              
                                                    response.write("<td>"&NetsisRecordSet("OLCUBR")&"</td>")                                              
                                                    response.write("</tr>")
                                                end if 
                                                NetsisRecordSet.movenext
                                            Loop
                                        NetsisRecordSet.close   
                                        if sira=0 then Response.write("null")                              %>
                                    </table>
                                </div>
                            </div>  <%
                            if instr(UserLevel,"a") then 'needed level'' view &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'            %>         

                                <div class="container-fluid p-4"> <!--Stok Hareketleri LTD -->
                                    <strong>Stok Hareketleri (LTD.)  <a class="badge bg-success" href="#demo5" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                                    <div id="demo5" class="collapse">                                    
                                        <table class='table table-sm table-striped table-hover'> <%
                                    ' SQL

                                    Netsis_SQL=" WITH liste as ( "
                                    Netsis_SQL=Netsis_SQL+" SELECT A.[STOK_KODU],A.[STHAR_TARIH],A.[STHAR_SIPNUM],A.[STHAR_ACIKLAMA],A.[IRSALIYE_NO],A.STHAR_HTUR,A.[OLCUBR],sum(A.[STHAR_GCMIK]) as toplam,A.[STHAR_GCKOD] ,A.STHAR_DOVFIAT,A.STHAR_DOVTIP,A.STHAR_NF,A.F_YEDEK3,A.F_YEDEK4 "
                                    Netsis_SQL=Netsis_SQL+" ,CASE 												   "
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='A' THEN 'Devir' 				   "
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='J' THEN 'Fatura' 			   "
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='H' THEN 'İrsaliye' 			   "
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='B' THEN 'Depo Transferi' 		   "
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='N' THEN 'Faturalaşmış İrsaliye' "
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='L' THEN 'İade' 					"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='C' THEN 'Üretim' 				"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='D' THEN 'Muhtelif' 				"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='E' THEN 'Maliyet' 				"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='F' THEN 'Konsinye' 				"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='G' THEN 'Mühtahsil' 				"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='I' THEN 'Kapalı Fatura' 			"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='K' THEN 'Müşteri Faturası' 		"
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR='M' THEN 'Zayi İade' 				"
                                    Netsis_SQL=Netsis_SQL+"     ELSE '?' 											"
                                    Netsis_SQL=Netsis_SQL+" END    as  'HareketTipi'  								"                                    
                                    Netsis_SQL=Netsis_SQL+" ,CASE 												   "
                                    Netsis_SQL=Netsis_SQL+"     WHEN A.STHAR_HTUR IN ('A','J','H','C') THEN '' 				   "
                                    Netsis_SQL=Netsis_SQL+"     ELSE 'bg-secondary fst-italic' 											"
                                    Netsis_SQL=Netsis_SQL+" END    as  'ArkaPlan'  								"                                    
                                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTHAR] A	 WITH (NOLOCK) "
                                    'Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].[TBLFATUIRS] B WITH (NOLOCK) ON B.FATIRS_NO=A.IRSALIYE_NO "
                                    Netsis_SQL=Netsis_SQL+" WHERE STOK_KODU ='"&url_item&"' AND A.SUBE_KODU=0 	"
                                    'Netsis_SQL1=Netsis_SQL+"AND STHAR_HTUR NOT IN ('N')	 "
                                    Netsis_SQL=Netsis_SQL+" GROUP BY A.[STOK_KODU],A.[STHAR_SIPNUM],A.[STHAR_ACIKLAMA],A.[IRSALIYE_NO],A.STHAR_HTUR,A.[STHAR_TARIH],A.[STHAR_GCKOD],A.[OLCUBR] ,A.STHAR_DOVFIAT,A.STHAR_DOVTIP,A.STHAR_NF,A.F_YEDEK3,A.F_YEDEK4 )						  	  "
                                    Netsis_SQL=Netsis_SQL+" SELECT TOP 5000 * from liste "
                                    Netsis_SQL=Netsis_SQL+" PIVOT (sum(toplam) FOR [STHAR_GCKOD] IN (G,C)) as P "                                    
                                    ' SQL ende
                                            sira=0 
                                            bakiye=0
                                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                                do until NetsisRecordSet.EOF
                                               if sira=0 then 
                                                response.write("<tr>")
                                                response.write("<th> Sira </th>")
                                                response.write("<th> Stok </th>")  
                                                response.write("<th> Tarih </th>")  
                                                response.write("<th> Sipariş No </th>")  
                                                response.write("<th> Açıklama </th>")  
                                                response.write("<th> İrsaliye No </th>")  
                                                'response.write("<th> Dosya No </th>")  
                                                response.write("<th> Maliyet Fiyat </th>")  
                                                response.write("<th> Fatura Fiyat </th>")  
                                                response.write("<th> Döviz Tipi</th>")  
                                                response.write("<th> Maliyet Fiyat ₺ </th>")  
                                                response.write("<th> Fatura Fiyat ₺ </th>")  
                                                response.write("<th> Hareket Tipi </th>")  
                                                response.write("<th> Hareket </th>")  
                                                response.write("<th> Giriş </th>")  
                                                response.write("<th> Çıkış </th>")
                                                response.write("<th> Ölçü Birimi </th>")
                                                response.write("</tr>")
                                            end if 
                                            Sira=sira+1
                                            if LEN(NetsisRecordSet("ArkaPlan"))=0 OR instr(UserLevel,"s") then 
                                                response.write("<tr class='"&NetsisRecordSet("ArkaPlan")&"'>")
                                                response.write("<td>"&Sira&"</td>")
                                                response.write("<td>"&NetsisRecordSet("STOK_KODU")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("STHAR_TARIH")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("STHAR_SIPNUM")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("STHAR_ACIKLAMA")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("IRSALIYE_NO")&"</td>")  
                                                'response.write("<td>"&NetsisRecordSet("EXPORTREFNO")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("STHAR_DOVFIAT")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("F_YEDEK3")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("STHAR_DOVTIP")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("STHAR_NF")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("F_YEDEK4")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("HareketTipi")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("STHAR_HTUR")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("G")&"</td>")  
                                                response.write("<td>"&NetsisRecordSet("C")&"</td>")                                              
                                                response.write("<td>"&NetsisRecordSet("OLCUBR")&"</td>")                                              
                                                response.write("</tr>")
                                            end if 
                                            NetsisRecordSet.movenext
                                                Loop
                                            NetsisRecordSet.close   
                                            if sira=0 then Response.write("null")                              %>
                                        </table>
                                    </div>
                                </div> 
                            <% end if %>

                            <div class="container-fluid p-4"> <!-- Fiyat listeleri -->




                                <strong>Fiyatlar</strong>               
                                <table class="table table-sm table-striped table-hover align-middle">                        <%
                                Netsis_SQL=" "
                                Netsis_SQL=Netsis_SQL+"SELECT  top 5000									   "
                                Netsis_SQL=Netsis_SQL+"      [FIYATLISTEKODU]					   "
                                Netsis_SQL=Netsis_SQL+"      ,[STOKKODU]						   "
                                Netsis_SQL=Netsis_SQL+"      ,[A_S]								   "
                                Netsis_SQL=Netsis_SQL+"      ,[FIYAT1]							   "
                                Netsis_SQL=Netsis_SQL+"      ,[FIYATDOVIZTIPI]					   "
                                Netsis_SQL=Netsis_SQL + " ,A.[ISLETME_KODU] "
                                Netsis_SQL=Netsis_SQL + " ,A.[SUBE_KODU] "                                
                                Netsis_SQL=Netsis_SQL+"      ,[BASTAR]							   "
                                Netsis_SQL=Netsis_SQL+"      ,[BITTAR]							   "
                                Netsis_SQL=Netsis_SQL+"      ,[OLCUBR]							   "
                                Netsis_SQL=Netsis_SQL+"      ,[CARI_ISIM] 						   "
                                Netsis_SQL=Netsis_SQL+"      ,A.[FIYATGRUBU]					   "
                                Netsis_SQL=Netsis_SQL+"      ,C.[CARI_ISIM]					   "
                                Netsis_SQL=Netsis_SQL+"  FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] A	 with (NOLOCK)    "
                                Netsis_SQL=Netsis_SQL+"	 LEFT JOIN ["+currentDB+"].[dbo].[TBLFIATGRUP] B  with (NOLOCK) ON B.[FGRUP]=A.[FIYATGRUBU]   "
                                Netsis_SQL=Netsis_SQL+"	 LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] C  with (NOLOCK) ON B.[FGRUP]=C.[CARI_KOD]    "
                                Netsis_SQL=Netsis_SQL+"  WHERE [STOKKODU] = '"&url_item&"'		   "
                                Netsis_SQL=Netsis_SQL+"  ORDER BY [BASTAR]						   "
                                sira=0
                                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                    do until NetsisRecordSet.EOF OR sira>=5000
                                        if sira=0 then 'başlık yaz '
                                            response.write("<tr>")
                                            response.write "<th>Sıra</th>"
                                            response.write "<th>Fiyat Listesi</th>"
                                            response.write "<th>Madde Kodu</th>"
                                            response.write "<th>A</th>"
                                            response.write "<th colspan=2>Fiyat</th>"
                                            response.write "<th>Başlangıç</th>"
                                            response.write "<th>Bitiş</th>"
                                            response.write "<th>Ölçü Birimi</th>"
                                            response.write "<th>Cari</th>"
                                            response.write("</tr>")
                                        end if
                                        Sira=sira+1
                                        sirket=""
                                        sube=""
                                            SELECT CASE NetsisRecordSet("ISLETME_KODU")
                                            CASE 0
                                                sirket="Genel"
                                            CASE 1
                                                sirket="LTD."
                                            CASE 2
                                                sirket="AŞ."
                                            CASE -1
                                                sirket="Tüm"
                                            END SELECT
                                            SELECT CASE NetsisRecordSet("SUBE_KODU")
                                            CASE 0
                                                sube="LTD."
                                            CASE 1
                                                sube="Bisiklet"
                                            CASE 2
                                                sube="P&A"
                                            CASE -1
                                                sube="Tüm"
                                            END SELECT                
                                        response.write("<tr>")
                                        response.write(" <td>"&Sira&"</td>")
                                        response.write("<td>"&NetsisRecordSet("FIYATLISTEKODU"))                           
                                        if instr(UserLevel,"m") then %>
                                            <a  href="FiyatListeleri.asp?doo=list&detay=1&search_liste_kodu=<%=NetsisRecordSet("FIYATLISTEKODU")%>" title="Fiyat Listesini görüntüle" >
                                                <div class="badge badge-pill bg-info">
                                                    <i class="bi bi-card-list"></i> 
                                                </div>
                                            </a>                                     
                                            <%
                                        end if
                                        response.write("</td>")
                                        response.write("<td>"&NetsisRecordSet("STOKKODU")&"</td>")
                                        response.write("<td>"&NetsisRecordSet("A_S")&"</td>")
                                        response.write("<td>"&NetsisRecordSet("FIYAT1")&" "&parabirimi(NetsisRecordSet("FIYATDOVIZTIPI"))&"</td>")
                                        %> <td class="small"><div class="badge badge-pill bg-secondary" title=" "><%=sirket%>&nbsp;/&nbsp;<%=sube%></div></td> <%
                                        response.write("<td>"&NetsisRecordSet("BASTAR")&"</td>")
                                        response.write("<td>"&NetsisRecordSet("BITTAR")&"</td>")
                                        response.write("<td>"&NetsisRecordSet("OLCUBR")&"</td>")
                                        response.write("<td>"&NetsisRecordSet("FIYATGRUBU")&" "&NetsisRecordSet("CARI_ISIM")&"</td>")
                                        response.write(" </tr>")
                                        NetsisRecordSet.movenext
                                    Loop
                                NetsisRecordSet.close    
                                if sira=0 then Response.write("null")                     %>
                                </table>
                             
                            </div>
                            <div class="container-fluid p-4">  <!--Bulunduğu ürün ağaçları -->
                                <strong>Bulunduğu Ürün Ağaçları  <a class="badge bg-success" href="#demo3" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                                <div id="demo3" class="collapse">            
                                    <table class="table table-sm table-striped table-hover align-middle">  
                                    <%
                                        ' *************************************** üretim emri reçete [TBLSTOKURS]  <--> [TBLSTOKURM] Reçete'
                                        ' SQL
                                            Netsis_SQL=" SELECT top 1000 Y.[MAMUL_KODU] as 'Recete' "
                                            Netsis_SQL=Netsis_SQL+" ,F.[STOK_ADI] as 'Recete_Adi' "
                                            Netsis_SQL=Netsis_SQL+" ,Y.[HAM_KODU] as 'Madde_kodu' "
                                            Netsis_SQL=Netsis_SQL+" ,Y.[OPNO] as 'RecSira' "
                                            Netsis_SQL=Netsis_SQL+" ,G.[GRUP_ISIM] as 'Madde_grubu' "
                                            Netsis_SQL=Netsis_SQL+" ,E.[STOK_ADI] as 'Stok_Adi' "
                                            Netsis_SQL=Netsis_SQL+" ,Y.[MIKTAR] as 'Miktar' "
                                            Netsis_SQL=Netsis_SQL+" ,E.[OLCU_BR1] as 'Birim' "
                                            Netsis_SQL=Netsis_SQL+"    ,H.toplamsip as 'Toplam_siparis' "
                                            Netsis_SQL=Netsis_SQL+" ,Y.STOK_MALIYET as 'Stok_Maliyet'"

                                            Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSTOKURM] Y  with (NOLOCK) "
                                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] E  with (NOLOCK) ON Y.[HAM_KODU]=E.[STOK_KODU] "
                                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] F  with (NOLOCK) ON Y.[MAMUL_KODU]=F.[STOK_KODU] "
                                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD4] G  with (NOLOCK) ON E.[KOD_4]=G.[GRUP_KOD] "
                                            Netsis_SQL=Netsis_SQL+" LEFT JOIN (SELECT [STOK_KODU],SUM([STHAR_GCMIK]) as toplamsip FROM ["+currentDB+"].[dbo].[TBLSIPATRA]  with (NOLOCK) WHERE SUBE_KODU=1 GROUP BY STOK_KODU) H ON Y.[MAMUL_KODU]=H.[STOK_KODU]                                        "
                                            Netsis_SQL=Netsis_SQL+" WHERE [HAM_KODU]='"&url_item&"' AND  [GEC_FLAG]=0 " ' GEC_FLAG silinmişleri filtreler '
                                            Netsis_SQL=Netsis_SQL+" ORDER BY Y.[MAMUL_KODU] "
                                        ' SQL ende
                                        sira=0
                                        'response.write (Netsis_SQL)
                                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                            do until NetsisRecordSet.EOF OR sira>=5000
                                                if sira=0 then 'başlık yaz ' %>
                                                    <thead>
                                                    <tr>
                                                    <th>Sıra</th>
                                                    <th colspan=2  >Reçete Kodu</th>
                                                    <th></th>
                                                    <th>Reçete Adı</th>
                                                    <th>Madde Kodu</th>
                                                    <th>Reç.Sıra</th>
                                                    <th colspan=2>Miktar</th>
                                                    <th>Top.Sip.</th>
                                                    <th>S/M</th>
                                                    </tr> </thead>
                                                    <form class="form-horizontal" method="POST" action="Rapor-yalin-recete.asp?doo=list">
                                                    <tbody><%
                                                end if
                                                Sira=sira+1 
                                                %>  
                                                <tr>
                                                <td><%=Sira%></td>
                                                <td><%=NetsisRecordSet("Recete")%></td>
                                                <td class="pr-0 text-right">
                                                <a  href="?doo=bomlist&item=<%=NetsisRecordSet("Recete")%>" title="Ürün Ağacı <%=NetsisRecordSet("Recete")%>" >
                                                <div class="badge badge-pill bg-primary">
                                                    <i class="bi bi-journal-text"></i> 
                                                </div>
                                                </a> 
                                                </td>
                                                <td>
                                                <div class="input-group-text">
                                                    <input class="form-check-input mt-0" type="checkbox" id="search_madde_kodu"  name="search_madde_kodu" value="<%=NetsisRecordSet("Recete")%>" >
                                                </div>                                
                                                </td>                                            
                                                <td><%=NetsisRecordSet("Recete_Adi")%></td>
                                                <td><%=NetsisRecordSet("Madde_Kodu")%></td>
                                                <td><span style="color:gray;"><%=NetsisRecordSet("RecSira")%></span></td>
                                                <td><%=NetsisRecordSet("Miktar")%></td>
                                                <td><%=NetsisRecordSet("Birim")%></td>
                                                <td><%=NetsisRecordSet("Toplam_siparis")%></td>
                                                <td><%=NetsisRecordSet("Stok_Maliyet")%></td>
                                                </tr>                                     <%
                                                NetsisRecordSet.movenext
                                            Loop
                                        NetsisRecordSet.close
                                        if sira=0 then Response.write("null") 
                                        if sira=1000 then Response.write("<tr><td colspan=3>Max. 1000 kayıt gösterilmiştir. </td></tr>") 
                                        %>
                                    </tbody></table>
                                    <input class="btn btn-secondary" type="submit"  name="B1" value="Seçili Reçeteleri Listele">
                                    </form> 
                                </div>
                            </div> 
                            <div class="container-fluid p-4">  <!--İş Emirleri -->
                                <strong>İş Emirleri. <a class="badge bg-success" href="#demo2" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                                <div id="demo2" class="collapse">                      
                                    <table class="table table-sm table-striped table-hover align-middle">  <%
                                        ' *************************************** üretim emri reçete [TBLISEMRIREC]  <--> [TBLSTOKURM] Reçete'
                                        ' SQL

                                            Netsis_SQL= " SELECT TOP 5000 "
                                            Netsis_SQL=Netsis_SQL+" [ISEMRINO] "
                                            Netsis_SQL=Netsis_SQL+" ,[SIPARIS_NO] "
                                            Netsis_SQL=Netsis_SQL+" ,[TARIH] "
                                            Netsis_SQL=Netsis_SQL+" ,[KAPALI] "
                                            Netsis_SQL=Netsis_SQL+" ,[STOK_KODU] "
                                            Netsis_SQL=Netsis_SQL+" ,[MIKTAR] "
                                            Netsis_SQL=Netsis_SQL+" ,[REFISEMRINO] "
                                            Netsis_SQL=Netsis_SQL+" ,[TEPEMAM] "
                                            Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLISEMRI] WITH (NOLOCK) "
                                            Netsis_SQL=Netsis_SQL+" WHERE STOK_KODU='"&url_item&"' ORDER BY TARIH "
                                        ' SQL ende
                                        sira=0
                                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                            do until NetsisRecordSet.EOF OR sira>=5000

                                                if sira2=0 then 'başlık yaz '                                     %>
                                                    <tr>
                                                    <th>Sıra</th>
                                                    <th>Tarih</th>
                                                    <th>Ref. İş Emri No</th>
                                                    <th>Kapalı</th>
                                                    <th>Üst Reçete</th>
                                                    <th>İş Emri No</th>
                                                    <th>Sipariş</th>
                                                    <th>Reçete</th>
                                                    <th>İş Emri Miktar</th>
                                                    </tr><%
                                                    sira2=1
                                                end if
                                                if NetsisRecordSet("KAPALI")="E" then kapali=" class='alert alert-success'  title=' İşemri kapatılmış! ' " else kapali=""
                                                if NetsisRecordSet("KAPALI")="H" OR instr(UserLevel,"a")  then 
                                                    Sira=sira+1 %>  
                                                    <tr  <%=kapali%>>
                                                    <td><%=Sira%></td>
                                                    <td><%=NetsisRecordSet("TARIH")%></td>
                                                    <td><%=NetsisRecordSet("REFISEMRINO")%></td>
                                                    <td><%=NetsisRecordSet("KAPALI")%></td>
                                                    <td><%=NetsisRecordSet("TEPEMAM")%></td>
                                                    <td><%=NetsisRecordSet("ISEMRINO")%> <a href="Rapor-isemri-depo-bakiye.asp?doo=tekisemri&isemri=<%=NetsisRecordSet("ISEMRINO")%>"><i class="bi bi-binoculars"></i></a></td>
                                                    <td><%=NetsisRecordSet("SIPARIS_NO")%> <a href="Rapor-isemri-depo-bakiye.asp?doo=siparis&siparis=<%=NetsisRecordSet("SIPARIS_NO")%>"><i class="bi bi-binoculars"></i></a></td>
                                                    <td><%=NetsisRecordSet("STOK_KODU")%></td>
                                                    <td><%=NetsisRecordSet("MIKTAR")%></td>
                                                    </tr>        
                                                    <%
                                                end if 
                                                NetsisRecordSet.movenext
                                            Loop
                                        NetsisRecordSet.close
                                        if sira=0 then Response.write("null") 
                                        if sira=5000 then Response.write("<tr><td colspan=3>Max. 5000 kayıt gösterilmiştir. </td></tr>") 
                                        %>
                                    </table>
                                </div>
                            </div>  <%
                            if instr(UserLevel,"m") then 'needed level'' view &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'            %>                                     
                                <div class="container-fluid p-4">  <!--Siparişler -->
                                    <strong>Siparişler <a class="badge bg-success" href="#demo" data-bs-toggle="collapse"><i class="bi bi-box-arrow-down-right"></i></a></strong>
                                    <div id="demo" class="collapse">            

                                        <table class="table table-sm table-striped table-hover align-middle">  <%
                                            ' SQL
                           
                                                Netsis_SQL= " SELECT TOP (5000) A.[STOK_KODU]" 
                                                Netsis_SQL=Netsis_SQL+" ,A.[FISNO]" 
                                                Netsis_SQL=Netsis_SQL+" ,B.[KAPALI] as 'isemrikapali' " 
                                                Netsis_SQL=Netsis_SQL+" , A.STHAR_HTUR as 'sipariskapali'" 
                                                Netsis_SQL=Netsis_SQL+" ,A.[STHAR_GCMIK]" 
                                                Netsis_SQL=Netsis_SQL+" ,A.[FIRMA_DOVTUT]" 
                                                Netsis_SQL=Netsis_SQL+" ,CASE "
                                                Netsis_SQL=Netsis_SQL+" WHEN A.CEVRIM=0 THEN A.[STHAR_GCMIK]"
                                                Netsis_SQL=Netsis_SQL+" ELSE A.[STHAR_GCMIK] *A.CEVRIM"
                                                Netsis_SQL=Netsis_SQL+" END	as 'Cevrim'"
                                                Netsis_SQL=Netsis_SQL+" , CASE"
                                                Netsis_SQL=Netsis_SQL+"     WHEN A.[OLCUBR]=1 THEN ST.OLCU_BR1"
                                                Netsis_SQL=Netsis_SQL+"     WHEN A.[OLCUBR]=2 THEN ST.OLCU_BR2"
                                                Netsis_SQL=Netsis_SQL+"     WHEN A.[OLCUBR]=3 THEN ST.OLCU_BR3"
                                                Netsis_SQL=Netsis_SQL+"     ELSE '?'"
                                                Netsis_SQL=Netsis_SQL+" END    as  'Birim'                                          "
                                                Netsis_SQL=Netsis_SQL+" ,A.[STHAR_GCKOD] " 
                                                Netsis_SQL=Netsis_SQL+" ,A.[STHAR_NF] " 
                                                Netsis_SQL=Netsis_SQL+" ,A.[SUBE_KODU]  " 
                                                Netsis_SQL=Netsis_SQL+" ,A.[STHAR_DOVFIAT]  " 
                                                Netsis_SQL=Netsis_SQL+" ,A.[STHAR_DOVTIP]  " 
                                                Netsis_SQL=Netsis_SQL+" ,A.[STHAR_CARIKOD]   " 
                                                Netsis_SQL=Netsis_SQL+" ,A.[IRSALIYE_TARIH]   " 
                                                Netsis_SQL=Netsis_SQL+" ,C.[ACIKLAMA1] "
                                                Netsis_SQL=Netsis_SQL+" ,A.[STHAR_TESTAR]   " 
                                                Netsis_SQL=Netsis_SQL+" ,A.[OLCUBR] " 
                                                Netsis_SQL=Netsis_SQL+" ,CA.[CARI_ISIM] "
                                                Netsis_SQL=Netsis_SQL+" ,MAS.KAPATILMIS "
                                                Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLSIPATRA] A WITH (NOLOCK) " 
                                                Netsis_SQL=Netsis_SQL+" LEFT JOIN (SELECT * FROM ["+currentDB+"].[dbo].[TBLISEMRI] WITH (NOLOCK) WHERE STOK_KODU='"&url_item&"') B ON FISNO=SIPARIS_NO " 
                                                Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP 1 * FROM ["+currentDB+"].[dbo].[TBLSSATIRAC] C2  WITH (NOLOCK) WHERE C2.INCKEYNO=A.INCKEYNO  ) C "
                                                Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] ST WITH (NOLOCK) ON A.STOK_KODU=ST.STOK_KODU "
                                                Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] CA  WITH (NOLOCK)  ON CA.CARI_KOD=A.STHAR_CARIKOD "
                                                Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].[TBLSIPAMAS] MAS WITH (NOLOCK) ON MAS.FATIRS_NO=A.FISNO "
                                                Netsis_SQL=Netsis_SQL+" WHERE A.STOK_KODU ='"&url_item&"' AND A.SUBE_KODU=1 ORDER BY A.STHAR_TESTAR " 

                                            ' SQL ende
                                            sira=0
                                            sira2=0
                                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                                do until NetsisRecordSet.EOF OR sira>=5000

                                                    if sira2=0 then 'başlık yaz '                                     %>
                                                        <tr>
                                                        <th>Sıra</th>
                                                        <th>Şube</th>
                                                        <th>Yükleme Tarihi</th>
                                                        <th>Teslim Tarihi</th>
                                                        <th>Sipariş No</th>
                                                        <th>Kapalı?</th>
                                                        <th>Ax. Sip. No</th>
                                                        <th>Cari</th>
                                                        <th>Stok Kartı</th>
                                                        <th>G/Ç</th>
                                                        <th>Miktar</th>
                                                        <th>Sevk Edilen</th>
                                                        <th>Birim</th>
                                                        <th>Fiyat ₺</th>
                                                        <th colspan=2>Fiyat</th>
                                                        </tr><%
                                                    end if
                                                    sira2=1
                                                   
                                                    if NetsisRecordSet("sipariskapali")="K" then kapali=" class='alert alert-success'  title=' Sipariş kapatılmış! ' "  else  kapali=""
                                                    if NetsisRecordSet("sipariskapali")<>"K" OR instr(UserLevel,"a")  then                                                      
                                                        Sira=sira+1 %>   
                                                        <tr <%=kapali%>>
                                                        <td><%=Sira%></td>
                                                        <td><%=NetsisRecordSet("SUBE_KODU")%></td>
                                                        <td><%=NetsisRecordSet("IRSALIYE_TARIH")%></td>
                                                        <td><%=NetsisRecordSet("STHAR_TESTAR")%></td>
                                                        <td><%=NetsisRecordSet("FISNO")%></td>
                                                        <td><%=NetsisRecordSet("sipariskapali")%></td>
                                                        <td><%=NetsisRecordSet("ACIKLAMA1")%></td>
                                                        <td style="font-size:10px;"><%=NetsisRecordSet("STHAR_CARIKOD")%><br><%=NetsisRecordSet("CARI_ISIM")%></td>
                                                        <td><%=NetsisRecordSet("STOK_KODU")%></td>
                                                        <td><%=NetsisRecordSet("STHAR_GCKOD")%></td>
                                                        <td><%=NetsisRecordSet("STHAR_GCMIK")%></td>
                                                        <td><%=NetsisRecordSet("FIRMA_DOVTUT")%></td>
                                                        <td><%=NetsisRecordSet("Birim")%></td>
                                                        <td><%=NetsisRecordSet("STHAR_NF")%></td>
                                                        <td><%=NetsisRecordSet("STHAR_DOVFIAT")%></td>
                                                        <td><%=parabirimi(NetsisRecordSet("STHAR_DOVTIP"))%></td>
                                                        </tr>        
                                                        <%
                                                    end if
                                                    NetsisRecordSet.movenext
                                                Loop
                                            NetsisRecordSet.close
                                            if sira=0 then Response.write("null") 
                                            if sira=5000 then Response.write("<tr><td colspan=3>Max. 5000 kayıt gösterilmiştir. </td></tr>") 
                                            %>
                                        </table>
                                    </div>          
                                </div>                            
                                <div class="container-fluid p-4"> <!--  Tekilleştirme  -->
                                       <%
                                        Netsis_SQL="	SELECT A.[AX_KOD]																"
                                        Netsis_SQL=Netsis_SQL+"	,A.[NETSIS_KOD] "
                                        Netsis_SQL=Netsis_SQL+"	,C1.[STOK_ADI] "
                                        Netsis_SQL=Netsis_SQL+"	,D2.[DESCRIPTION] "
                                        Netsis_SQL=Netsis_SQL+"	FROM ["+currentDB+"].[dbo].[PLT_TEKILLESEN_KODLAR_2022] A		 with (NOLOCK) 				"
                                        Netsis_SQL=Netsis_SQL+"	LEFT JOIN  [MicrosoftDynamicsAX].[dbo].[INVENTTABLE] C2  with (NOLOCK) ON C2.[ITEMID]=A.[AX_KOD]		"
                                        Netsis_SQL=Netsis_SQL+"	LEFT JOIN  ["+currentDB+"].[dbo].[TBLSTSABIT] C1  with (NOLOCK) ON C1.[STOK_KODU]=A.[NETSIS_KOD]		"
                                        Netsis_SQL=Netsis_SQL+"	LEFT JOIN  (SELECT * FROM [MicrosoftDynamicsAX].[dbo].[ECORESPRODUCTTRANSLATION]  with (NOLOCK) WHERE [LANGUAGEID]='en-us') D2 ON D2.[PRODUCT]=C2.[PRODUCT]  "
                                        Netsis_SQL=Netsis_SQL+"	WHERE A.[AX_KOD]='"&url_item&"' OR A.[NETSIS_KOD]='"&url_item&"'"
                                        sira=0
                                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                            do until NetsisRecordSet.EOF OR sira>=5000
                                                if sira=0 then 'başlık yaz '                                     %>
                                                    <strong>Tekilleştirme var mı?</strong>          
                                                    <table class="table table-sm table-striped table-hover align-middle">
                                                    <tr>
                                                        <th>Sıra</th><th>Eski Axapta kodu</th>
                                                        <th></th>
                                                        <th>Netsis 2022 yeni kodu</th>
                                                        <th></th>
                                                    </tr><%
                                                end if
                                                Sira=sira+1 %>  
                                                <tr>
                                                    <td><%=Sira%></td>
                                                    <td><%=NetsisRecordSet("AX_KOD")%></td>
                                                    <td><%=NetsisRecordSet("DESCRIPTION")%></td>
                                                    <td><%=NetsisRecordSet("NETSIS_KOD")%></td>
                                                    <td><%=NetsisRecordSet("STOK_ADI")%></td>
                                                </tr>                  <%
                                                NetsisRecordSet.movenext
                                            Loop
                                        NetsisRecordSet.close
                                        if sira>0 then Response.write("</table>")    %>
                                    
                                </div>      <%
                           

                        
                           
                            end if 
                        end if 
                    end if   ' end kullanım yeri     
                end if  
                NetsisConnection.Close
                Set NetsisRecordSet = Nothing
                Set NetsisConnection = Nothing      %>
            </div>        <%        
        else ' view end '
            response.write ("improve your level")
        end if  
    %>
    <script>
let table = new DataTable('#tblBikeList', {
     "lengthMenu": [[10, 100 , -1], [ 10, 100, "All"]]
   // options
});

</script>
    <!-- #include file="./include/footer.asp" -->
