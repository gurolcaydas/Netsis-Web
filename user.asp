<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Kullanıcı Detayları" %>
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" -->

<%
if instr(UserLevel,"u") OR instr(UserLevel,"z") then 'needed level'
%>
<div class="container-fluid" style="margin-top:80px"> 
<%

if instr(Userlevel,"u") OR instr(UserLevel,"z")   then



        if url_function="duzenleonay" then
                if Request.Form("users_PasswordHash")=Request.Form("users_PasswordHash2") and len(Request.Form("users_PasswordHash"))>4 then 
                        BikeeditSQL = BikeeditSQL & " UPDATE users SET " 
                        BikeeditSQL = BikeeditSQL & " UserEmail='" & BeniKoddanArindir(Request.Form("UserEmail")) & "',"
                        BikeeditSQL = BikeeditSQL & " users_PasswordHash=HashBytes('SHA1', '"&(Request.Form("users_PasswordHash")) & "') "

                        BikeeditSQL = BikeeditSQL & " WHERE users_ID=" & users_ID &"  "
                        'response.write(BikeeditSQL)
                        on error resume next
                        BoMConnection.execute (BikeeditSQL)
                        if err<>0 then
                        Response.Write("No update permissions!")
                        else
                        Response.Write("<h3>" & recaffected & " Kayıt Edildi.</h3>")
                        ''Response.Redirect ("activitytypes.asp")
                        end if
                else
                        if Request.Form("users_PasswordHash")<>Request.Form("users_PasswordHash2") then Response.Write ("Şifreler Farklı") else  Response.Write ("Şifre en az 5 karekter olmalı.") 
                end if
        end if



        if url_function="view" OR url_function="duzenleonay"  then
                Bikes_SQL = "SELECT * FROM users where Users_ID="&Users_ID&";"
                BoMRecordSet.Open Bikes_SQL, BoMConnection ,1,1

                do until BoMRecordSet.EOF %>
                    <div class="container mt-5 pd-5 " style="width:400px; padding-top:100px; padding-bottom:100px;">
                                <div class="containertext-center"> 

                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        <span class="h3">Kullanıcı Bilgileri</span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        ID <span><%=BoMRecordSet("Users_ID")%></span>
                                        </li>            
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Kullanıcı Adı <span class='h4'><%=BoMRecordSet("UserName")%></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Şifre <span><a href="?function=duzenle"><i class="bi bi-pencil-square h3"></i></a></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Yetkiler <span><%=BoMRecordSet("UserLevel")%></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Email <span><%=BoMRecordSet("UserEmail")%></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        <%=BoMRecordSet("UserLastLogin")%> <span><%=BoMRecordSet("UserLastLoginIP")%></span>
                                        </li>
                                </div>
                        </div>

    <%
                BoMRecordSet.movenext
                Loop
                BoMRecordSet.close
        end if

        if url_function="duzenle" then

                        %>


                        <%
                        Bikes_SQL = "SELECT * FROM users where users_ID="&Users_ID&";"  
                        BoMRecordSet.Open Bikes_SQL, BoMConnection ,1,1  
                        do until BoMRecordSet.EOF %>
                        <form method='POST' action='?function=duzenleonay'>

                    <div class="container mt-5 pd-5 " style="width:400px; padding-top:100px; padding-bottom:100px;">
                                <div class="containertext-center"> 

                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        <span class="h3">Kullanıcı Bilgileri</span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        ID <span><%=BoMRecordSet("Users_ID")%></span>
                                        </li>            
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Kullanıcı Adı <span class='h4'><%=BoMRecordSet("UserName")%></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Şifre <span><input type='password' name='users_PasswordHash' value=''></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Şifre Tekrar <span><input type='password' name='users_PasswordHash2' value=''></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        Yetkiler <span><%=BoMRecordSet("UserLevel")%></span>
                                        </li>
                                        <li class='list-group-item d-flex justify-content-between align-items-start'>
                                        <input type='submit' value='Kayıt Et' name='button_add' class='buton'></td>
                                        </li>
                                </div>
                        </div>
                        </form> <%

                        BoMRecordSet.movenext
                        Loop
                        BoMRecordSet.close

        end if




end if
%>

</div>

         <%
else
         response.write ("Bir terslik oldu.")
end if
%>

<!-- #include file="./include/footer.asp" -->