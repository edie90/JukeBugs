<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="app">
<head>  
  <meta charset="utf-8" />
  <title>Musik | Web Application</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="resources/js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/font.css" type="text/css" />
  <link rel="stylesheet" href="resources/css/app.css" type="text/css" />  
    <!--[if lt IE 9]>
    <script src="js/ie/html5shiv.js"></script>
    <script src="js/ie/respond.min.js"></script>
    <script src="js/ie/excanvas.js"></script>
  <![endif]-->
  
  <script>
  
  function checkboxSelect(obj, cnt){
	var i, sum = 1;	  
	var chk = document.getElementsByName(obj);
	
	for(i=0; i<chk.length; i++) if(chk[i].checked==true) sum++;
	
	if(sum>cnt){
		
		for(i=0; i<chk.length; i++) if(chk[i].checked==false) chk[i].disabled=true;
		
	} else {
		
		for(i=0; i<chk.length; i++) chk[i].disabled = false;
		
	}
  }
  
  </script>
  
  <script>
  function imageClick() {
	$('#file').trigger('click');
}
  
  function readURL(input) {
	  if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
              $('#blah').attr('src', e.target.result);
          }
          reader.readAsDataURL(input.files[0]);
      }
}
  </script>
</head>
<body class="bg-info dker" style="overflow: auto;">
  <section id="content" class="m-t-lg wrapper-md animated fadeInDown">
    <div class="container aside-xl">
      <a class="navbar-brand block" href="index.html"><span class="h1 font-bold">JukeBugs</span></a>
      <section class="m-b-lg">
        <header class="wrapper text-center">
          <strong>Sign up to find interesting thing</strong>
        </header>
        <form action="join" method="POST" enctype="multipart/form-data">
          <div class="form-group" style="text-align: center;">
            <input type="file" id="file" name="file" onchange="readURL(this);" style="display: none;">
            <a onclick="imageClick();"><img id="blah" style="background-color: white; height: 80px; width: 80px; border-radius: 50%; cursor: pointer;"></a>
          </div>
          <div class="form-group">
            <input type="email" placeholder="Email" name="userid" class="form-control rounded input-lg text-center no-border" required="required">
          </div>
          <div class="form-group">
             <input type="password" placeholder="Password" name="userpassword" class="form-control rounded input-lg text-center no-border" required="required">
          </div>
          <div class="form-group">
            <input placeholder="Name" name="username" class="form-control rounded input-lg text-center no-border" required="required">
          </div>
          <div class="form-group">
            <input placeholder="Nickame" name="usernick" class="form-control rounded input-lg text-center no-border" required="required">
          </div>
          <div class="form-group">
            <input placeholder="Question" name="userquestion" class="form-control rounded input-lg text-center no-border" required="required">
          </div>
          <div class="form-group">
            <input placeholder="Answer" name="useranswer" class="form-control rounded input-lg text-center no-border" required="required">
          </div>
          <div class="form-group">
          	 <!--  Genre
          	  <br>
          	  Like 1
          	  <br>
          	  <input type="radio" value="pop" name="like1">Pop
          	  <input type="radio" value="hiphop" name="like1">Hiphop
          	  <input type="radio" value="jazz" name="like1">Jazz
          	  <input type="radio" value="rock" name="like1">Rock
          	  <input type="radio" value="electronic" name="like1">Electronic
          	  <input type="radio" value="classic" name="like1">Classic
          	  <br>
          	  Like2
          	  <br>
          	  <input type="radio" value="pop">Pop
          	  <input type="radio" value="hiphop">Hiphop
          	  <input type="radio" value="jazz">Jazz
          	  <input type="radio" value="rock">Rock
          	  <input type="radio" value="electronic">Electronic
          	  <input type="radio" value="classic">Classic
          	  <br>
          	  Like3
          	  <br>
          	  <input type="radio" value="pop">Pop
          	  <input type="radio" value="hiphop">Hiphop
          	  <input type="radio" value="jazz">Jazz
          	  <input type="radio" value="rock">Rock
          	  <input type="radio" value="electronic">Electronic
          	  <input type="radio" value="classic">Classic -->
			  <header class="wrapper text-center">
					<strong>Choose Your Genres</strong>
			  </header>
	          <input type="checkbox" name="chk[]" value="pop" onclick="checkboxSelect('chk[]', 3)"><strong>Pop</strong>
              <input type="checkbox" name="chk[]" value="hiphop" onclick="checkboxSelect('chk[]', 3)"><strong>HipHop</strong>
              <input type="checkbox" name="chk[]" value="jazz" onclick="checkboxSelect('chk[]', 3)"><strong>Jazz</strong>
              <input type="checkbox" name="chk[]" value="rock" onclick="checkboxSelect('chk[]', 3)"><strong>Rock</strong>
              <input type="checkbox" name="chk[]" value="electronic" onclick="checkboxSelect('chk[]', 3)"><strong>Electronic</strong>
            <!--   <input type="checkbox" name="favor"><label>Country</label> -->
              <input type="checkbox" name="chk[]" value="classic" onclick="checkboxSelect('chk[]', 3)"><strong>Classic</strong>
              
<!--               <input type="checkbox" name="favor"><i></i> Agree the <a href="#">terms and policy</a>
              <input type="checkbox" name="favor"><i></i> Agree the <a href="#">terms and policy</a>
              <input type="checkbox" name="favor"><i></i> Agree the <a href="#">terms and policy</a>
              <input type="checkbox" name="favor"><i></i> Agree the <a href="#">terms and policy</a> -->
          </div>
          <button type="submit" class="btn btn-lg btn-warning lt b-white b-2x btn-block btn-rounded"><i class="icon-arrow-right pull-right"></i><span class="m-r-n-lg">Sign up</span></button>
          <div class="line line-dashed"></div>
          <p class="text-muted text-center"><small>Already have an account?</small></p>
          <a href="signin.html" class="btn btn-lg btn-info btn-block btn-rounded">Sign in</a>
        </form>
      </section>
    </div>
  </section>
  <!-- footer -->
  <footer id="footer">
    <div class="text-center padder clearfix">
      <p>
        <small>Web app framework base on Bootstrap<br>&copy; 2014</small>
      </p>
    </div>
  </footer>
  <!-- / footer -->
  <script src="resources/js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="resources/js/bootstrap.js"></script>
  <!-- App -->
  <script src="resources/js/app.js"></script>  
  <script src="resources/js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="resources/js/app.plugin.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/demo.js"></script>
</body>
</html>