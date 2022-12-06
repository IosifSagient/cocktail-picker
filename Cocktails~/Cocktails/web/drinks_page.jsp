<%@ page import="mainpackage.datapackage.Cocktails" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Anouk
  Date: 2/6/2021
  Time: 18:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- USER'S PAGE WHEN CHOOSING A DRINK CATEGORY -->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>Cocktail Picker</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- Google sign-in -->
    <meta name="google-signin-client_id" content="140271236674-p3j7pdfs2k2mn2vjmgvdg3jbjcddj33l.apps.googleusercontent.com">

    <link rel="stylesheet" href="css/style.css">

</head>

<body style="background-image: url(images/cocktails.jpg);" onload="checkIfSigned()">

<script>
    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
            window.location="login.jsp";
        });
    }

    function onLoad() {
        gapi.load('auth2', function() {
            gapi.auth2.init();
        });
    }

    function checkIfSigned() {
        if(sessionStorage.getItem('myUserEntity') == null){
            //Redirect to login page, no user entity available in sessionStorage
            document.getElementById("log").style.visibility = 'visible';
        } else {
            var userEntity = {};
            userEntity = JSON.parse(sessionStorage.getItem('myUserEntity'));
            document.getElementById("google_log").style.visibility = 'visible';
        }
    }

</script>

<!--header-->
<div class="header">
    <a id="back" href="javascript:history.back()" class="navbar-brand scroll-top" style="float: left; border: 2px solid darkred;">BACK</a>
    <a id="log" href="<%=request.getContextPath()%>/LogoutServlet" class="navbar-brand scroll-top" style="visibility: hidden; float: right; border: 2px solid darkred;">LOG OUT</a>
    <a id="google_log" href="#" onclick="signOut()" class="navbar-brand scroll-top" style="visibility: hidden; float: right; border: 2px solid darkred;">LOG OUT</a>
    <div class="container">
        <h2 style="text-align:center; font-size: 40px; color: navajowhite; display:block;">Cocktails with base: <%=request.getParameter("Base")%></h2>
    </div>
</div>

<% ArrayList<Cocktails> cocktailsList = (ArrayList<Cocktails>)request.getAttribute("cocktailsList"); %>

<section class="featured-food">
    <div class="container" style="border: 2px solid navajowhite;">
        <div class="row">
            <div class="col-md-12">
                <div class="heading">

                </div>
            </div>
        </div>

        <div class="row">
            <% for (Cocktails c : cocktailsList) { %>
            <%-- Dynamic creation of squares --%>
            <div class="col-md-4">
                <div class="food-item">
                    <a id="Name" href="<%=request.getContextPath()%>/CocktailServlet2?Name=<%=c.getName()%>" method="get" style="font-size: 20px; color: white;"><%=c.getName()%></a>
                    <div id="Taste"><%=c.getTaste()%></div>
                    <a href="<%=request.getContextPath()%>/CocktailServlet2?Name=<%=c.getName()%>" method="get" style="font-size: 20px; color: white;">
                        <img src="data:image/png;base64, <%=c.getImage()%>" alt="" width="300" height="250">
                    </a>
                    <div class="text-content">
                        <h4></h4>
                        <br>
                        <p></p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</section>

<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>

</body>

</html>
