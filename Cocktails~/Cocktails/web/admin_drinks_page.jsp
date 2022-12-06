<%@ page import="mainpackage.datapackage.Cocktails" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Anouk
  Date: 2/6/2021
  Time: 18:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ADMIN'S PAGE WHEN CHOOSING A DRINK CATEGORY -->
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
        /* Style buttons */
        .btn {
            background-color: Red;
            border: none; /* Remove borders */
            color: white; /* White text */
            padding: 10px 12px; /* Some padding */
            font-size: 12px; /* Set a font size */
            cursor: pointer; /* Mouse pointer on hover */
        }

        /* Darker background on mouse-over */
        .btn:hover {
            background-color: Red;
        }

        /* Delete Modal */
        * {box-sizing: border-box}

        /* Float cancel and delete buttons and add an equal width */
        .cancelbtn, .deletebtn {
            float: left;
            width: 50%;
        }

        /* Add a color to the cancel button */
        .cancelbtn {
            background-color: #ccc;
            color: black;
        }

        /* Add a color to the delete button */
        .deletebtn {
            background-color: #f44336;
        }

        /* Add padding and center-align text to the container */
        .container {
            padding: 16px;
            text-align: center;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: #474e5d;
            padding-top: 50px;
        }

        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        /* Style the horizontal ruler */
        hr {
            border: 1px solid #f1f1f1;
            margin-bottom: 25px;
        }

        /* The Modal Close Button (x) */
        .close {
            position: absolute;
            right: 35px;
            top: 15px;
            font-size: 40px;
            font-weight: bold;
            color: #f1f1f1;
        }

        .close:hover,
        .close:focus {
            color: #f44336;
            cursor: pointer;
        }

        /* Clear floats */
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }

        /* Change styles for cancel button and delete button on extra small screens */
        @media screen and (max-width: 300px) {
            .cancelbtn, .deletebtn {
                width: 100%;
            }
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
            <% for (int i = 0; i < cocktailsList.size(); i++) { %>
            <%-- Dynamic creation of squares --%>
            <div class="col-md-4">
                <div class="food-item">
                    <a name="Name" id="Name" value="Name" href="<%=request.getContextPath()%>/CocktailServlet2?Name=<%=cocktailsList.get(i).getName()%>" method="get" style="font-size: 20px; color: white;"><%=cocktailsList.get(i).getName()%></a>
                    <button class="btn" id="<%=cocktailsList.get(i).getName()%>" onclick="document.getElementById('id01').style.display='block'"><i class="fa fa-close"></i></button>
                    <div name="Taste" value="Taste"><%=cocktailsList.get(i).getTaste()%></div>
                    <a href="<%=request.getContextPath()%>/CocktailServlet2?Name=<%=cocktailsList.get(i).getName()%>" method="get" style="font-size: 20px; color: white;">
                        <img type="file" name="Image" value="Image" src="data:image/png;base64, <%=cocktailsList.get(i).getImage()%>" alt="" width="300" height="250">
                    </a>
                    <div class="text-content">
                        <h4></h4>
                        <br>
                        <p></p>
                    </div>
                </div>
            </div>
            <div id="id01" class="modal">
                <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
                <form action="${pageContext.request.contextPath}/DeleteCocktailServlet?cocktailName=<%=cocktailsList.get(i).getName()%>" name="delete_form" class="modal-content" method="post" enctype="multipart/form-data">
                    <div class="container">
                        <h1>DELETE: <%=cocktailsList.get(i).getName()%></h1>
                        <p>Are you sure you want to delete this cocktail?</p>

                        <div class="clearfix">
                            <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
                            <input type="submit" value="Delete" class="deletebtn">
                        </div>
                    </div>
                </form>
            </div>
            <% } %>
        </div>

    </div>
</section>

<script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>

</body>

</html>
