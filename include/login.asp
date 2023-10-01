<% 
saat=Timer
Dim BoMConnection
Dim BoMRecordSet
Dim BoMSQL

    Set BoMConnection = Server.CreateObject("ADODB.Connection")
    BomConnection.Open "PROVIDER=SQLOLEDB;DATA SOURCE=X.X.X.X;UID=Gurol;PWD=passpass;DATABASE=loginDB "
' bu database netsis dışında bir database sadece login için kullanıldı.

' DİKKAT Kopyaladığında yukardaki database'i unutma, yenisi ile değiştir. SQL serverda (SOURCE), Login (UID) ve DATABASE'de buna bağlı user oluşturman gerekiyor.

    Set BoMRecordSet = Server.CreateObject("ADODB.Recordset")


Dim Users_ID, username1, password1, UserLevel, UserEmail, UserLastLogin, UserLastLoginIP



'URL den gelenler'
mode = request.querystring("mode")

if mode="login" then

    username1 = request.form("username1")
    password1 = request.form("password1")
    hatirlabeni = request.form("hatirlabeni")    'kuki için
    loginmesaj = "Bilgilerinizi Kontrol Ediniz."
    'DataBaglanti'


    BoMSQL = "SELECT * FROM Users where Username='" & UserName1 & "' AND users_passwordhash=HashBytes('SHA1', '"&password1&"');"
    'Response.write("</br>"&BoMSQL&"</br>")
    BoMRecordSet.Open BoMSQL, BoMConnection
        do until BoMRecordSet.EOF
                        

            loginmesaj = "logged</br>"

            Users_ID=BoMRecordSet("Users_ID")
            'username1 ve password1'
            UserLevel=BoMRecordSet("UserLevel")
            'x, u, m'
            'x admin
            'u standart ürge elemanı
            'm maliyet mühendisi

            UserEmail=BoMRecordSet("UserEmail")
            UserLastLogin=BoMRecordSet("UserLastLogin")
            UserLastLoginIP=BoMRecordSet("UserLastLoginIP")

            Session("UserLevel")=UserLevel
            Session("Username")=Username1
            Session("Users_ID")=Users_ID
            'unique session
            Randomize
            Session("UserSessionID")=INT(1000000*RND)
            ' Session ömrü dakika'
            Session.Timeout=60
            if hatirlabeni="on" then
                'kuki işleri
                Response.Cookies("UserLevel")=UserLevel
                Response.Cookies("Users_ID")=Users_ID
                Response.Cookies("username1")=username1
                Response.Cookies("UserSessionID")=Session("UserSessionID")
            end if
            BoMRecordSet.movenext

        loop

        UpdateUserLastLogin (Users_ID)
    BoMRecordSet.Close
 
else
    'kuki kontrol ediliyor.
    kuki=Request.Cookies("UserLevel")
     if InStr(kuki,"u") OR InStr(kuki,"z")  then
        'Sessionları kukiden yaz
        Session("UserLevel")=Request.Cookies("UserLevel")
        Session("UserSessionID")=Request.Cookies("UserSessionID")
        Session("Username")=Request.Cookies("Username1")
        Session("Users_ID")=Request.Cookies("Users_ID")
        Response.Cookies("username1").Expires = now() + 1
        Response.Cookies("Users_ID").Expires = now() + 1
        Response.Cookies("UserLevel").Expires = now() + 1
        Response.Cookies("usersessionID").Expires = now() + 1
    end if

    if mode="logout" then
         Session.Contents.RemoveAll()
         Response.Cookies("username1").Expires = now() - 1
         Response.Cookies("Users_ID").Expires = now() - 1
         Response.Cookies("UserLevel").Expires = now() - 1
         Response.Cookies("UserSessionID").Expires = now() - 1

    end if
end if


if Session("UserLevel")="" or isempty(Session("UserLevel")) then     %>
     <head>

          <meta charset="utf-8">
          </head>
    <div class="container" style="width:400px; padding-top:100px; ">
        <div class="container mt-5 text-center"> <img style=" height: 126px;" src="img/logo.png"></div>
        
        <form method="POST" action="default.asp?mode=login">

            <div class="form-group mt-3">
                <input type="text" class="form-control" placeholder="Kullanıcı"  name="username1"  id="email">
            </div>
            <div class="form-group mt-3">
                <input type="password" class="form-control" placeholder="Şifre"  name="password1"  id="pwd">
            </div>
            <div class="form-group form-check mt-3">
                <label class="form-check-label">
                <input class="form-check-input" type="checkbox" name="hatirlabeni" > Beni unutma.
                </label>
            </div>
            <button type="submit" class="btn btn-primary">Giriş yap</button>
        </form><div class="form-group mt-3"><%=loginmesaj%></div>
    </div> <%
else
        UserLevel=session("UserLevel")
        Username1=Session("Username")
        Users_ID=Session("Users_ID")
end if
'------------------------------------------------------------- FUNCTIONS --------------------------------------------------------------------------------
function UpdateUserLastLogin (FunctionVar)
        Session("UserLastLogin")=now()
        Session("UserLastLoginIP")=Request.ServerVariables("REMOTE_ADDR")
     FunctionSQL="UPDATE users SET"
     FunctionSQL = FunctionSQL &  " UserLastLogin = '" & g_tarihi_formatla(Session("UserLastLogin")) & " " & FormatDateTime(Session("UserLastLogin"),4) & "',"
     FunctionSQL = FunctionSQL &  " UserSessionID = '" & Session("UserSessionID") & "',"
     FunctionSQL = FunctionSQL &  " UserLastLoginIP = '" & Session("UserLastLoginIP")& "' "

     FunctionSQL = FunctionSQL &  " WHERE Users_ID ='" & FunctionVar  &"'"
     'Response.Write(FunctionSQL)
     BoMConnection.execute (FunctionSQL)

end function


%>
