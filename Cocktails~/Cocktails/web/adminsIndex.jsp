<%--
  Created by IntelliJ IDEA.
  User: Anouk
  Date: 1/6/2021
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- MAIN PAGE FOR ADMINS -->
<!DOCTYPE html>
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

<!--header-->
<div class="header">
    <a class="navbar-brand scroll-top" style="text-align: left; font-size: 20px;"><b>WELCOME! </b></a>
    <a id="log" href="<%=request.getContextPath()%>/LogoutServlet" class="navbar-brand scroll-top" style="visibility: hidden; float: right; border: 2px solid darkred;">LOG OUT</a>
    <a id="google_log" href="#" onclick="signOut()" class="navbar-brand scroll-top" style="visibility: hidden; float: right; border: 2px solid darkred;">LOG OUT</a>
    <div class="container">
        <a href="#" class="navbar-brand scroll-top" style="text-align:center; font-size: 40px; display:block;">Cocktail Picker</a>
    </div>
</div>

<!--Find cocktail section-->
<section id="choose_c">
    <div class="container" style="border: 4px solid navajowhite;">
        <div class="row">
            <div class="col-md-12">
                <div class="heading">
                    <h2 style="text-align:center; color:white; display:block;">Fill out the form below to add a cocktail:</h2>
                </div>
            </div>
                <div class="container" style="text-align:center;">
                    <form action="${pageContext.request.contextPath}/AddCocktailServlet" method="post" enctype="multipart/form-data">
                       <label for="base">Base liquor:</label>
                        <select id="base" name="Base" required>
                            <option value="Vodka" name="Vodka">Vodka</option>
                            <option value="Gin" name="Gin">Gin</option>
                            <option value="Whiskey" name="Whiskey">Whiskey</option>
                            <option value="Rum" name="Rum">Rum</option>
                        </select>

                        <label for="taste">Taste:</label>
                        <select id="taste" name="Taste" required>
                            <option value="Sweet" name="Sweet">Sweet</option>
                            <option value="Sour" name="Sour">Sour</option>
                            <option value="Spicy" name="Spicy">Spicy</option>
                            <option value="Sweet&Sour" name="Sweet&Sour">Sweet & Sour</option>
                            <option value="Sweet&Spicy" name="Sweet&Spicy">Sweet & Spicy</option>
                        </select>

                        <label>Name of cocktail:</label>
                        <div>
                            <input type="text" id="Name" name="Name" placeholder="Name" required>
                        </div>

                        <label>Link of recipe:</label>
                        <div>
                            <input type="text" id="Link" name="Link" placeholder="Link" required>
                        </div>

                        <label for="Image">Select image for cocktail:</label>
                        <div>
                            <input type="file" id="Image" name="Image" accept="image/*" multiple="false" required>
                        </div>
                    <br>
                    <div>
                        <input type="submit" value="SUBMIT" style="background-color: mediumseagreen; width: 50%;">
                    </div>
                    <br>
                    </form>
                </div>
        </div>
    </div>
</section>

<p><br><br></p>

<!--Choose cocktail section-->
<section class="drinks">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="heading">
                    <h2 style="text-align:center; color:white; display:block;">Choose by category:</h2>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="service-item">
                    <a id="Vodka" value="Vodka" href="${pageContext.request.contextPath}/AdminDrinkServlet?Base=Vodka" method="get">
                        <img src="images/vodka.png" alt="Vodka">
                        <h4 style="color: navajowhite;">Vodka</h4>
                    </a>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="service-item">
                    <a id="Gin" value="Gin" href="${pageContext.request.contextPath}/AdminDrinkServlet?Base=Gin" method="get">
                        <img src="images/gin.png" alt="Gin">
                        <h4 style="color: navajowhite;">Gin</h4>
                    </a>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="service-item">
                    <a id="Whiskey" value="Whiskey" href="${pageContext.request.contextPath}/AdminDrinkServlet?Base=Whiskey" method="get">
                        <img src="images/whiskey.png" alt="Whiskey">
                        <h4 style="color: navajowhite;">Whiskey</h4>
                    </a>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="service-item">
                    <a id="Rum" value="Rum" href="${pageContext.request.contextPath}/AdminDrinkServlet?Base=Rum" method="get">
                        <img src="images/rum.png" alt="Rum">
                        <h4 style="color: navajowhite;">Rum</h4>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>

</body>

</html>
