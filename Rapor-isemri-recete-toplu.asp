<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="İş Emri Reçeteleri Toplu Gösterim" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->
<%
if instr(UserLevel,"m") then 'needed level'   

 
        str = (request.form("search_is_emri")) 
        ' for x=1 to len(str)
        '     aaa = aaa & (asc(mid(str,x,1)) & "*")
        ' next
        str=Replace(str,vbCrLf, " ")       
        str=Replace(str,Chr(9), " ")        
        str=Replace(str,Chr(10), " ")        
        str=Replace(str,Chr(11), " ")        
        str=Replace(str,Chr(12), " ")        
        str=Replace(str,Chr(13), " ")        
        str=Replace(str,Chr(44), " ")        
        str=Replace(str, """", " ")
        str=Replace(str, "'", " ")
        str=Replace(str, "‚", " ")
    
        i=0
            Do While i<>LEN(str) ' çift space kontrol
                    i=LEN(str)
                    str=Replace(str, "  ", " ")
            Loop
        str=trim(str)

        ' aaa=aaa & "*<br>*"
        ' for x=1 to len(str)
        '     aaa = aaa & (asc(mid(str,x,1)) & "*")
        ' next 
        isaretli = request.form("optradio")
        if isaretli="option1" then 
            option11="checked" 
            option22=""
        else 
         option22="checked"
         option11=""

        end if
    
    
     %>         
    <div class="container-fluid  d-print-none" style="margin-top:80px;"> 
    </div>
    <div class="container-fluid" > 
        <!-- #include file="./subs/dbcon.asp" -->
                <form class="form-horizontal d-print-none" method="POST" action="?doo=list">
                    <div class="container-fluid p-2"> <h3>İş Emri Reçeteleri Toplu Gösterim</h3>
                        <div class="input-group">
                            <textarea class="form-control z-depth-1" name="search_is_emri" rows="3" placeholder="İş Emirleri"><%=str%></textarea>
                            <input class="btn btn-secondary" type="submit"  name="B1" value="Ara">
                        </div>
                    </div>           
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="radio1" name="optradio" value="option1"  <%=option11%>>Ürge reçete-İşemri reçete farklarını göster
                        <label class="form-check-label" for="radio1"></label>
                      </div>        
                      <div class="form-check">
                        <input type="radio" class="form-check-input" id="radio2" name="optradio" value="option2"  <%=option22%>>Gösterme
                        <label class="form-check-label" for="radio2"></label>
                      </div>                                   
                </form> 
        <%  if LEN(str)>0 then  
            
           a=Split(str)
            for each xisemri in a
                %>
                <div class="container-fluid p-2"  > 
                

                      <%
                        ' SQL   
                            Netsis_SQL= " SELECT "
                            Netsis_SQL=Netsis_SQL+" R.STOK_KODU as 'Stok_Kodu'"
                            Netsis_SQL=Netsis_SQL+" ,T.STOK_ADI as 'Stok Adı'"
                            Netsis_SQL=Netsis_SQL+" ,R.ISEMRINO as 'İş Emri'"
                            Netsis_SQL=Netsis_SQL+" ,R.REFISEMRINO as 'Ref. İş Emri'"
                            Netsis_SQL=Netsis_SQL+" ,R.ACIKLAMA as 'Önemli Açıklama' "
                            Netsis_SQL=Netsis_SQL+" ,K.[GRUP_ISIM] as 'Madde Grubu'"
                            Netsis_SQL=Netsis_SQL+" ,T.GRUP_KODU as 'Grup'"
                            Netsis_SQL=Netsis_SQL+" ,R.MIKTAR as 'Miktar'"
                            Netsis_SQL=Netsis_SQL+" ,URETIM.URETILEN as 'Üretilen'"
                            Netsis_SQL=Netsis_SQL+" FROM ["+currentDB+"].[dbo].TBLISEMRI R "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].TBLSTSABIT T WITH (NOLOCK) ON T.STOK_KODU=R.STOK_KODU "
                            Netsis_SQL=Netsis_SQL+" LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 K WITH (NOLOCK) ON K.[GRUP_KOD]=T.KOD_1 "
                            Netsis_SQL=Netsis_SQL+" OUTER APPLY ( SELECT SUM(URETSON_MIKTAR) AS URETILEN  FROM  ["+currentDB+"].[dbo].TBLSTOKURS U WITH (NOLOCK) WHERE  R.ISEMRINO =U.URETSON_SIPNO AND U.URETSON_MAMUL=R.STOK_KODU) AS URETIM   "
                            Netsis_SQL=Netsis_SQL+" WHERE  ISEMRINO ='"&xisemri&"' "
                            Netsis_SQL=Netsis_SQL+" ORDER BY R.STOK_KODU "
                        ' SQL ende

                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                            sira=0 
                            do until NetsisRecordSet.EOF OR sira>=1000
                            herisemri=xisemri
                            search_bom=NetsisRecordSet("Stok_Kodu")

                                if sira=0 then                         
                                    %>
                                    
                                    <style type="text/css">                                    
                                        *		{padding:0; margin:0;}
                                        svg		{border:1px #eee solid; display:inline-block; float:right;}
                                    </style>

                                    <script src="include/barcode.min.js"></script>
                                    <h2><%=xisemri%><span id="<%=xisemri%>" style="padding:10px;"></span></h2>
                                    <script>
                                    barcodeyaz('<%=xisemri%>')
                                    function barcodeyaz(str) {
                                        'use strict';
                                        var
                                        
                                        barcodes = [ BARCode({
                                                msg  : str
                                                ,dim  : [   500,  100 ] /* autowidth depends on the length of generated barcode. */
                                                ,pal  : ['#000','#fff']
                                            }) /* simple */                                            
                                        ];
                                        
                                        for( var c = 0; c < barcodes.length; c++ ) {
                                            document.getElementById("<%=xisemri%>").appendChild(barcodes[ c ] );
                                        }
                                        }
                                    </script>                                    <%
                                    if NetsisRecordSet("grup")="FP1" then response.write("<h4>Bisiklet</h4>") else  response.write("<h4>" &NetsisRecordSet("Madde Grubu")&"</h4>") %>
                                    <table class="table table-sm table-striped table-hover align-middle">     <thead><tr> <%
                                    'Response.Write("<th>Sıra</th>")
                                    for each x in  NetsisRecordSet.Fields
                                        Response.Write("<th  style='font-size:16px;'>" & x.name & "</th>")
                                    next                    %>
                                    </tr></thead>  <%
                                end if 
                                sira=sira+1      
                                Response.Write(" <tr>")
                                for each x in  NetsisRecordSet.Fields
                                    'Response.Write(x.name)
                                    'Response.Write(" = ")
                                    Response.Write("<td style='font-size:16px;'>" & x.value &"</td>")
                                    
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
                <div class="container-fluid p-2" style=" page-break-after: always; padding-top:0px;"> 
                    <table class="table table-sm table-striped table-hover align-middle">         <%
                        ' SQL   

                            Netsis_SQL=" 	SELECT 														   "
                            Netsis_SQL=Netsis_SQL+" 		A.[HAM_KODU] as 'Stok Kodu' "
                            Netsis_SQL=Netsis_SQL+"         ,K.[GRUP_ISIM] as 'Madde Grubu' "
                            Netsis_SQL=Netsis_SQL+"         ,LEFT(K2.[GRUP_ISIM],10) as 'Marka' "
                            Netsis_SQL=Netsis_SQL+" 		,T.STOK_ADI as 'Stok' "
                            Netsis_SQL=Netsis_SQL+" 		,A.[MIKTAR]	 as 'Miktar' "
                            Netsis_SQL=Netsis_SQL+" 		,T.OLCU_BR1	 as 'Birim' "
                            'Netsis_SQL=Netsis_SQL+" 		,A.[STOK_MALIYET]										   "
                            ' Netsis_SQL=Netsis_SQL+" 		,A.[OPNO]												   "
                            Netsis_SQL=Netsis_SQL+" 		,A.[ACIKLAMA] as 'Açıklama' "
                            ' Netsis_SQL=Netsis_SQL+" 		,A.[DEPO_KODU]											   "
                            ' Netsis_SQL=Netsis_SQL+" 		,A.GEC_FLAG												   "
                            Netsis_SQL=Netsis_SQL+" 	FROM ["+currentDB+"].[dbo].[TBLISEMRIREC] A WITH (NOLOCK)		   "
                            Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].TBLSTSABIT T WITH (NOLOCK) ON T.STOK_KODU=A.HAM_KODU "
                            Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 K WITH (NOLOCK) ON K.[GRUP_KOD]=T.KOD_1 "
                            Netsis_SQL=Netsis_SQL+" 	LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD2 K2 WITH (NOLOCK) ON K2.[GRUP_KOD]=T.KOD_2 "
                            Netsis_SQL=Netsis_SQL+" 	WHERE A.GEC_FLAG=0 AND  A.ISEMRINO='"&xisemri&"' "
                            Netsis_SQL=Netsis_SQL+" 	ORDER BY A.OPNO						"

                        ' SQL ende

                        NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1 
                            sira=0 
                            do until NetsisRecordSet.EOF OR sira>=1000
                                if sira=0 then                         %>
                                    <thead><tr> <%
                                    'Response.Write("<th>Sıra</th>")
                                    for each x in  NetsisRecordSet.Fields
                                        Response.Write("<th style='font-size:16px;'>" & x.name & "</th>")
                                    next                    %>
                                    </tr></thead>  <%
                                end if 
                                sira=sira+1      
                                'Response.Write(" <tr><td>"&sira&"</td>")
                                Response.Write(" <tr>")
                                for each x in  NetsisRecordSet.Fields
                                    'Response.Write(x.name)
                                    'Response.Write(" = ")
                                    Response.Write("<td  style='font-size:16px; padding:0px;'>" & x.value &"</td>")
                                    
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
                <%
                if isaretli="option1" then
                %>
                <h3>DİKKAT! bu alan yeni:</h3><h4><%=search_bom%> Ürge reçetesi ve <%=herisemri%> İş Emri reçetesi farkları:</h4>
                    <table class="table table-sm table-striped table-hover align-middle"  id="tblData"> 
                    <%
                    ' ****************************************************************************************************************************'

                    Netsis_SQL = " WITH LISTE AS( "
                    Netsis_SQL = Netsis_SQL + " SELECT  T4.HAM_KODU FROM ["+currentDB+"].[dbo].TBLISEMRI AS T1 "
                    Netsis_SQL = Netsis_SQL + "              INNER JOIN ["+currentDB+"].[dbo].TBLISEMRIREC AS T4 ON T1.ISEMRINO = T4.ISEMRINO "
                    Netsis_SQL = Netsis_SQL + "              WHERE  (T1.ISEMRINO = '" + herisemri + "')   AND T4.GEC_FLAG=0 "
                    Netsis_SQL = Netsis_SQL + " UNION ALL "
                    Netsis_SQL = Netsis_SQL + " SELECT t3.HAM_KODU FROM  ["+currentDB+"].[dbo].TBLSTOKURM AS T3 WHERE T3.MAMUL_KODU ='"+search_bom+"' AND T3.GEC_FLAG=0  AND  T3.STOK_MALIYET ='S' ) "
                    Netsis_SQL = Netsis_SQL + " SELECT DISTINCT "
                    Netsis_SQL = Netsis_SQL + " K1.GRUP_ISIM as 'Madde Grubu'"
                    Netsis_SQL = Netsis_SQL + "  , A.HAM_KODU as 'Madde Kodu'"
                    Netsis_SQL = Netsis_SQL + " , ST.STOK_ADI as 'Açıklama'"
                    Netsis_SQL = Netsis_SQL + " , T6.ISEMRINO as 'İşemri no'"
                    'Netsis_SQL = Netsis_SQL + " , T6.MAMUL_KODU as 'Mamül' "
                    Netsis_SQL = Netsis_SQL + " , T6.HAM_KODU as 'İşemri BoM'"
                    Netsis_SQL = Netsis_SQL + " , T6.MIKTAR as 'Miktar'"
                    Netsis_SQL = Netsis_SQL + " , T5.MAMUL_KODU as 'Mamül' "
                    Netsis_SQL = Netsis_SQL + " , T5.HAM_KODU as 'Ürge BoM' "
                    Netsis_SQL = Netsis_SQL + " , T5.MIKTAR as 'Miktar'"
                    Netsis_SQL = Netsis_SQL + " FROM LISTE A "
                    Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].TBLISEMRIREC AS T6 ON  T6.ISEMRINO = '" + herisemri + "'  AND T6.HAM_KODU=A.HAM_KODU  AND T6.GEC_FLAG=0 "
                    Netsis_SQL = Netsis_SQL + "              LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKURM AS T5 ON T5.HAM_KODU=A.HAM_KODU AND   T5.MAMUL_KODU='"+search_bom+"'   AND T5.STOK_MALIYET ='S' AND T5.GEC_FLAG=0 "
                    Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].TBLSTSABIT AS ST ON A.HAM_KODU=ST.STOK_KODU "
                    Netsis_SQL = Netsis_SQL + " LEFT JOIN ["+currentDB+"].[dbo].TBLSTOKKOD1 as K1 ON K1.GRUP_KOD=ST.KOD_1 "
                    Netsis_SQL = Netsis_SQL + "              WHERE T5.HAM_KODU IS NULL OR T6.HAM_KODU IS NULL ORDER BY A.HAM_KODU "

                    NetsisRecordSet.Open Netsis_SQL, NetsisConnection  
                        sira=0 
                        do until NetsisRecordSet.EOF OR sira>=1000 
                            if sira=0 then                         %>
                                <thead><tr> <%
                                Response.Write("<th>Sıra</th>")
                                for each x in  NetsisRecordSet.Fields
                                    Response.Write("<th>" & x.name & "</th>")
                                next                    %>
                                </tr></thead><tbody>  <%
                            end if 
                            sira=sira+1      
                            Response.Write(" <tr><td>"&sira&"</td>")
                            for each x in  NetsisRecordSet.Fields
                                Response.Write("<td class='text-nowrap '>" & x.value &"</td>")
                            next
                            NetsisRecordSet.MoveNext
                            Response.Write ("</tr>")
                        loop
                    NetsisRecordSet.close    
                    ' ****************************************************************************************************************************'
                    if sira=0 then response.write("<tr><td>yok.</td></tr>") 
                    %>
                    </table>

                    <%
                    end if
                    %>      
      
       
            <%  next
        end if %>        
    </div> <%
else
    Response.Write ("User level?")
end if
%> 
<!-- #include file="./include/footer.asp" -->