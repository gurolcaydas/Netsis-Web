<!DOCTYPE HTML>
<!-- #include file="./include/login.asp" -->
<!-- #include file="./include/functions.asp" -->
<!-- #include file="./include/database_functions.asp" -->
<%     BaslikHTML="Kullanıcılar" %> 
<!-- #include file="./include/header.asp" -->
<!-- #include file="./include/topmenu.asp" --> 
<%
if instr(UserLevel,"a") then 'needed level'

Dim yetki(8,2)

yetkison=8

yetki(1,1)="u"
yetki(1,2)="Genel Kullanıcı - Stok Kartları ve Reçeteler (Netsis), Reçeteler (Axapta)"

yetki(2,1)="m"
yetki(2,2)="Ürge - Reçete Karşılaştır, 0 miktarlı Bom, Reçete -> Excel, Ax-Netsis birim kontrol,  "

yetki(3,1)="f"
yetki(3,2)="Satınalma - Satınalma Fiyat listeleri, mükerrer fiyat satırları raporu"

yetki(4,1)="s"
yetki(4,2)="Maliyet Mühendisliği - Satış fiyat listeleri, Ax Maliyet Katsayı analizi, İlk maddeye göre mamül siparişleri"

yetki(5,1)="r"
yetki(5,2)="ÜrGe - İlk Madde-Reçete-Mamül sipariş listesi "

yetki(6,1)="a"
yetki(6,2)="Admin"

yetki(7,1)="x"
yetki(7,2)="Test"


