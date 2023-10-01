                    <!-- #include file="./dbcon.asp" -->
                    <%
                 
        url_item = request.querystring("item")      %> 
                               <div class="list-group"> <!-- SKU# -->     <%
                            ' SQL
                                    Netsis_SQL=" SELECT "
                                    Netsis_SQL=Netsis_SQL+" A.[SUBE_KODU] as 'aa1' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ISLETME_KODU] as 'aa2' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[STOK_KODU] as 'aa3' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[URETICI_KODU] as 'aa4' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[STOK_ADI] as 'aa5' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[GRUP_KODU] as 'aa6' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KOD_1] as 'aa7' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KOD_2] as 'aa8' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KOD_3] as 'aa9' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KOD_4] as 'aa10' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KOD_5] as 'aa11' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATICI_KODU] as 'aa12' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OLCU_BR1] as 'aa13' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OLCU_BR2] as 'aa14' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[PAY_1] as 'aa15' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[PAYDA_1] as 'aa16' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OLCU_BR3] as 'aa17' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[PAY2] as 'aa18' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[PAYDA2] as 'aa19' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[FIAT_BIRIMI] as 'aa20' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[AZAMI_STOK] as 'aa21' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ASGARI_STOK] as 'aa22' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[TEMIN_SURESI] as 'aa23' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KUL_MIK] as 'aa24' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[RISK_SURESI] as 'aa25' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ZAMAN_BIRIMI] as 'aa26' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATIS_FIAT1] as 'aa27' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATIS_FIAT2] as 'aa28' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATIS_FIAT3] as 'aa29' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATIS_FIAT4] as 'aa30' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SAT_DOV_TIP] as 'aa31' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[DOV_ALIS_FIAT] as 'aa32' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[DOV_MAL_FIAT] as 'aa33' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[DOV_SATIS_FIAT] as 'aa34' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MUH_DETAYKODU] as 'aa35' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BIRIM_AGIRLIK] as 'aa36' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[NAKLIYET_TUT] as 'aa37' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KDV_ORANI] as 'aa38' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALIS_DOV_TIP] as 'aa39' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[DEPO_KODU] as 'aa40' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[DOV_TUR] as 'aa41' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[URET_OLCU_BR] as 'aa42' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BILESENMI] as 'aa43' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MAMULMU] as 'aa44' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[FORMUL_TOPLAMI] as 'aa45' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[UPDATE_KODU] as 'aa46' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MAX_ISKONTO] as 'aa47' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ECZACI_KARI] as 'aa48' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MIKTAR] as 'aa49' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MAL_FAZLASI] as 'aa50' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KDV_TENZIL_ORAN] as 'aa51' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KILIT] as 'aa52' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ONCEKI_KOD] as 'aa53' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SONRAKI_KOD] as 'aa54' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BARKOD1] as 'aa55' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BARKOD2] as 'aa56' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BARKOD3] as 'aa57' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALIS_KDV_KODU] as 'aa58' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALIS_FIAT1] as 'aa59' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALIS_FIAT2] as 'aa60' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALIS_FIAT3] as 'aa61' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALIS_FIAT4] as 'aa62' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[LOT_SIZE] as 'aa63' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MIN_SIP_MIKTAR] as 'aa64' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SABIT_SIP_ARALIK] as 'aa65' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SIP_POLITIKASI] as 'aa66' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OZELLIK_KODU1] as 'aa67' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OZELLIK_KODU2] as 'aa68' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OZELLIK_KODU3] as 'aa69' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OZELLIK_KODU4] as 'aa70' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OZELLIK_KODU5] as 'aa71' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OPSIYON_KODU1] as 'aa72' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OPSIYON_KODU2] as 'aa73' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OPSIYON_KODU3] as 'aa74' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OPSIYON_KODU4] as 'aa75' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OPSIYON_KODU5] as 'aa76' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BILESEN_OP_KODU] as 'aa77' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SIP_VER_MAL] as 'aa78' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ELDE_BUL_MAL] as 'aa79' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[YIL_TAH_KUL_MIK] as 'aa80' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[EKON_SIP_MIKTAR] as 'aa81' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ESKI_RECETE] as 'aa82' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OTOMATIK_URETIM] as 'aa83' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALFKOD] as 'aa84' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SAFKOD] as 'aa85' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[KODTURU] as 'aa86' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[S_YEDEK1] as 'aa87' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[S_YEDEK2] as 'aa88' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[F_YEDEK3] as 'aa89' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[F_YEDEK4] as 'aa90' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[C_YEDEK5] as 'aa91' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[C_YEDEK6] as 'aa92' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[B_YEDEK7] as 'aa93' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[I_YEDEK8] as 'aa94' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[L_YEDEK9] as 'aa95' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[D_YEDEK10] as 'aa96' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[GIRIS_SERI] as 'aa97' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[CIKIS_SERI] as 'aa98' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SERI_BAK] as 'aa99' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SERI_MIK] as 'aa100' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SERI_GIR_OT] as 'aa101' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SERI_CIK_OT] as 'aa102' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SERI_BASLANGIC] as 'aa103' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[FIYATKODU] as 'aa104' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[FIYATSIRASI] as 'aa105' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[PLANLANACAK] as 'aa106' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[LOT_SIZECUSTOMER] as 'aa107' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MIN_SIP_MIKTARCUSTOMER] as 'aa108' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[GUMRUKTARIFEKODU] as 'aa109' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ABCKODU] as 'aa110' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[PERFORMANSKODU] as 'aa111' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATICISIPKILIT] as 'aa112' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[MUSTERISIPKILIT] as 'aa113' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATINALMAKILIT] as 'aa114' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATISKILIT] as 'aa115' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[EN] as 'aa116' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BOY] as 'aa117' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[GENISLIK] as 'aa118' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SIPLIMITVAR] as 'aa119' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SONSTOKKODU] as 'aa120' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ONAYTIPI] as 'aa121' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ONAYNUM] as 'aa122' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[FIKTIF_MAM] as 'aa123' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[YAPILANDIR] as 'aa124' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SBOMVARMI] as 'aa125' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[BAGLISTOKKOD] as 'aa126' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[YAPKOD] as 'aa127' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ALISTALTEKKILIT] as 'aa128' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SATISTALTEKKILIT] as 'aa129' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[S_YEDEK3] as 'aa130' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[STOKMEVZUAT] as 'aa131' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[OTVTEVKIFAT] as 'aa132' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[SERIBARKOD] as 'aa133' "
                                    Netsis_SQL=Netsis_SQL+" ,A.[ATIK_URUN] as 'aa134' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[TUR] as 'aa135' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[MGRUP] as 'aa136' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KAYITTARIHI] as 'aa137' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KAYITYAPANKUL] as 'aa138' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[DUZELTMETARIHI] as 'aa139' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[DUZELTMEYAPANKUL] as 'aa140' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[INGISIM] as 'aa141' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[BIRIM_MALIYET] as 'aa142' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL1N] as 'aa143' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL2N] as 'aa144' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL3N] as 'aa145' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL4N] as 'aa146' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL5N] as 'aa147' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL6N] as 'aa148' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL7N] as 'aa149' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL8N] as 'aa150' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL1S] as 'aa151' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL2S] as 'aa152' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL3S] as 'aa153' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL4S] as 'aa154' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL5S] as 'aa155' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL6S] as 'aa156' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL7S] as 'aa157' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[KULL8S] as 'aa158' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[SON_SATAL_FIAT] as 'aa159' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[SON_SATAL_TAR] as 'aa160' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[S_YEDEK1] as 'aa161' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[S_YEDEK2] as 'aa162' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[F_YEDEK1] as 'aa163' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[F_YEDEK2] as 'aa164' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[C_YEDEK1] as 'aa165' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[C_YEDEK2] as 'aa166' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[B_YEDEK1] as 'aa167' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[I_YEDEK1] as 'aa168' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[L_YEDEK1] as 'aa169' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[SONSATTAR] as 'aa170' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[DAGITICI_KODU] as 'aa171' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[CURBIRIM_MALIYET] as 'aa172' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[AMBARMASRAF] as 'aa173' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[AMBARCIKISYERI] as 'aa174' "
                                    Netsis_SQL=Netsis_SQL+" ,B.[OTVKOD] as 'aa175' "
                                    Netsis_SQL=Netsis_SQL+" FROM [db2022].[dbo].[TBLSTSABIT] A"
                                    Netsis_SQL=Netsis_SQL+" LEFT JOIN [db2022].[dbo].[TBLSTSABITEK] B ON A.[STOK_KODU]=B.[STOK_KODU]"
                                    Netsis_SQL=Netsis_SQL+" WHERE A.[STOK_KODU]='"&url_item&"'"

                            ' SQL ende
                                                Response.ContentType = "text/html"
                    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
                    Response.CodePage = 65001
                    Response.CharSet = "UTF-8" 
                            NetsisRecordSet.Open Netsis_SQL, NetsisConnection ,0,1
                                say=0                    %>
                                    <div class="container-fluid p-4"> <!-- SKU# -->
                                        <h2><%=url_item%></h2> 
                                    </div>                                         <%
                                    do until NetsisRecordSet.EOF OR say=1
                                        say=1                                %>               
                                        <div class="container-fluid p-4"> <!-- Künye -->
                                            <ol class="list-group  d-flex pt-1" >                                               
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SUBE_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa1")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ISLETME_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa2")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[STOK_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa3")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[URETICI_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa4")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[STOK_ADI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa5")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[GRUP_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa6")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KOD_1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa7")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KOD_2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa8")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KOD_3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa9")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KOD_4]<span class='fw-bold text-right'><%=NetsisRecordSet("aa10")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KOD_5]<span class='fw-bold text-right'><%=NetsisRecordSet("aa11")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATICI_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa12")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OLCU_BR1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa13")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OLCU_BR2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa14")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[PAY_1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa15")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[PAYDA_1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa16")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OLCU_BR3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa17")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[PAY2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa18")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[PAYDA2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa19")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[FIAT_BIRIMI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa20")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[AZAMI_STOK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa21")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ASGARI_STOK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa22")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[TEMIN_SURESI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa23")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KUL_MIK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa24")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[RISK_SURESI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa25")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ZAMAN_BIRIMI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa26")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATIS_FIAT1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa27")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATIS_FIAT2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa28")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATIS_FIAT3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa29")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATIS_FIAT4]<span class='fw-bold text-right'><%=NetsisRecordSet("aa30")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SAT_DOV_TIP]<span class='fw-bold text-right'><%=NetsisRecordSet("aa31")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[DOV_ALIS_FIAT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa32")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[DOV_MAL_FIAT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa33")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[DOV_SATIS_FIAT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa34")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MUH_DETAYKODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa35")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BIRIM_AGIRLIK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa36")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[NAKLIYET_TUT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa37")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KDV_ORANI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa38")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALIS_DOV_TIP]<span class='fw-bold text-right'><%=NetsisRecordSet("aa39")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[DEPO_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa40")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[DOV_TUR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa41")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[URET_OLCU_BR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa42")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BILESENMI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa43")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MAMULMU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa44")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[FORMUL_TOPLAMI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa45")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[UPDATE_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa46")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MAX_ISKONTO]<span class='fw-bold text-right'><%=NetsisRecordSet("aa47")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ECZACI_KARI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa48")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MIKTAR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa49")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MAL_FAZLASI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa50")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KDV_TENZIL_ORAN]<span class='fw-bold text-right'><%=NetsisRecordSet("aa51")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KILIT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa52")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ONCEKI_KOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa53")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SONRAKI_KOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa54")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BARKOD1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa55")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BARKOD2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa56")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BARKOD3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa57")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALIS_KDV_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa58")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALIS_FIAT1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa59")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALIS_FIAT2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa60")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALIS_FIAT3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa61")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALIS_FIAT4]<span class='fw-bold text-right'><%=NetsisRecordSet("aa62")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[LOT_SIZE]<span class='fw-bold text-right'><%=NetsisRecordSet("aa63")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MIN_SIP_MIKTAR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa64")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SABIT_SIP_ARALIK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa65")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SIP_POLITIKASI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa66")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OZELLIK_KODU1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa67")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OZELLIK_KODU2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa68")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OZELLIK_KODU3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa69")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OZELLIK_KODU4]<span class='fw-bold text-right'><%=NetsisRecordSet("aa70")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OZELLIK_KODU5]<span class='fw-bold text-right'><%=NetsisRecordSet("aa71")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OPSIYON_KODU1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa72")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OPSIYON_KODU2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa73")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OPSIYON_KODU3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa74")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OPSIYON_KODU4]<span class='fw-bold text-right'><%=NetsisRecordSet("aa75")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OPSIYON_KODU5]<span class='fw-bold text-right'><%=NetsisRecordSet("aa76")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BILESEN_OP_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa77")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SIP_VER_MAL]<span class='fw-bold text-right'><%=NetsisRecordSet("aa78")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ELDE_BUL_MAL]<span class='fw-bold text-right'><%=NetsisRecordSet("aa79")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[YIL_TAH_KUL_MIK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa80")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[EKON_SIP_MIKTAR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa81")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ESKI_RECETE]<span class='fw-bold text-right'><%=NetsisRecordSet("aa82")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OTOMATIK_URETIM]<span class='fw-bold text-right'><%=NetsisRecordSet("aa83")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALFKOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa84")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SAFKOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa85")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[KODTURU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa86")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[S_YEDEK1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa87")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[S_YEDEK2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa88")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[F_YEDEK3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa89")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[F_YEDEK4]<span class='fw-bold text-right'><%=NetsisRecordSet("aa90")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[C_YEDEK5]<span class='fw-bold text-right'><%=NetsisRecordSet("aa91")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[C_YEDEK6]<span class='fw-bold text-right'><%=NetsisRecordSet("aa92")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[B_YEDEK7]<span class='fw-bold text-right'><%=NetsisRecordSet("aa93")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[I_YEDEK8]<span class='fw-bold text-right'><%=NetsisRecordSet("aa94")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[L_YEDEK9]<span class='fw-bold text-right'><%=NetsisRecordSet("aa95")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[D_YEDEK10]<span class='fw-bold text-right'><%=NetsisRecordSet("aa96")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[GIRIS_SERI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa97")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[CIKIS_SERI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa98")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SERI_BAK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa99")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SERI_MIK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa100")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SERI_GIR_OT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa101")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SERI_CIK_OT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa102")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SERI_BASLANGIC]<span class='fw-bold text-right'><%=NetsisRecordSet("aa103")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[FIYATKODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa104")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[FIYATSIRASI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa105")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[PLANLANACAK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa106")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[LOT_SIZECUSTOMER]<span class='fw-bold text-right'><%=NetsisRecordSet("aa107")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MIN_SIP_MIKTARCUSTOMER]<span class='fw-bold text-right'><%=NetsisRecordSet("aa108")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[GUMRUKTARIFEKODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa109")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ABCKODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa110")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[PERFORMANSKODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa111")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATICISIPKILIT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa112")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[MUSTERISIPKILIT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa113")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATINALMAKILIT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa114")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATISKILIT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa115")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[EN]<span class='fw-bold text-right'><%=NetsisRecordSet("aa116")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BOY]<span class='fw-bold text-right'><%=NetsisRecordSet("aa117")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[GENISLIK]<span class='fw-bold text-right'><%=NetsisRecordSet("aa118")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SIPLIMITVAR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa119")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SONSTOKKODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa120")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ONAYTIPI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa121")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ONAYNUM]<span class='fw-bold text-right'><%=NetsisRecordSet("aa122")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[FIKTIF_MAM]<span class='fw-bold text-right'><%=NetsisRecordSet("aa123")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[YAPILANDIR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa124")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SBOMVARMI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa125")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[BAGLISTOKKOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa126")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[YAPKOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa127")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ALISTALTEKKILIT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa128")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SATISTALTEKKILIT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa129")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[S_YEDEK3]<span class='fw-bold text-right'><%=NetsisRecordSet("aa130")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[STOKMEVZUAT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa131")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[OTVTEVKIFAT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa132")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[SERIBARKOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa133")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABIT].[ATIK_URUN]<span class='fw-bold text-right'><%=NetsisRecordSet("aa134")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[TUR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa135")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[MGRUP]<span class='fw-bold text-right'><%=NetsisRecordSet("aa136")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KAYITTARIHI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa137")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KAYITYAPANKUL]<span class='fw-bold text-right'><%=NetsisRecordSet("aa138")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[DUZELTMETARIHI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa139")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[DUZELTMEYAPANKUL]<span class='fw-bold text-right'><%=NetsisRecordSet("aa140")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[INGISIM]<span class='fw-bold text-right'><%=NetsisRecordSet("aa141")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[BIRIM_MALIYET]<span class='fw-bold text-right'><%=NetsisRecordSet("aa142")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL1N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa143")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL2N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa144")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL3N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa145")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL4N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa146")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL5N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa147")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL6N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa148")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL7N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa149")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL8N]<span class='fw-bold text-right'><%=NetsisRecordSet("aa150")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL1S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa151")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL2S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa152")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL3S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa153")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL4S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa154")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL5S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa155")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL6S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa156")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL7S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa157")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[KULL8S]<span class='fw-bold text-right'><%=NetsisRecordSet("aa158")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[SON_SATAL_FIAT]<span class='fw-bold text-right'><%=NetsisRecordSet("aa159")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[SON_SATAL_TAR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa160")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[S_YEDEK1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa161")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[S_YEDEK2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa162")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[F_YEDEK1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa163")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[F_YEDEK2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa164")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[C_YEDEK1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa165")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[C_YEDEK2]<span class='fw-bold text-right'><%=NetsisRecordSet("aa166")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[B_YEDEK1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa167")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[I_YEDEK1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa168")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[L_YEDEK1]<span class='fw-bold text-right'><%=NetsisRecordSet("aa169")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[SONSATTAR]<span class='fw-bold text-right'><%=NetsisRecordSet("aa170")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[DAGITICI_KODU]<span class='fw-bold text-right'><%=NetsisRecordSet("aa171")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[CURBIRIM_MALIYET]<span class='fw-bold text-right'><%=NetsisRecordSet("aa172")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[AMBARMASRAF]<span class='fw-bold text-right'><%=NetsisRecordSet("aa173")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[AMBARCIKISYERI]<span class='fw-bold text-right'><%=NetsisRecordSet("aa174")%></span></div></li> 
<li class='list-group-item d-flex justify-content-between list-group-item-secondary align-items-start'><div class='d-flex w-100 justify-content-between'>[TBLSTSABITEK].[OTVKOD]<span class='fw-bold text-right'><%=NetsisRecordSet("aa175")%></span></div></li> 

        
                                            </ol>                                               
                                        </div>
                                        <%
                                    Loop 
                            NetsisRecordSet.close
                            if say=0 and url_item<>"" then Response.Redirect "NetsisBom.asp?doo=bikelist&search_bisiklet_kodu=" & url_item     %>                           
                        </div>   
<%
                            NetsisConnection.Close
    Set NetsisRecordSet = Nothing
    Set NetsisConnection = Nothing
%>
