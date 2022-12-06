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

</head>
<body class="img js-fullheight" style="background-image: url(images/cocktails.jpg);">
<section class="ftco-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6 text-center mb-5">
        <h2 class="heading-section">Register</h2>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-md-6 col-lg-4">
        <div class="login-wrap p-0">
          <h3 class="mb-4 text-center">Fill out the form below:</h3>
          <form action="${pageContext.request.contextPath}/RegisterUserServlet" method="post" class="signin-form">
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Username" name="Username" required>
            </div>
            <div class="form-group">
              <input type="email" class="form-control" placeholder="Email" name="Email" required>
            </div>
            <div class="form-group">
              <input id="password-field" type="password" class="form-control" placeholder="Password" name="Password" required>
              <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
            </div>
            <div class="form-group">
              <input id="password-field1" type="password" class="form-control" placeholder="Re-enter Password" name="Password1" required>
              <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
            </div>
            <div>
              <input type="date" id="datein" class="form-control" placeholder="Birthday" name="Birthday" required
                     value="date" min="1910-01-01" max="2050-12-31">
            </div>
            <div class="form-group"> </div>
            <div class="form-group">
              <button type="submit" class="form-control btn btn-primary submit px-3">Register</button>
            </div>
            <div class="form-group d-md-flex">
              <div class="w-50">
              </div>
              <div class="w-50 text-md-right">
              </div>
            </div>
          </form>

          <p class="w-100 text-center">&mdash; Or Login here &mdash;</p>
          <div class="social d-flex text-center">
            <a href="login.jsp" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span> Login</a>
          </div>
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
    n =  new Date();
    y = n.getFullYear();
    m = n.getMonth() + 1;
    d = n.getDate();
    document.getElementById("date").innerHTML = m + "/" + d + "/" + y;
</script>

</body>
</html>
