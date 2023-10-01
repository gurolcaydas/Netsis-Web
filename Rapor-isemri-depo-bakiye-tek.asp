<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="İş Ermi - Bakiye" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   

    search_is_emri = BeniKoddanArindir(request.form("search_is_emri")) %>         
    <div class="container-fluid" style="margin-top:80px"> 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal" method="POST" action="?doo=list">
                    <div class="container-fluid p-4"> <h3>İş Emri - Depo Bakiye Kontrol</h3>
                        <div class="input-group">
                            <input class="form-control" type="text" name="search_is_emri"  placeholder="İş Emri No"  value="<%=search_is_emri%>">
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>                           
                </form> 
        <% if LEN(search_is_emri)+LEN(search_is_emri)>0 then  %>
        <div class="container-fluid p-4"> 
            <table class="table table-sm table-striped table-hover align-middle">         <%
                ' SQL   


Netsis_SQL=" SELECT  I.ISEMRINO as 'İş Emri',I.STOK_KODU as 'Mamül Kod',I.MIKTAR as 'Miktar',ISNULL(URETIM.URETILEN,0) as 'Üretilmiş',  K.GRUP_ISIM  as 'Madde',R.HAM_KODU as 'Kod',"
Netsis_SQL=Netsis_SQL+" T.STOK_ADI as 'Açıklama', R.MIKTAR  as 'Reçete Miktarı', (I.MIKTAR-ISNULL(URETIM.URETILEN,0)) *R.MIKTAR  as 'Gereken Miktar' ,  R.DEPO_KODU  as 'Depo', "
Netsis_SQL=Netsis_SQL+" S.TOP_GIRIS_MIK-S.TOP_CIKIS_MIK  as 'Depodaki',S2.TOP_GIRIS_MIK-S2.TOP_CIKIS_MIK  as 'Stok', "
Netsis_SQL=Netsis_SQL+" CASE WHEN  (I.MIKTAR-ISNULL(URETIM.URETILEN,0)) *R.MIKTAR >  S.TOP_GIRIS_MIK-S.TOP_CIKIS_MIK THEN 'DEPO YETERSIZ' ELSE 'SORUN YOK' "
Netsis_SQL=Netsis_SQL+" END   as 'Durum' "
Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].TBLISEMRIREC R "
Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].TBLISEMRI I ON R.ISEMRINO=I.ISEMRINO AND I.STOK_KODU=R.MAMUL_KODU "
Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].TBLSTOKPH S ON R.HAM_KODU=S.STOK_KODU AND S.DEPO_KODU=R.DEPO_KODU "
Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].TBLSTOKPH S2 ON R.HAM_KODU=S2.STOK_KODU AND S2.DEPO_KODU=0 "
Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].TBLSTSABIT T ON T.STOK_KODU=R.HAM_KODU "
Netsis_SQL=Netsis_SQL+" INNER JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 K ON  T.KOD_1=K.GRUP_KOD "
Netsis_SQL=Netsis_SQL+" OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WHERE  R.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=I.STOK_KODU  GROUP BY U.URETSON_SIPNO,U.URETSON_MAMUL ) AS URETIM "
Netsis_SQL=Netsis_SQL+" WHERE R.GEC_FLAG=0 AND S.SUBE_KODU=1   AND S2.SUBE_KODU=1 "



                    if LEN(search_is_emri)>0 then 
                        if instr(search_is_emri,"%") then 
                        Netsis_SQL=Netsis_SQL+"   AND I.ISEMRINO LIKE '"&search_is_emri&"' "
                        else
                        Netsis_SQL=Netsis_SQL+"   AND I.ISEMRINO LIKE '%"&search_is_emri&"%' "
                        end if
                    end if
                    

                    Netsis_SQL=Netsis_SQL+" ORDER BY  R.HAM_KODU   					  "
                ' SQL ende

                NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                    sira=0 
                    do until NetsisRecordSet.EOF OR sira>=1000
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