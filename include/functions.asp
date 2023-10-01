<%


function BeniKoddanArindir(bunuYaz)
        bunuYaz = Replace(bunuYaz, "<", "&lt;")
        bunuYaz = Replace(bunuYaz, ">", "&gt;")
        bunuYaz = Replace(bunuYaz, ",", "&sbquo;")
        bunuYaz = Replace(bunuYaz, "'", "&apos;")
        'bunuYaz = Replace(bunuYaz, CHR(132), "&rdquo;")
        'bunuYaz = Replace(bunuYaz, "#",	"&bull;")
        BeniKoddanArindir=bunuYaz
end function

function temizle(str)
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
        temizle=trim(str)
end function

function VirgulNokta(bunuYaz)
        VirgulNokta = Replace(bunuYaz, ",", ".")
end function


function toplutarih (t1,t2)

    if isdate(t1) and isdate(t2) then
                   
        bas_gun=day(t1)
        Select Case month(t1)
            case 1
                bas_ay="Ocak"
            case 2
                bas_ay="Şubat"
            case 3
                bas_ay="Mart"
            case 4
                bas_ay="Nisan"
            case 5
                bas_ay="Mayıs"
            case 6
                bas_ay="Haziran"
            case 7
                bas_ay="Temmuz"
            case 8
                bas_ay="Ağustos"
            case 9
                bas_ay="Eylül"
            case 10
                bas_ay="Ekim"
            case 11
                bas_ay="Kasım"
            case 12
                bas_ay="Aralık"
        end Select


        bas_yil=year(t1)
        bit_gun=day(t2)
        Select Case month(t2)
            case 1
                bit_ay="Ocak"
            case 2
                bit_ay="Şubat"
                                  

            case 3
                bit_ay="Mart"
            case 4
                bit_ay="Nisan"
            case 5
                bit_ay="Mayıs"
            case 6
                bit_ay="Haziran"
            case 7
                bit_ay="Temmuz"
            case 8
                bit_ay="Ağustos"
            case 9
                bit_ay="Eylül"
            case 10
                bit_ay="Ekim"
            case 11
                bit_ay="Kasım"
            case 12
                bit_ay="Aralık"
        end Select

        bit_yil=year(t2)    
        if bas_yil<>bit_yil then 
            toplutarih=bas_gun&" "&bas_ay&" "&bas_yil&" - "&bit_gun&" "&bit_ay&" "&bit_yil
        else 
                     

            if month(t2)<>month(t1) then
                    

            toplutarih=bas_gun&" "&bas_ay&" - "&bit_gun&" "&bit_ay&" "&bit_yil
            else
                if bas_gun<>bit_gun then
                    toplutarih=bas_gun&" - "&bit_gun&" "&bit_ay&" "&bit_yil
                else
                    toplutarih=bit_gun&" "&bit_ay&" "&bit_yil
                end if
            end if
        end if
  
    else
        if isdate(t1) then
            bas_gun=day(t1)
            Select Case month(t1)
                case 1
                    bas_ay="Ocak"
                case 2
                    bas_ay="Şubat"
                case 3
                    bas_ay="Mart"
                case 4
                    bas_ay="Nisan"
                case 5
                    bas_ay="Mayıs"
                case 6
                    bas_ay="Haziran"
                case 7
                    bas_ay="Temmuz"
                case 8
                    bas_ay="Ağustos"
                case 9
                    bas_ay="Eylül"
                case 10
                    bas_ay="Ekim"
                case 11
                    bas_ay="Kasım"
                case 12
                    bas_ay="Aralık"
            end Select
            bas_yil=year(t1)
            toplutarih=bas_gun&" "&bas_ay&" "&bas_yil
        else
            toplutarih="Tarih Girilmemiş."
        end if
    end if
        
end function


' Netsis para birimlerini alttaki liste ile kontrol ediniz.
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