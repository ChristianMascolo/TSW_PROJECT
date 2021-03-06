<%@page import="implementation.ArticoliImpl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@page import="bean.UserBean"%>
<%@page import="bean.ArticoliBean"%>
<script src="jQuery/jquery.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/Header2.css">
 <script>
	
	$(document).ready(function(){
	 	$("#hiddenDiv").hide();
		$("#input").on("keyup", function() {
 		var value = $(this).val().toLowerCase();
 		$("#hiddenDiv tr").filter(function() {
 			if(value.length>0){
 				$("#hiddenDiv").show();
 				$(this).toggle($(this).text().toLowerCase().indexOf(value)>-1);
 			}
   			else $(this).hide($(this).text().toLowerCase().indexOf(value)>-1)
 		});
		});
	});
</script> 
</head>
<body>
<%UserBean ub1=(UserBean)session.getAttribute("user"); %>
<div class="topnav" id="myTopnav">
  <a href="HomePage.jsp" style="background-color:#c01c28">Home</a>
  
  <div class="dropdown">
    <button class="dropbtn">Articoli 
    </button>
    <div class="dropdown-content">
      <a href="Lista_Prodotti.jsp?nome=Nintendo">Nintendo</a>
      <a href="Lista_Prodotti.jsp?nome=Microsoft">Microsoft</a>
      <a href="Lista_Prodotti.jsp?nome=Sony">Sony</a>
    </div>
  </div>
  
  <div class="dropdown">
	  <% if(ub1 == null){ %>
    		<button class="dropbtn">Guest 
    		</button>
    		<div class="dropdown-content">
	      		<a href="Login.jsp">Login</a>
	      		<a href="Register.jsp">Register</a>
   			 </div> 
      <%}else{%>
			<button class="dropbtn"><%=ub1.getUsername() %> 
    		</button>
    		<div class="dropdown-content">
	      		<a href="PersonalPage.jsp">Area Personale</a>
	      		<a href="Carrello.jsp">Carrello</a>
	      		<a href="LogoutServlet">Logout</a>
	      	</div>
    <%} %>
  </div>
   <input type="text" id="input"></input>

	  	<table id="hiddenDiv">
                 <%	ArticoliImpl ai=new ArticoliImpl();
                 	for(ArticoliBean ab:ai.getAllArticoli()){%>
               			<tr><td><a id="test" href="Prodotto.jsp?id=<%=ab.getCodiceA()%>"><%=ab.getNome() %></a></td></tr>
               	 <%} %>
          </table>
  <a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>

<script>
function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
    x.className += " responsive";
  } else {
    x.className = "topnav";
  }
}
</script>
</body>
</html>