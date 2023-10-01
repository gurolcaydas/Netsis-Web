<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="İş Emri - Depo Bakiye" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<!-- #include file="./subs/dbcon.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   
doo = request.querystring("doo")



    if doo="isemri" then
        search_is_emri = temizle(request.form("search_is_emri")) 
    end if

    if doo="tekisemri" then
        search_is_emri = request.querystring("isemri")
    end if

    if doo="siparis" then
        siparis = request.querystring("siparis")
        search_is_emri = ""
        Netsis_SQL=Netsis_SQL+" SELECT 								 "
        Netsis_SQL=Netsis_SQL+" [ISEMRINO]      					 "
        Netsis_SQL=Netsis_SQL+" ,[SIPARIS_NO]						 "
        Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].[TBLISEMRI]	 "
        Netsis_SQL=Netsis_SQL+" WHERE SIPARIS_NO = '" & siparis & "' "
        NetsisRecordSet.Open Netsis_SQL, NetsisConnection
            sira=0 
            do until NetsisRecordSet.EOF OR sira>=1000
                sira=sira+1      
                search_is_emri = search_is_emri + " " + NetsisRecordSet("ISEMRINO")
                NetsisRecordSet.MoveNext
            loop
        NetsisRecordSet.close
    end if


    %>         
    <div class="container-fluid" style="margin-top:80px"> 
                <form class="form-horizontal" method="POST" action="?doo=isemri">
    <div class="container-fluid p-4"> <h3>İş Emri - Depo Bakiye Kontrol</h3>
        <%

        isaretli = request.form("optradio")
        if isaretli="option2" then 
            option22="checked" 
            option11=""
        else 
         option11="checked"
         option22=""

        end if
        %>
        <div class="input-group">
            <textarea class="form-control z-depth-1" name="search_is_emri" rows="3" placeholder="İş Emirleri"><%=search_is_emri%></textarea>
            
            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
        </div>
        <div class="form-check">
            <input type="radio" class="form-check-input" id="radio1" name="optradio" value="option1" <%=option11%> >Madde koduna göre toplu listele
            <label class="form-check-label" for="radio1"></label>
          </div>
          <div class="form-check">
            <input type="radio" class="form-check-input" id="radio2" name="optradio" value="option2"  <%=option22%>>İşemirlerine göre ayrı listele
            <label class="form-check-label" for="radio2"></label>
          </div>
    </div>           
                </form> 
        <% 

        if LEN(search_is_emri)+LEN(search_is_emri)>0 then  

        aranacak_is_emri=trim(search_is_emri)
        aranacak_is_emri=Replace(aranacak_is_emri, " ", "','")
        aranacak_is_emri="'"+aranacak_is_emri+"'"    
        %>
        <div class="container-fluid p-4"> 
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   
    Netsis_SQL= " SELECT STOK_KODU,ISEMRINO"
    Netsis_SQL=Netsis_SQL+" ,R.MIKTAR,URETIM.URETILEN,R.SIPARIS_NO"
    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].TBLISEMRI R "
    Netsis_SQL=Netsis_SQL+" OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  R.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=R.STOK_KODU) AS URETIM   "
    Netsis_SQL=Netsis_SQL+" WHERE  ISEMRINO IN "
    Netsis_SQL=Netsis_SQL+" ("+aranacak_is_emri+")           "
    Netsis_SQL=Netsis_SQL+" ORDER BY STOK_KODU "
                ' SQL ende

                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
    sira=0 
    do until NetsisRecordSet.EOF OR sira>=1000
        if sira=0 then         %>
            <thead><tr> 
            <th>Sıra</th>
            <th>Stok Kodu</th>
            <th>İş Emri No</th>
            <th>Miktar</th>
            <th>Üretilen</th>
            <th>Sipariş No</th>
            
            </tr></thead>  <%
        end if 
        sira=sira+1      
        %>  <tr><td><%=sira%></td>
            <td><%=NetsisRecordSet("STOK_KODU")%></td>
            <td><%=NetsisRecordSet("ISEMRINO")%> <a href="Rapor-isemri-depo-bakiye.asp?doo=tekisemri&isemri=<%=NetsisRecordSet("ISEMRINO")%>"><i class="bi bi-binoculars"></i></a></td>
            <td><%=NetsisRecordSet("MIKTAR")%></td> 
            <td><%=NetsisRecordSet("URETILEN")%></td> 
            <td><%=NetsisRecordSet("SIPARIS_NO")%> <a href="Rapor-isemri-depo-bakiye.asp?doo=siparis&siparis=<%=NetsisRecordSet("SIPARIS_NO")%>"><i class="bi bi-binoculars"></i></a></td>
            </tr>
            <%
        NetsisRecordSet.MoveNext
    loop
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>
        <div class="container-fluid p-4"> 
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   
                if isaretli<>"option2" then
                    Netsis_SQL= " SELECT           "
                    Netsis_SQL=Netsis_SQL+"  K.GRUP_ISIM        "
                    Netsis_SQL=Netsis_SQL+"  ,R.HAM_KODU        "
                    Netsis_SQL=Netsis_SQL+"  ,T.STOK_ADI        "
                    Netsis_SQL=Netsis_SQL+"  ,SUM((I.MIKTAR) *R.MIKTAR) AS Hesaplanan_MIKTAR          "
                    Netsis_SQL=Netsis_SQL+"  ,SUM((I.MIKTAR-ISNULL(URETIM.URETILEN,0)) *R.MIKTAR) AS GEREKEN_MIKTAR          "
                    Netsis_SQL=Netsis_SQL+"  ,R.DEPO_KODU        "
                    Netsis_SQL=Netsis_SQL+"  ,S.Depo_Mik        "
                    Netsis_SQL=Netsis_SQL+"  ,S2.Stok_Mik-ISNULL(S3.Stok_Mik101,0) as 'Stok_' "
                    Netsis_SQL=Netsis_SQL+"  ,CASE WHEN SUM( (I.MIKTAR-ISNULL(URETIM.URETILEN,0)) *R.MIKTAR) > ISNULL(S.Depo_Mik,0) THEN 'DEPO YETERSIZ' ELSE 'OK' END  DEPO_DURUM          "
                    Netsis_SQL=Netsis_SQL+"  ,CASE WHEN SUM( (I.MIKTAR-ISNULL(URETIM.URETILEN,0)) *R.MIKTAR) > ISNULL(S2.Stok_Mik,0) THEN 'STOK YETERSIZ' ELSE 'OK' END  STOK_DURUM         "
                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].TBLISEMRIREC R  WITH (NOLOCK)   "
                    Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].TBLISEMRI I WITH (NOLOCK) ON R.ISEMRINO=I.ISEMRINO AND I.STOK_KODU=R.MAMUL_KODU     "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP_GIRIS_MIK-TOP_CIKIS_MIK AS Depo_Mik FROM ["+currentDB+"].[dbo].TBLSTOKPH SX WHERE  R.HAM_KODU=SX.STOK_KODU AND SX.DEPO_KODU=R.DEPO_KODU AND SX.SUBE_KODU=1   ) AS S "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP_GIRIS_MIK-TOP_CIKIS_MIK AS Stok_Mik FROM ["+currentDB+"].[dbo].TBLSTOKPH SY WHERE  R.HAM_KODU=SY.STOK_KODU AND SY.DEPO_KODU=0 AND SY.SUBE_KODU=1 ) AS S2      "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP_GIRIS_MIK-TOP_CIKIS_MIK AS Stok_Mik101 FROM ["+currentDB+"].[dbo].TBLSTOKPH SZ WHERE  R.HAM_KODU=SZ.STOK_KODU AND SZ.DEPO_KODU=0 AND SZ.SUBE_KODU=101 ) AS S3      "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].TBLSTSABIT T WITH (NOLOCK) ON T.STOK_KODU=R.HAM_KODU             "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 K WITH (NOLOCK) ON  T.KOD_1=K.GRUP_KOD             "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  R.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=I.STOK_KODU) AS URETIM   "
                    Netsis_SQL=Netsis_SQL+" WHERE R.GEC_FLAG=0         "
                    Netsis_SQL=Netsis_SQL+" AND I.ISEMRINO IN          "
                    Netsis_SQL=Netsis_SQL+" ("+aranacak_is_emri+")           "
                    Netsis_SQL=Netsis_SQL+" GROUP BY R.HAM_KODU,R.DEPO_KODU,K.GRUP_ISIM,T.STOK_ADI               "
                    Netsis_SQL=Netsis_SQL+" ,S.Depo_Mik,S2.Stok_mik,S3.Stok_Mik101       "
                    Netsis_SQL=Netsis_SQL+" ORDER BY R.HAM_KODU        "        
                else
                Netsis_SQL= " SELECT           "
                    Netsis_SQL=Netsis_SQL+"  K.GRUP_ISIM,R.ISEMRINO        "
                    Netsis_SQL=Netsis_SQL+"  ,R.HAM_KODU        "
                    Netsis_SQL=Netsis_SQL+"  ,T.STOK_ADI        "
                    Netsis_SQL=Netsis_SQL+"  ,((I.MIKTAR) *R.MIKTAR) AS Hesaplanan_MIKTAR          "
                    Netsis_SQL=Netsis_SQL+"  ,((I.MIKTAR-ISNULL(URETIM.URETILEN,0)) *R.MIKTAR) AS GEREKEN_MIKTAR          "
                    Netsis_SQL=Netsis_SQL+"  ,R.DEPO_KODU        "
                    Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].TBLISEMRIREC R  WITH (NOLOCK)   "
                    Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].TBLISEMRI I WITH (NOLOCK) ON R.ISEMRINO=I.ISEMRINO AND I.STOK_KODU=R.MAMUL_KODU     "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP_GIRIS_MIK-TOP_CIKIS_MIK AS Depo_Mik FROM ["+currentDB+"].[dbo].TBLSTOKPH SX WHERE  R.HAM_KODU=SX.STOK_KODU AND SX.DEPO_KODU=R.DEPO_KODU AND SX.SUBE_KODU=1   ) AS S "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP_GIRIS_MIK-TOP_CIKIS_MIK AS Stok_Mik FROM ["+currentDB+"].[dbo].TBLSTOKPH SY WHERE  R.HAM_KODU=SY.STOK_KODU AND SY.DEPO_KODU=0 AND SY.SUBE_KODU=1 ) AS S2      "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY (SELECT TOP_GIRIS_MIK-TOP_CIKIS_MIK AS Stok_Mik101 FROM ["+currentDB+"].[dbo].TBLSTOKPH SZ WHERE  R.HAM_KODU=SZ.STOK_KODU AND SZ.DEPO_KODU=0 AND SZ.SUBE_KODU=101 ) AS S3      "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].TBLSTSABIT T WITH (NOLOCK) ON T.STOK_KODU=R.HAM_KODU             "
                    Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 K WITH (NOLOCK) ON  T.KOD_1=K.GRUP_KOD             "
                    Netsis_SQL=Netsis_SQL+" OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  R.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=I.STOK_KODU) AS URETIM   "
                    Netsis_SQL=Netsis_SQL+" WHERE R.GEC_FLAG=0         "
                    Netsis_SQL=Netsis_SQL+" AND I.ISEMRINO IN          "
                    Netsis_SQL=Netsis_SQL+" ("+aranacak_is_emri+")           " 
                    Netsis_SQL=Netsis_SQL+" ORDER BY R.HAM_KODU        "              
                end if
                ' SQL ende 


                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
    sira=0 
    do until NetsisRecordSet.EOF OR sira>=1000
        if sira=0 then         %>
            <thead><tr> <%
            Response.Write("<th>Sıra</th>")
            for each x in  NetsisRecordSet.Fields
                Response.Write("<th>" & x.name & "</th>")
            next    %>
            </tr></thead>  <%
        end if 
        sira=sira+1      
        Response.Write(" <tr><td>"&sira&"</td>")
        for each x in  NetsisRecordSet.Fields
            'Response.Write(x.name)
            'Response.Write(" = ")
            Response.Write("<td class='text-nowrap'>" & x.value &"</td>")
            
        next
        NetsisRecordSet.MoveNext
    loop
    Response.Write(" </tr> ")
                NetsisRecordSet.close
                Response.Write(" </table> ")

                if sira=0 then response.write ("Kayıt bulunamadı...")     
                if sira=1000 then response.write ("<tr><td colspan=5>Max. 1000 kayıt görüntülendi.</td></tr>")     %> 
            </table> 
        </div>        
        <% end if %>        
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->