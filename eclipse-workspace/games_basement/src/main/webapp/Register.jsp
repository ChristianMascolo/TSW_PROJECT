<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
<%@ include file="css/Register.css" %>
</style>
<head>
<meta charset="UTF-8">
<title>Registrazione</title>
<script src="jquery.js"></script>
</head>
<body>

	<form id="msform" action="RegisterFilter" method="POST">
		  <input type="hidden" id="flag" name="flag" value="<%request.getAttribute("flag"); %>">
		  
		  <!-- progressbar -->
		  <ul id="progressbar">
		    <li class="active">Account</li>
		    <li>Chi sei</li>
		    <li>Dati Anagrafici</li>
		  </ul>
	
		  <fieldset id="firstField">
		    <h2 class="fs-title">Account</h2>
		    <input type="text" id="username" name="username" placeholder="Username" autocomplete="false"/>
		    <input type="text" id="email" name="email" onkeyup="regexEmail()" placeholder="Email" />
		    <input type="password" id="password" name="password" onkeyup="validatePassword()" placeholder="Password" />
		    <input type="password" id="passwordDue" name="passwordDue" onkeyup="checkPassword()" placeholder="Confirm Password" />
		    <p id="alert"></p>
		    <button class="next action-button" formaction="Login.jsp" >Login</button>
		    <input type="button" name="next" class="next action-button" value="Next" />
		    <a href="HomePage.jsp"><img src="img/logo.png" width="150 px" height="100 px"></a>
		  </fieldset>
		  <fieldset id="secondField">
		    <h2 class="fs-title">Dati personali</h2>
			    <input type="text" id="nome" name="nome" placeholder="nome" autocomplete="false"/>
			    <input type="text" id="cognome" name="cognome" placeholder="cognome" autocomplete="false"/>
			    <input type="text" id="phone" name="phone" onchange="regexPhone(this.value)" placeholder="Numero di Telefono"  />
			    <p id="alertTwo"></p>
			    <input type="button" name="previous" class="previous action-button" value="Previous" />
			    <input type="button" name="next" class="next action-button" value="Next" />
			    <a href="HomePage.jsp"><img src="img/logo.png" width="150 px" height="100 px"></a>
		  </fieldset>
		  <fieldset id="thirdField">
		    <h2 class="fs-title">Dati Anagrafici</h2>
			    <input type="text" name="citta" placeholder="Città" autocomplete="false"/>
			    <input type="text" name="cap" placeholder="Cap" />
			    <input type="date" name="bday" />
			    <p id="alertThree"></p>
			    <input type="button" name="previous" class="previous action-button" value="Previous" />
			    <input type="submit" name="submit" class="submit action-button" value="Submit" />
			    <a href="HomePage.jsp"><img src="img/logo.png" width="150 px" height="100 px"></a>
		  </fieldset>
	
	</form>
