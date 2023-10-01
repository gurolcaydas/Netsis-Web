<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Fiyat Listesi Satırları" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"f") then 'needed level'   %>         
    <div class="container-fluid" style="margin-top:80px"> <%
        %>
        <!-- #include file="./subs/dbcon.asp" -->
        <%
        search_bisiklet = BeniKoddanArindir(request.form("search_bisiklet"))
        search_bisiklet_kodu = BeniKoddanArindir(request.form("search_bisiklet_kodu"))
        search_liste_kodu = BeniKoddanArindir(request.form("search_liste_kodu"))
        search_cari_kod = BeniKoddanArindir(request.form("search_cari_kod"))
        search_cari = BeniKoddanArindir(request.form("search_cari"))
        search_AS = BeniKoddanArindir(request.form("search_AS"))
        if len(search_liste_kodu)=0 then search_liste_kodu = request.querystring("search_liste_kodu")        

        if url_doo="" or url_doo="list" then

            %>
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"><h4>Fiyat listesi satırları</h4>         
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_liste_kodu" placeholder="Fiyat listesi kodu"  value="<%=search_liste_kodu%>">
                            <input class="form-control" type="text" name="search_cari_kod"  placeholder="Cari Kodu"  value="<%=search_cari_kod%>">
                            <input class="form-control" type="text" name="search_cari"  placeholder="Cari"  value="<%=search_cari%>">
                            <input class="form-control" type="text" name="search_bisiklet_kodu" placeholder="Stok kodu"  value="<%=search_bisiklet_kodu%>">
                            <input class="form-control" type="text" name="search_bisiklet"  placeholder="Açıklama"  value="<%=search_bisiklet%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
            <%
        end if
        if url_doo="list" and (search_bisiklet_kodu&search_bisiklet<>"" OR request.querystring("detay")=1) then 'alanlar boş ise sakın arama'
            ' SQL 
                Netsis_SQL= " SELECT TOP 1000 "   
                Netsis_SQL=Netsis_SQL + " A.[FIYATLISTEKODU] "   
                Netsis_SQL=Netsis_SQL + " ,A.[STOKKODU] "   
                Netsis_SQL=Netsis_SQL + " ,E.[GRUP_ISIM] "   
                Netsis_SQL=Netsis_SQL + " ,D.[STOK_ADI] "   
                Netsis_SQL=Netsis_SQL + " ,A.[A_S] "   
                Netsis_SQL=Netsis_SQL + " ,A.[FIYAT1] "   
                Netsis_SQL=Netsis_SQL + " ,A.[FIYATDOVIZTIPI] "   
                Netsis_SQL=Netsis_SQL + " ,A.[BASTAR] "   
                Netsis_SQL=Netsis_SQL + " ,A.[BITTAR] "   
                Netsis_SQL=Netsis_SQL + " ,A.[OLCUBR] "   
                Netsis_SQL=Netsis_SQL + " ,D.[OLCU_BR1] "   
                Netsis_SQL=Netsis_SQL + " ,D.[OLCU_BR2] "   
                Netsis_SQL=Netsis_SQL + " ,D.[OLCU_BR3] "   
                Netsis_SQL=Netsis_SQL + " ,A.[FIYATGRUBU] "   
                Netsis_SQL=Netsis_SQL + " ,C.[CARI_ISIM] "   
                Netsis_SQL=Netsis_SQL + " ,A.[ISLETME_KODU] "
                Netsis_SQL=Netsis_SQL + " ,A.[SUBE_KODU] "
                Netsis_SQL=Netsis_SQL + " ,A.[KAYIT_SUBE_KODU] "
                Netsis_SQL=Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] A  WITH (NOLOCK) "   
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLFIATGRUP] B  WITH (NOLOCK) ON B.[FGRUP]=A.[FIYATGRUBU] "   
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] C  WITH (NOLOCK) ON B.[FGRUP]=C.[CARI_KOD] "   
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTSABIT] D  WITH (NOLOCK) ON D.[STOK_KODU]=A.[STOKKODU] "   
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLSTOKKOD1] E  WITH (NOLOCK) ON D.[KOD_1]=E.[GRUP_KOD] "   
                Netsis_SQL=Netsis_SQL + " WHERE  A.[A_S] ='A'   "   
                if len(search_bisiklet_kodu)>0 then     
                    if instr(search_bisiklet_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [STOK_KODU] LIKE '"&search_bisiklet_kodu&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [STOK_KODU] LIKE '%" &search_bisiklet_kodu&"%' " 
                    end if 
                end if 
                if len(search_liste_kodu)>0 then     
                    if instr(search_liste_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [FIYATLISTEKODU] LIKE '"&search_liste_kodu&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [FIYATLISTEKODU] LIKE '%" &search_liste_kodu&"%' " 
                    end if 
                end if 
                if len(search_cari_kod)>0 then     
                    if instr(search_cari_kod,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND A.[FIYATGRUBU] LIKE '" &search_cari_kod&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND A.[FIYATGRUBU] LIKE '%" &search_cari_kod&"%' " 
                    end if 
                end if                 
                if len(search_bisiklet)>0 then     
                    if instr(search_bisiklet,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [STOK_ADI] LIKE '" &search_bisiklet&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [STOK_ADI] LIKE '%" &search_bisiklet&"%' " 
                    end if 
                end if 
                if len(search_cari)>0 then     
                    if instr(search_cari,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '" &search_cari&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '%" &search_cari&"%' " 
                    end if 
                end if 
                if len(search_AS)>0 then   ' sadece eşitlikte aramalı A ya da S
                        Netsis_SQL=Netsis_SQL+" AND [A_S] ='" &search_AS&"' " 
                end if                 
                Netsis_SQL=Netsis_SQL + " ORDER BY A.STOKKODU, A.BASTAR DESC, C.[CARI_ISIM] "
            ' SQL ende
            'Response.write(Netsis_SQL)
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            sira=0 
                do until NetsisRecordSet.EOF OR sira>=1000
                    if sira=0 then                     %>
                        <div class="container-fluid p-4"> 
                        <button class="btn btn-success m-2" onclick="exportTableToExcel('tblData')"><i class="bi bi-file-earmark-arrow-down-fill"></i> Excel</button>
                        <table class="table table-sm table-striped table-hover align-middle" id="tblData">  
                         <thead>              <tr>
                        <th colspan=2>Sıra</th> 
                        <th>Liste No</th> 
                        <th colspan=3>Cari</th> 
                        <th colspan=3>Kod</th> 
                    </tr>     </thead><%
                    end if 
                    sira=sira+1 
                    SELECT CASE NetsisRecordSet("ISLETME_KODU")
                        CASE 0
                            sirket="Merkez"
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
                    %>
                    <tr>
                        <td class="text-secondary"><%=sira%></td>
                        <td class="text-primary"><b><%=NetsisRecordSet("A_S")%></b></td>
                        <td><%=NetsisRecordSet("FIYATLISTEKODU")%>
                                                        <a  href="?doo=list&detay=1&search_liste_kodu=<%=NetsisRecordSet("FIYATLISTEKODU")%>" title="Fiyat Listesini görüntüle" >
                                                            <div class="badge badge-pill bg-info">
                                                                <i class="bi bi-card-list"></i> 
                                                            </div>
                                                        </a>                         
                        
                        
                        </td>
                        <td class="small"><%=NetsisRecordSet("FIYATGRUBU")%></td>
                        <td class="small"><%=NetsisRecordSet("CARI_ISIM")%></td>
                        <td class="small"><div class="badge badge-pill bg-secondary" title=" "><%=sirket%>&nbsp;/&nbsp;<%=sube%></div></td>
                        <td><%=NetsisRecordSet("STOKKODU")%></td>
                        <td class="text-success"><b><%=NetsisRecordSet("GRUP_ISIM")%></b></td>
                        <td class="small"><%=replace(NetsisRecordSet("STOK_ADI"),"#"," &bull; ")%></td>
                        <!-- <td><%=NetsisRecordSet("A_S")%></td> -->
                        <td><%=NetsisRecordSet("FIYAT1")%></td>
                        <td><%=parabirimi(NetsisRecordSet("FIYATDOVIZTIPI"))%></td>
                        <td><%
                        SELECT CASE NetsisRecordSet("OLCUBR")
                            case 1
                                response.write(NetsisRecordSet("OLCU_BR1"))
                            case 2
                                response.write(NetsisRecordSet("OLCU_BR2"))
                            case 3
                                response.write(NetsisRecordSet("OLCU_BR3"))

                        END SELECT
                        'response.write(NetsisRecordSet("OLCUBR"))
                        %> </td>
                        <td class="small"><%=NetsisRecordSet("BASTAR")%><br><%=NetsisRecordSet("BITTAR")%></td>
                    </tr>                             <%
                    NetsisRecordSet.movenext
                Loop                                                
            NetsisRecordSet.close  
            if sira=0 then response.write ("Kayıt bulunamadı.")     
            if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> </div><%
        end if  	
        if url_doo="list" and (search_bisiklet_kodu&search_bisiklet="" and search_cari_kod&search_cari&search_liste_kodu<>"") then 'Sadece cari ve liste numaması ile arama'
            ' SQL 
                Netsis_SQL= " SELECT TOP 1000 "   
                Netsis_SQL=Netsis_SQL + " A.[FIYATLISTEKODU] "   
                Netsis_SQL=Netsis_SQL + " ,A.[A_S] "   
                Netsis_SQL=Netsis_SQL + " ,A.[BASTAR] "   
                Netsis_SQL=Netsis_SQL + " ,A.[BITTAR] "   
                Netsis_SQL=Netsis_SQL + " ,A.[FIYATGRUBU] "   
                Netsis_SQL=Netsis_SQL + " ,C.[CARI_ISIM] "   
                Netsis_SQL=Netsis_SQL + " ,A.[ISLETME_KODU] "
                Netsis_SQL=Netsis_SQL + " ,A.[SUBE_KODU] "
                Netsis_SQL=Netsis_SQL + " ,A.[KAYIT_SUBE_KODU] "
                Netsis_SQL=Netsis_SQL + " ,A.[FIYATLISTEACIK]"
                Netsis_SQL=Netsis_SQL + " FROM ["+currentDB+"].[dbo].[TBLSTOKFIAT] A  WITH (NOLOCK) "   
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLFIATGRUP] B WITH (NOLOCK)  ON B.[FGRUP]=A.[FIYATGRUBU] "   
                Netsis_SQL=Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].[TBLCASABIT] C WITH (NOLOCK)  ON B.[FGRUP]=C.[CARI_KOD] "   
                Netsis_SQL=Netsis_SQL + " WHERE  A.[A_S] ='A'   "   
                if len(search_liste_kodu)>0 then     
                    if instr(search_liste_kodu,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [FIYATLISTEKODU] LIKE '"&search_liste_kodu&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [FIYATLISTEKODU] LIKE '%" &search_liste_kodu&"%' " 
                    end if 
                end if 
                if len(search_cari_kod)>0 then     
                    if instr(search_cari_kod,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND A.[FIYATGRUBU] LIKE '" &search_cari_kod&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND A.[FIYATGRUBU] LIKE '%" &search_cari_kod&"%' " 
                    end if 
                end if 
                if len(search_cari)>0 then     
                    if instr(search_cari,"%") then  ' hem % ile hem (default % koyup) %siz arama için
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '" &search_cari&"' " 
                    else 
                        Netsis_SQL=Netsis_SQL+" AND [CARI_ISIM] LIKE '%" &search_cari&"%' " 
                    end if 
                end if 
                if len(search_AS)>0 then   ' sadece eşitlikte aramalı A ya da S
                        Netsis_SQL=Netsis_SQL+" AND [A_S] ='" &search_AS&"' " 
                end if                 
                Netsis_SQL=Netsis_SQL + " GROUP BY  A.[FIYATLISTEKODU],A.[A_S],A.[BASTAR],A.[BITTAR],A.[FIYATGRUBU],C.[CARI_ISIM]  "
                Netsis_SQL=Netsis_SQL + " ,A.[ISLETME_KODU]  ,A.[SUBE_KODU]  ,A.[KAYIT_SUBE_KODU] ,A.[FIYATLISTEACIK] "

                Netsis_SQL=Netsis_SQL + " ORDER BY A.BASTAR DESC, C.[CARI_ISIM] "
            ' SQL ende
            'response.write(Netsis_SQL)
            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
            sira=0 
                do until NetsisRecordSet.EOF OR sira>=1000
                    sirket=""
                    sube=""
                    SELECT CASE NetsisRecordSet("ISLETME_KODU")
                        CASE 0
                            sirket="Merkez"
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
                    if sira=0 then %>
                        <div class="container-fluid p-4"> 
                        <table class="table table-sm table-striped table-hover align-middle">  <%
                    end if 
                    sira=sira+1                                     %>
                    <tr>
                        <td class="text-secondary"><%=sira%></td>
                        <td class="text-primary"><b><%=NetsisRecordSet("A_S")%></b></td>
                        <td><%=NetsisRecordSet("FIYATLISTEKODU")%>
                            <a  href="?doo=list&detay=1&search_liste_kodu=<%=NetsisRecordSet("FIYATLISTEKODU")%>" title="Fiyat Listesini görüntüle" >
                                <div class="badge badge-pill bg-info">
                                    <i class="bi bi-card-list"></i> 
                                </div>
                            </a>                         
                        </td>
                        <td class="small"><%=NetsisRecordSet("FIYATLISTEACIK")%></td>
                        <td class="small"><%=NetsisRecordSet("FIYATGRUBU")%></td>
                        <td class="small"><%=NetsisRecordSet("CARI_ISIM")%></td>
                        <td class="small"><div class="badge badge-pill bg-secondary" title=" "><%=sirket%>&nbsp;/&nbsp;<%=sube%></div></td>
                        <td class="small"><%=NetsisRecordSet("BASTAR")%><br><%=NetsisRecordSet("BITTAR")%></td>
                    </tr>                             <%
                    NetsisRecordSet.movenext
                Loop                                                
            NetsisRecordSet.close  
            if sira=0 then response.write ("Kayıt bulunamadı...")     
            if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> </div><%
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

<!-- #include file="./include/footer.asp" -->