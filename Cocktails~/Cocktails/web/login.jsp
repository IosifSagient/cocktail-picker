<%--
  Created by IntelliJ IDEA.
  User: Anouk
  Date: 1/6/2021
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Cocktail Picker</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

  <link rel="stylesheet" href="css/style.css">

  <!-- Google sign-in -->
  <meta name="google-signin-scope" content="profile email">
  <meta name="google-signin-client_id" content="140271236674-p3j7pdfs2k2mn2vjmgvdg3jbjcddj33l.apps.googleusercontent.com">
  <script src="https://apis.google.com/js/platform.js" async defer></script>

</head>
<body class="img js-fullheight" style="background-image: url(images/cocktails.jpg);">
<section class="ftco-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6 text-center mb-5">
        <h2 class="heading-section">Login</h2>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-md-6 col-lg-4">
        <div class="login-wrap p-0">
          <h3 class="mb-4 text-center">Have an account?</h3>
          <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="signin-form">
            <div class="form-group">
              <input class="form-control" type="text" name="Email" placeholder="Email" required>
            </div>
            <div class="form-group">
              <input id="password-field" type="password" name="Password" class="form-control" placeholder="Password"  required>
              <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
            </div>
            <div class="form-group">
              <button type="submit" class="form-control btn btn-primary submit px-3">Sign In</button>
            </div>
            <div class="form-group d-md-flex">
              <div class="w-50">
              </div>
              <div class="w-50 text-md-right">
              </div>
            </div>
          </form>

          <p class="w-100 text-center">&mdash; Or Register here &mdash;</p>
          <div class="social d-flex text-center">
            <a href="register.jsp" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span> Register</a>
          </div>

          <div class="social d-flex text-center"> <br> </div>

          <p class="w-100 text-center">&mdash; Sign in with Google &mdash;</p>
          <div class="g-signin2" data-width="350" data-height="50" data-longtitle="true" data-onsuccess="onSuccess"> </div>
        </div>
      </div>
    </div>
  </div>
</section>

<script src="js/jquery.min.js"></script>
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>

<script>
  function onSignIn(googleUser) {
    // Useful data for your client-side scripts:
    var profile = googleUser.getBasicProfile();
    console.log("ID: " + profile.getId()); // Don't send this directly to your server!
    console.log('Full Name: ' + profile.getName());
    console.log("Email: " + profile.getEmail());

    // The ID token you need to pass to your backend:
    var id_token = googleUser.getAuthResponse().id_token;
    console.log("ID Token: " + id_token);

    var myUserEntity = {};
    myUserEntity.Name = profile.getName();

    //Store the entity object in sessionStorage where it will be accessible from all pages of your site.
    sessionStorage.setItem('myUserEntity',JSON.stringify(myUserEntity));
  }

  function onSuccess(googleUser) {
    console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
    window.location="mainIndex.jsp";

    var profile = googleUser.getBasicProfile();

    var myUserEntity = {};
    myUserEntity.Name = profile.getName();

    //Store the entity object in sessionStorage where it will be accessible from all pages of your site.
    sessionStorage.setItem('myUserEntity',JSON.stringify(myUserEntity));
  }
</script>

</body>
</html>
