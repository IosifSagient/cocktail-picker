<%@ page import="mainpackage.datapackage.Cocktails" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: Anouk
  Date: 2/6/2021
  Time: 18:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- SHOWS CHOSEN COCKTAIL -->
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
    <style>
        input[type=text], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-top: 6px;
            margin-bottom: 16px;
            resize: vertical;
            text-align-last: center;
        }
    </style>

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

<% Cocktails cocktailsList = (Cocktails) request.getAttribute("cocktailsList");%>

<!--header-->
<div class="header">
    <a id="back" href="javascript:history.back()" class="navbar-brand scroll-top" style="float: left; border: 2px solid darkred;">BACK</a>
    <a id="log" href="<%=request.getContextPath()%>/LogoutServlet" class="navbar-brand scroll-top" style="visibility: hidden; float: right; border: 2px solid darkred;">LOG OUT</a>
    <a id="google_log" href="#" onclick="signOut()" class="navbar-brand scroll-top" style="visibility: hidden; float: right; border: 2px solid darkred;">LOG OUT</a>
    <div class="container">
        <h2 style="text-align:center; font-size: 40px; color: white; display:block;"><%=cocktailsList.getName()%></h2>
    </div>
</div>

<!--Print cocktail-->
<section id="print_c">
    <div class="container" style="border: 2px solid navajowhite;">
        <div class="row">
            <div class="col-md-12">
                <div class="heading">
                    <h5 style="text-align:center; color:white; display:block;"><%=cocktailsList.getBase()%>, <%=cocktailsList.getTaste()%></h5>
                </div>
                <h4 style="text-align:center; color:white;">&mdash; Make it at home: &mdash;</h4>
                <iframe src=<%=cocktailsList.getLink()%> height="600px" width="1100px" target="_blank"></iframe>
            </div>
        </div>
        <br> <br>
        <div><h4 style="text-align: center; color: white;">&mdash; Or find a bar near you: &mdash;</h4></div>
        <br>
        <a href="maps.jsp" style="display: flex; align-items: center; justify-content: center;">
            <button style="position: absolute; align-self: center; text-align: center;">CLICK HERE</button>
        </a>
        <br>
    </div>
    <br>

</section>

<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>

</body>

</html>