<script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js'></script>
<script>
	$(document).ready(function(){
		var flag=$("#flag");
		
		if(flag.val()==''){
			console.log("vuota");
		}
	});

	function checkPassword(){
		var firstPassword=document.getElementById("password").value;
		var secondPassword=document.getElementById("passwordDue").value;
		
		if(firstPassword == secondPassword){
			document.getElementById("alert").style.color="#8CC63E";
			document.getElementById("alert").innerHTML='<span>Le password corrispondono!</span>';
		}else{
			document.getElementById("alert").style.color="#EE2B39";
			document.getElementById("alert").innerHTML='<span>Le password non corrispondono!</span>';
		}
	}

	function regexEmail(email){
		/*someText@someEmail.com(o un dominio compreso fra 2 e 4 caratteri)*/
		var regex=/\w+@\w+\.\w{2,4}/i;
		var result=email.match(regex);
		
		if(!result){
			document.getElementById("alert").style.color="#EE2B39";
			document.getElementById("alert").innerHTML="<span>Inserisci una email corretta.</span>";
		}else{
			document.getElementById("alert").innerHTML="";
		}
	}
	
	function regexPhone(phone){
		/*(123) 456-7890
		  (123)456-7890
		  123-456-7890
		  123.456.7890
		  1234567890
		  +31636363634
		  075-63546725*/
		var reg = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im;
	    var result=phone.match(reg);
	
		if(!result){
			document.getElementById("alertTwo").style.color="#EE2B39";
			document.getElementById("alertTwo").innerHTML='<span>Numero di telefono non valido</span>';
		}else{
			document.getElementById("alertTwo").innerHTML='';
		}
	}
	
	function showPwd(){
		var pwd=document.getElementById("password");
		var img=document.getElementById("eye");
		
		if(pwd.getAttribute("type")==="password"){
			pwd.setAttribute("type","text");
			img.src="img/eye.png";
		}else{
			pwd.setAttribute("type","password");
			img.src="img/eyeClose.png";
		}
	}
	
	function validatePassword(){
		var pwd=document.getElementById("password").value;
		var specialRegex=/\W|_/;
		var length=pwd.length;
		
		if(length<=8 && !pwd.match(specialRegex)){
			document.getElementById("alert").innerHTML="La password è corta e non contiene caratteri speciali";
		}else if(length>=8 && !pwd.match(specialRegex)){
			document.getElementById("alert").innerHTML="La password non contiene caratteri speciali";
		}else if(length>=8 && pwd.match(specialRegex)){
			document.getElementById("alert").innerHTML="Password forte";
		}
	}
	
	//jQuery time
	var current_fs, next_fs, previous_fs; //fieldsets
	var left, opacity, scale; //proprietà dei fieldset che andremo ad animare
	var animating; //flag per evitare dei click troppo veloci

	$(".next").click(function () {
	  if (animating) return false;
	  animating = true;

	  //assegno i fieldset "attuale" e "successivo" accedendo al tag "padre" di entrambi i pulsanti
	  current_fs = $(this).parent();
	  next_fs = $(this).parent().next();

	  if(checkEmpties(current_fs)>0){
      	$(this).parent().stop(true,true);
      }
	  //attiva il prossimo step sulla progess-bar usando l'indice di next_fs
	  $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

	  //mostra il prossimo fieldset
	  next_fs.show();
	  
	  //nascondi il corrente
	  current_fs.animate(
	    { opacity: 0 },
	    {
	      step: function (now, mx) {
	        //1. riduci current_fs a 80%
	        scale = 1 - (1 - now) * 0.2;
	        //2. scorri next_fs dalla destra(50%)
	        left = now * 50 + "%";
	        //3. incrementa l'opacità del next_fs di 1 appena entra
	        opacity = 1 - now;
	        current_fs.css({
	          transform: "scale(" + scale + ")",
	          position: "absolute"
	        });
	        next_fs.css({ left: left, opacity: opacity });
	      },
	      duration: 800,
	      complete: function () {
	        current_fs.hide();
	        animating = false;
	      },
	      //default dal plugin 
	      easing: "easeInOutBack"
	    }
	  );
	});

	$(".previous").click(function () {
	  if (animating) return false;
	  animating = true;

	  current_fs = $(this).parent();
	  previous_fs = $(this).parent().prev();

	  
	  //rimuove di 1 dalla progress-bar
	  $("#progressbar li")
	    .eq($("fieldset").index(current_fs))
	    .removeClass("active");

	  //mostra il precendente
	  previous_fs.show();
	  //nascondi l'attuale con stile
	  current_fs.animate(
	    { opacity: 0 },
	    {
	      step: function (now, mx) {
	        //1. scala il precedente da 80% a 100%
	        scale = 0.8 + (1 - now) * 0.2;
	        //2. prendi il successivo da destra(50%) - a 0%
	        left = (1 - now) * 50 + "%";
	        //3.incrementa l'opacità del precedente di 1 appena entra
	        opacity = 1 - now;
	        current_fs.css({ left: left });
	        previous_fs.css({
	          transform: "scale(" + scale + ")",
	          opacity: opacity
	        });
	      },
	      duration: 800,
	      complete: function () {
	        current_fs.hide();
	        animating = false;
	      },
	      //come prima
	      easing: "easeInOutBack"
	    }
	  );
	});
	
	function checkEmpties(fieldset){
		if(fieldset.is("#firstField")){
			return checkFirstField();
		}else if(fieldset.is("#secondField")){
			return checkSecondField();
		}
	}
	
	function checkFirstField(){
		var count=0;
		if($("#firstField > #username").val()==''){
			count++;
			console.log("inserisci username");
		}
	}
	
	function checkSecondField(){
		var count=0;
		if($("#secondField > #nome").val()==''){
			count++;
			console.log("inserisci nome");
		}
		return count;
	}
	
	function checkThirdField(){
		if($("#thirdField > #citta").val()==''){
			console.log("inserisci città");W
		}
	}
</script>
</body>
</html>