          </div>     <!-- Maxsize div -->


     <div class="row row-cols-3 bg-dark text-center text-secondary d-print-none">
          <div class="col"><%=request.servervariables("LOGON_USER")%>/<%=serverName%> </div>
          <div class="col">
          Accell Hakiki Bisiklet Fabrikası &copy; 2022 <%
          if instr(Userlevel,"x")  and 1=1 then
          response.write("<br>"&User_Hakem_ID&"<font color=red>&bull;</font color=red>variable:"&Users_ID &"<font color=red>&bull;</font color=red>"& username1 &"<font color=red>&bull;</font color=red>"& UserLevel &"<font color=red>&bull;</font color=red>"& UserEmail &"<font color=red>&bull;</font color=red>"& UserLastLogin &"<font color=red>&bull;</font color=red>"& UserLastLoginIP&"<font color=red>&bull;</font color=red>"&UserSessionID&"<br>")
          response.write( "kuki:"&Request.Cookies("kimlik")&"<font color=red>&bull;</font color=red>"&Request.Cookies("username1")&"<font color=red>&bull;</font color=red>"&Request.Cookies("userlevel")&"<font color=red>&bull;</font color=red>"&Request.Cookies("userlastlogin")&"<font color=red>&bull;</font color=red>"&Request.Cookies("userlastloginIP")&"<font color=red>&bull;</font color=red>"&Request.Cookies("usersessionID")&"<br>")
          response.write( "session:"&Session("Kimlik")  &"<font color=red>&bull;</font color=red>"&Session("Username")&"<font color=red>&bull;</font color=red>"&session("userlevel")&"<font color=red>&bull;</font color=red>"&session("UserLastLogin")&"<font color=red>&bull;</font color=red>"&session("UserLastLoginIP")&"<font color=red>&bull;</font color=red>"&session("UserSessionID")&"<br>")
          response.write("DB: "&Session("currentDB")&"-- DB: "&currentDB&"<br>")
          
          end if


          %>

          </div>
          <div class="col"><%=now()%></div>
     </div>




          <!-- Siyah div 1st else-->

                    <%

                Else
                end if   ''<!-- header if-end if USERLEVEL-->

                BoMConnection.Close
                Set BoMRecordSet = Nothing
                Set BoMConnection = Nothing
               %>

     </body>

</html>