yetki(8,1)="p"
yetki(8,2)="Üretim - Üretim grafik, günlük rapor "




 
%>
      <div class="container-fluid" style="margin-top:80px"> 
            <div class="container mt-5 pd-5 " style="width:80%; padding-top:100px; padding-bottom:100px;">
                  <div class="containertext-center"> 
                  <%
                  response.write ("<h1>Kullanıcılar </h1>")
                  if instr(UserLevel,"a") then Response.Write  (" <a href='?function=view'><i class='bi bi-arrow-repeat h3'></i></a> <a href='?function=add'><i class='bi bi-person-plus-fill h3'></i></a> ")

                  ' view &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                  if url_function="view" or  url_function="" then
                        response.write("<table class='table table-sm table-striped table-hover align-middle' id='tblData'><thead><tr><th>ID</th><th>Username</th><th>Level</th><th>Email</th><th>Session</th><th>Department</th><th>Last Login IP</th><th>Last Login</th><th></th></tr></thead><tbody>")
                        Bikes_SQL = "SELECT * FROM users ORDER BY UserDepartment, UserName"
                        Bikes_SQL = Bikes_SQL & " ; "
                        BoMRecordSet.Open Bikes_SQL, BoMConnection ,1,1
                              do until BoMRecordSet.EOF

                                    response.write("<tr>")
                                    response.write(" <td>"&BoMRecordSet("Users_ID")&"</td>")
                                    response.write(" <td class='h4'>"&BoMRecordSet("UserName")&"</td>")
                                    response.write(" <td class='h6'>"&BoMRecordSet("UserLevel")&"</td>")
                                    response.write(" <td>"&BoMRecordSet("UserEmail")&"</td>")
                                    response.write(" <td>"&BoMRecordSet("UserSessionID")&"</td>")
                                    response.write(" <td>"&BoMRecordSet("UserDepartment")&"</td>")
                                    response.write(" <td>"&BoMRecordSet("UserLastLoginIP")&"</td>")
                                    response.write(" <td>"&BoMRecordSet("UserLastLogin")&"</td>")
                                    if instr(UserLevel,"a") then response.write(" <td> <a href='?function=edit&users_ID="&BoMRecordSet("users_ID")&"'><i class='bi bi-pencil-square h3'></i></a></td>")
                                    response.write("</tr>")
                                    BoMRecordSet.movenext
                              Loop
                        BoMRecordSet.close
                        response.write("</tbody></table>")

                        Response.Write ("<h4><br><br><br>Yetkiler</h4><table class='table table-sm table-striped table-hover align-middle'>") 

                        for i=1 to yetkison
                        Response.Write ("	<tr><td>	"&yetki(i,1)&"	</td><td>"&yetki(i,2)&"</td></tr>	") 
                        next 



                  end if

                  ' add &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                  if url_function="add" and instr(UserLevel,"a")  then %>
                        <table class='table table-sm table-striped table-hover align-middle'><form method='POST' action='?function=save'>
                              <tr> <td>UserName</td> <td><input type='text' name='UserName'></td></tr>
                              <tr> <td>UserLevel</td> <td><table>      

                              <% for i=1 to yetkison %>
                                    <tr><td>	<%=yetki(i,1)%>	</td><td class="p-2">	<input type='checkbox' class='form-check-input'  name='UserLevel'  value='<%=yetki(i,1)%>' >	</td><td>	<%=yetki(i,2)%>	</td></tr>	
                              <% next %>

                              </table></td>
                              <!--<tr> <td>Level</td> <td><input type='text' name='UserLevel'></td></tr>-->
                              <tr> <td>Email</td> <td><input type='text' name='UserEmail'></td></tr>
                              <tr> <td>Department</td> <td><input type='text' name='UserDepartment'></td></tr>
                              <tr> <td>Password</td> <td><input type='text' name='users_PasswordHash'></td></tr>
                              <tr><td colspan=2><input type='submit' value='Kullanıcıyı Ekle' name='button_add' class='buton'></td></tr>
                        </form></table>
                        <%
                  end if

                  ' save &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                  if url_function="save"  and instr(UserLevel,"a")  then
                        Bikes_SQL="INSERT INTO users (UserName,UserLevel,UserEmail,UserDepartment,users_PasswordHash)"
                        Bikes_SQL=Bikes_SQL & " VALUES ('" & (BeniKoddanArindir(Request.Form("UserName"))) & "','" & (Request.Form("UserLevel")) & "','" & (BeniKoddanArindir(Request.Form("UserEmail"))) & "','" & (BeniKoddanArindir(Request.Form("UserDepartment"))) & "',HashBytes('SHA1', '"&(Request.Form("users_PasswordHash")) & "'))"
                        'response.write(Bikes_SQL) & "<br>"
                        BoMConnection.Execute Bikes_SQL,recaffected
                        response.Redirect("?")
                  end if

                  ' edit &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                  if url_function="edit"  and instr(UserLevel,"a")  then
                        Bikes_SQL = "SELECT * FROM users where users_ID="&request.querystring("users_ID") &";"  
                        BoMRecordSet.Open Bikes_SQL, BoMConnection ,1,1  
                              do until BoMRecordSet.EOF 
                                    response.write("<table class='table table-sm table-striped table-hover align-middle'><form method='POST' action='?function=edit_update&users_ID=" & request.querystring("users_ID") & "'>")
                                    response.write("<tr> <td>ID</td> <td>"&BoMRecordSet("Users_ID")&"</td></tr>")
                                    response.write("<tr> <td>UserName</td> <td><input type='text' name='UserName' value='" & BoMRecordSet("UserName") & "'></td></tr>")
                                    response.write("<tr> <td>Level</td> <td><table class='table table-sm table-striped table-hover align-middle'>")
                                    for i=1 to yetkison
                                                if instr(BoMRecordSet("UserLevel"),yetki(i,1)) then Response.Write ("	<tr><td>	"&yetki(i,1)&"	</td><td>	<input type='checkbox' class='form-check-input'  name='UserLevel'  value='"&yetki(i,1)&"' checked>	</td><td>	"&yetki(i,2)&"	</td></tr>	") else Response.Write ("	                        <tr><td>	"&yetki(i,1)&"	</td><td>	<input type='checkbox' class='form-check-input'  name='UserLevel'  value='"&yetki(i,1)&"' >	</td><td>	"&yetki(i,2)&"	</td></tr>	")
                                    next 
                                    Response.Write  ("</table></td></tr>")
                                    response.write("<tr> <td>Email</td> <td><input type='text' name='UserEmail' value='" & BoMRecordSet("UserEmail") & "'></td></tr>")
                                    response.write("<tr> <td>SessionID</td> <td>"&BoMRecordSet("UserSessionID")&"</td></tr>")
                                    response.write("<tr> <td>Department</td> <td><input type='text' name='UserDepartment' value='" & BoMRecordSet("UserDepartment") & "'></td></tr>")
                                    response.write("<tr> <td>LastLoginIP</td> <td>"&BoMRecordSet("UserLastLoginIP")&"</td></tr>")
                                    response.write("<tr> <td>LastLogin</td> <td>"&BoMRecordSet("UserLastLogin")&"</td></tr>")
                                    response.write("<tr> <td>Password</td> <td><input type='text' name='users_PasswordHash' value='" & BoMRecordSet("users_PasswordHash") & "'><input  name='users_new_password'  type='checkbox' name='UserLevel' >Şifre Değiştir</td></tr>")

                                    response.write("<tr><td colspan=2><input type='submit' value='Kayıt Et' name='button_add' class='buton'></td></tr></form></table>")

                                    BoMRecordSet.movenext
                              Loop
                        BoMRecordSet.close
                  end if


                  ' edit_update &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                  if url_function="edit_update"  and instr(UserLevel,"a")  then
                        BikeeditSQL = BikeeditSQL & " UPDATE users SET " 
                        BikeeditSQL = BikeeditSQL & "UserName='" & BeniKoddanArindir(Request.Form("UserName")) & "',"
                        BikeeditSQL = BikeeditSQL & "UserLevel='" & (Request.Form("UserLevel")) & "',"
                        BikeeditSQL = BikeeditSQL & "UserEmail='" & BeniKoddanArindir(Request.Form("UserEmail")) & "',"
                        if Request.Form("users_new_password")="on" then BikeeditSQL = BikeeditSQL & "users_PasswordHash=HashBytes('SHA1', '"&(Request.Form("users_PasswordHash")) & "'),"
                        BikeeditSQL = BikeeditSQL & "UserDepartment='" & BeniKoddanArindir(Request.Form("UserDepartment")) & "'"

                        BikeeditSQL = BikeeditSQL & " WHERE users_ID=" & request.querystring("users_ID") 
                        response.write(BikeeditSQL)
                        ''on error resume next
                        BoMConnection.execute (BikeeditSQL)
                        if err<>0 then
                              Response.Write("No update permissions!")
                        else
                              Response.Write("<h3>" & recaffected & " saved</h3>")
                              Response.Redirect ("users.asp")
                        end if

                  end if %>
            </div>
            </div>
      </div><%
else
         %> <div class="container mt-5 pd-5 " style="width:400px; padding-top:100px; padding-bottom:100px;">Yetkiniz yok.

         <%
end if
%>
    <script>
let table = new DataTable('#tblData', {
    "lengthMenu": [[-1, 10, 20, 100], [ "All" ,10, 20, 100]]
   // options
});

</script>
<!-- #include file="./include/footer.asp" -->
