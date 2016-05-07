<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="app">
<head>  
  <meta charset="utf-8" />
  <title>Musik | Web Application</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="resources/js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="resources/css4/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="resources/css4/animate.css" type="text/css" />
  <link rel="stylesheet" href="resources/css4/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="resources/css4/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="resources/css4/font.css" type="text/css" />
  <link rel="stylesheet" href="resources/css4/app.css" type="text/css" />  
    <!--[if lt IE 9]>
    <script src="js/ie/html5shiv.js"></script>
    <script src="js/ie/respond.min.js"></script>
    <script src="js/ie/excanvas.js"></script>
  <![endif]-->
  <script src="resources/js/jquery-2.2.2.min.js"></script>
<script>
$(function(){
	$.ajax({
		  url:"getRecommendationSong"
		, method:"GET"
		, dataType: "JSON"
		, contentType: "application/json; charset=UTF-8"
		, success: function(obj){
			$(obj).each(function(i, item){
				$('#song'+(i+1)+'rank').html('<strong class="h4">Ranking # ' + item.ranking + '</h4>');
				$('#song'+(i+1)+'songid').attr('href', item.songid);   /* player에서 필요한 값 주기. */
				$('#song'+(i+1)+'title').text(item.songtitle);
				$('#song'+(i+1)+'title').attr('href', "searchAlbumSong?albumid=" + item.albumid); /* text를 누르면 해당 곡의 album 페이지로 가기 */
				$('#song'+(i+1)+'text').text("");    /* 제목 밑 빈 공간. 뭐 넣을지 몰라서 비워놓음*/
		//		$('#song'+(i+1)+'img').attr('src', item.albumimgurl);
			});
		}
	});
	$.ajax({
		 url:"getRecommendationAlbum"
		, method:"GET"
		, dataType: "JSON"
		, contentType: "application/json; charset=UTF-8"
		, success: function(obj){
			$(obj).each(function(i, item){
				$('#album'+(i+1)+'rank').html('<strong class="h4">Ranking # ' + item.ranking + '</h4>');
				$('#album'+(i+1)+'albumid').attr('href', item.albumid);   /* player에서 필요한 값 주기. */
				$('#album'+(i+1)+'title').text(item.albumtitle);
				$('#album'+(i+1)+'title').attr('href', "searchAlbumSong?albumid=" + item.albumid); /* text를 누르면 해당 곡의 album 페이지로 가기 */
				$('#album'+(i+1)+'text').text("");    /* 제목 밑 빈 공간. 뭐 넣을지 몰라서 비워놓음*/
		//		$('#album'+(i+1)+'img').attr('src', item.albumimgurl);
			});
		}
	});
});
</script>
</head><!-- homeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee -->
<body class="" style="overflow : hidden;">
  <section class="vbox">
    <header class="bg-white-only header header-md navbar navbar-fixed-top-xs">
      <div class="navbar-header aside bg-info nav-xs">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="icon-list"></i>
        </a>
        <a href="#" class = "navbar-brand text-lt linkToPage" movePage = "main" >
          <i class="icon-earphones"></i>
          <img src="resources/images/logo.png" alt="." class="hide">
          <span class="hidden-nav-xs m-l-sm">Musik</span>
        </a>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user">
          <i class="icon-settings"></i>
        </a>
      </div>      <ul class="nav navbar-nav hidden-xs">
        <li>
          <a href="#nav,.navbar-header" data-toggle="class:nav-xs,nav-xs" class="text-muted">
            <i class="fa fa-indent text"></i>
            <i class="fa fa-dedent text-active"></i>
          </a>
        </li>
      </ul>
      <form class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" method="get" action="search" role="search">
        <div class="form-group">
          <div class="input-group">
            <span class="input-group-btn">
              <button type="submit" id="btn_search" class="btn btn-sm bg-white btn-icon rounded"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border rounded" name="content" placeholder="Search songs, albums...">
          </div>
        </div>
      </form>
    <c:if test="${not empty loginId }">
      <div class="navbar-right ">
        <ul class="nav navbar-nav m-n hidden-xs nav-user user">
          <li class="hidden-xs">
            <a href="#" class="dropdown-toggle lt" data-toggle="dropdown">
              <i class="icon-bell"></i>
              <span class="badge badge-sm up bg-danger count">2</span>
            </a>
            <section class="dropdown-menu aside-xl animated fadeInUp">
              <section class="panel bg-white">
                <div class="panel-heading b-light bg-light">
                  <strong>You have <span class="count">2</span> notifications</strong>
                </div>
                <div class="list-group list-group-alt">
                  <a href="#" class="media list-group-item">
                    <span class="pull-left thumb-sm">
                      <img src="resources/images/a0.png" alt="..." class="img-circle">
                    </span>
                    <span class="media-body block m-b-none">
                      Use awesome animate.css<br>
                      <small class="text-muted">10 minutes ago</small>
                    </span>
                  </a>
                  <a href="#" class="media list-group-item">
                    <span class="media-body block m-b-none">
                      1.0 initial released<br>
                      <small class="text-muted">1 hour ago</small>
                    </span>
                  </a>
                </div>
                <div class="panel-footer text-sm">
                  <a href="#" class="pull-right"><i class="fa fa-cog"></i></a>
                  <a href="#notes" data-toggle="class:show animated fadeInRight">See all the notifications</a>
                </div>
              </section>
            </section>
          </li>
          
          <li class="dropdown">
            <a href="#" class="dropdown-toggle bg clear" data-toggle="dropdown">
              <span class="thumb-sm avatar pull-right m-t-n-sm m-b-n-sm m-l-sm">
                <img src="resources/images/a0.png" alt="...">
              </span>
             ${userNick}<b class="caret"></b>
            </a>
            <ul class="dropdown-menu animated fadeInRight">            
              <li>
                <span class="arrow top"></span>
                <a href="#"></a>
              </li>
              <li>
                <a href="profile">Profile</a>
              </li>
              <li>
                <!-- <a href="#">
                  <span class="badge bg-danger pull-right"></span>
      
                </a> -->
              </li>
              <!-- <li>
                <a href="docs.html"></a>
              </li> -->
              <li class="divider"></li>
              <li>
                <a href="logout" >Logout</a>
              </li>
            </ul>
          </li>
        </ul>
      </div> 
      </c:if>
    </header>
    <section>
      <section class="hbox stretch">
        <!-- .aside -->
        <aside class="bg-black dk nav-xs aside hidden-print" id="nav">          
          <section class="vbox">
            <section class="w-f-md scrollable">
              <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                


                <!-- nav -->                 
                <nav class="nav-primary hidden-xs">
                  <ul class="nav bg clearfix">
                    <li>
                      <a href="#" class = "linkToPage" movePage = "home">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">What's new</span>
                      </a>
                    </li>
                    <li>
                      <a href="#" class = "linkToPage" movePage = "All">
                        <i class="icon-music-tone-alt icon text-info"></i>
                        <span class="font-bold">Genres</span>
                      </a>
                    </li>
                    <li>
                      <a href="#" class = "linkToPage" movePage = "listen">
                        <i class="icon-list icon  text-info-dker"></i>
                        <span class="font-bold">Listen</span>
                      </a>
                    </li>
                    <li>
                      <a href="#" class = "linkToPage" movePage = "logInfo" >
                        <i class="icon-screen-desktop icon"></i>
                        <span class="font-bold">Log</span>
                      </a>
                    </li>
                    <li>
                   	 <a href="#" class="auto linkToPage" movePage = "musicRecognition">       
                        <i class="icon-microphone"></i>
                        <span class="font-bold">Music Recognition</span>
                      </a>
                    </li>
                  </ul>
                </nav>
                <!-- / nav -->
              </div>
            </section>
            
            <footer class="footer hidden-xs no-padder text-center-nav-xs">
              <div class="bg hidden-xs ">
                  <div class="dropdown dropup wrapper-sm clearfix">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                      <span class="thumb-sm avatar pull-left m-l-xs">                        
                        <img src="resources/images/a3.png" class="dker" alt="...">
                        <i class="on b-black"></i>
                      </span>
                      <span class="hidden-nav-xs clear">
                        <span class="block m-l">
                          <strong class="font-bold text-lt">${userNick}</strong> 
                          <b class="caret"></b>
                        </span>
                        <span class="text-muted text-xs block m-l"></span>
                      </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight aside text-left">                      
                      <!-- <li>
                        <span class="arrow bottom hidden-nav-xs"></span>
                        <a href="#">Settings</a>
                      </li> -->
                      <li>
                        <a href="profile">Profile</a>
                      </li>
                      <li>
                       <!--  <a href="#">
                          <span class="badge bg-danger pull-right">3</span>
                          Notifications
                        </a> -->
                      </li>
                      <!-- <li>
                        <a href="docs.html"></a>
                      </li> -->
                      <li class="divider"></li>
                      <li>
                        <a href="logout" >Logout</a>
                      </li>
                    </ul>
                  </div>
                </div>            </footer>
          </section>
        </aside>
        <!-- /.aside -->
        <section id="content">
          <section class="vbox">
          <section class="scrollable w-f-md">
	          <div class="col-lg-12">
		          	<h4 class="font-thin m-l-md m-t">
		          		<a href="home"><b>Recommendations</b></a>      /       
		          		<a href="/JukeBugs/"> Rankings</a></h4>
	          </div>
            <div id="masonry" class="pos-rlt animated fadeInUpBig" style="margin-top: 50px;">
              
              <div class="item"> <!-- 1-1 -->
                <div class="carousel slide auto" data-interval="3000">
                  <div class="carousel-inner">
                    <div class="item active">
                      <div class="item-overlay opacity animated fadeInDown wrapper bg-info">
                      		<div class="pull-right" id="song1rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n"><!--a tag: play by songid -->
                          <a href="#" id="song1songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                      <div class="bottom wrapper bg-info gd"><!-- href="search?albumid=123" -->
                        <div class="m-t m-b"><a href="#" class="b-b b-danger h2 text-u-c text-lt font-bold" id="song1title">Teideal</a></div>
                        <p class="hidden-xs" id="song1text">Morbi nec nunc condimentum, egestas dui nec, fermentum diam. Vivamus vel tincidunt libero, vitae elementum ligula</p>
                      </div>
                      <a href="#"><img src="resources/images/m20.jpg" alt="" class="img-full" id="song1img"></a>
                    </div>
                    <div class="item"><!-- 1-2 -->
                      <div class="item-overlay opacity animated fadeInDown wrapper bg-info">
                      			<div class="pull-right" id="album1rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album1albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                      <div class="bottom wrapper bg-info gd">
                        <div class="m-t m-b"><a href="#" class="b-b b-warning h2 text-u-c text-lt font-bold" id="album1title">Tincidunt</a></div>
                        <p class="hidden-xs" id="album1text">Gestas dui nec, fermentum diam. Vivamus vel tincidunt libero, vitae ligula elementum</p>
                      </div>
                      <a href="#"><img src="resources/images/m22.jpg" alt="" class="img-full" id="album1img"></a>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="item"><!-- 2 -->
                <div class="item-overlay gd animated fadeInUp wrapper bg-info">
                     	<div class="pull-right" id="album2rank">Ranking </div>
                  <p class="text-white"><i class="icon-disc">  Album</i></p>
                  <div class="center text-center m-t-n">
                    <a href="#" id="album2albumid"><i class="icon-control-play i-2x"></i></a>
                  </div>
                </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album2title">Tincidunt</a></div>
                  <p class="hidden-xs" id="album2text">Vivamus vel tincidunt libero, lementum ligula vitae</p>
                </div>
                <a href="#"><img src="resources/images/m31.jpg" alt="" class="img-full" id="album2img"></a>
              </div>
              
              <div class="item"><!-- 3 -->
              	<div class="item-overlay opacity animated fadeIn wrapper bg-info">
              	                  	<div class="pull-right" id="song2rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n"><!--a tag: play by songid -->
                          <a href="#" id="song2songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-warning h4 text-u-c text-lt font-bold" id="song2title">Duis</a></div>
                  <p class="hidden-xs" id="song2text">Tincidunt libero vitae elementum</p>
                </div>
                <a href="#"><img src="resources/images/m10.jpg" alt="" class="img-full" id="song2img"></a>
              </div>
              
              <div class="item"><!-- 4 -->
              	<div class="item-overlay opacity animated fadeInUp wrapper bg-info">
              				<div class="pull-right" id="album3rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n"><!--a tag: play by songid -->
                          <a href="#" id="album3albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-warning h4 text-u-c text-lt font-bold" id="album3title">Duis</a></div>
                  <p class="hidden-xs" id="album3text">Tincidunt libero vitae elementum</p>
                </div>
                <a href="#"><img src="resources/images/m10.jpg" alt="" class="img-full" id="album3img"></a>
              </div>
              
              <div class="item"><!-- 5 -->
              <div class="item-overlay opacity animated fadeInRight wrapper bg-info">
              				<div class="pull-right" id="song3rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n"><!--a tag: play by songid -->
                          <a href="#" id="song3songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song3title">Diam</a></div>
                  <p class="hidden-xs" id="song3text">Con malesuada est, quis congue nibhs</p>
                </div>
                <a href="#"><img src="resources/images/m4.jpg" alt="" class="img-full" id="song3img"></a>
              </div>
              
              <div class="item"> <!-- 6-1 -->
                <div class="carousel carousel-fade bg-dark slide auto" data-interval="4000">
                  <div class="carousel-inner">
                    <div class="item active"><!-- <img src="resources/images/album.png" style="width: 30px; height: 30px;"> -->
                      <div class="item-overlay opacity animated fadeInDown wrapper bg-dark">
                      			<div class="pull-right" id="song4rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n"><!--a tag: play by songid -->
                          <a href="#" id="song4songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                      <div class="bottom wrapper bg-info gd"><!-- href="search?albumid=123" -->
                        <div class="m-t m-b"><a href="#" class="b-b b-danger h4 text-u-c text-lt font-bold" id="song4title">Teideal</a></div>
                        <p class="hidden-xs" id="song4text">Morbi nec nunc condimentum, egestas dui nec, fermentum diam. Vivamus vel tincidunt libero, vitae elementum ligula</p>
                      </div>
                      <a href="#"><img src="resources/images/m20.jpg" alt="" class="img-full" id="song4img"></a>
                    </div>
                    <div class="item"><!-- 6-2 -->
                      <div class="item-overlay opacity animated fadeInDown wrapper bg-dark">
                      			<div class="pull-right" id="album3rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album4songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                      <div class="bottom wrapper bg-info gd">
                        <div class="m-t m-b"><a href="#" class="b-b b-warning h4 text-u-c text-lt font-bold" id="album4title">Tincidunt</a></div>
                        <p class="hidden-xs" id="album4text">Gestas dui nec, fermentum diam. Vivamus vel tincidunt libero, vitae ligula elementum</p>
                      </div>
                      <a href="#"><img src="resources/images/m22.jpg" alt="" class="img-full" id="album4img"></a>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="item"><!-- 7 -->
                	<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
                				<div class="pull-right" id="album5rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album5albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album5title">Vivamus</a></div>
                  <p class="hidden-xs" id="album5text">Morbi id neque quam. Aliquam sollicitudin venenatis ipsum</p>
                </div>
                <a href="#"><img src="resources/images/m13.jpg" alt="" class="img-full" id="album5img"></a>
              </div>
              
              <div class="item"><!-- 8 -->
                    <div class="item-overlay opacity animated fadeInRight wrapper bg-dark">
                    			<div class="pull-right" id="song5rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song5songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-warning h4 text-u-c text-lt font-bold" id="song5title">Libero</a></div>
                  <p class="hidden-xs" id="song5text">Aliquam sollicitudin venenatis ipsum</p>
                </div>
                <a href="#"><img src="resources/images/m30.jpg" alt="" class="img-full" id="song5img"></a>
              </div>
              
              <div class="item"><!-- 9 -->
              	<div class="item-overlay opacity animated fadeInLeft wrapper bg-dark">
              				<div class="pull-right" id="album6rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album6albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album6title">habitant</a></div>
                  <p class="hidden-xs" id="album6text">Vel tincidunt libero, vitae ligula tristique</p>
                </div>
                <a href="#"><img src="resources/images/m19.jpg" alt="" class="img-full" id="album6img"></a>
              </div>
              
              <div class="item"><!-- 10 -->
              	<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
              				<div class="pull-right" id="song6rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song6songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song6title">habitant</a></div>
                  <p class="hidden-xs" id="song6text">Vel tincidunt libero, vitae ligula tristique</p>
                </div>
                <a href="#"><img src="resources/images/m19.jpg" alt="" class="img-full" id="song6img"></a>
              </div>
              
              <div class="item"><!-- 11 -->
             	 <div class="item-overlay opacity animated fadeInDown wrapper bg-dark">
             	 			<div class="pull-right" id="song7rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song7songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song7title">Malesuada</a></div>
                  <p class="hidden-xs" id="song7text">Pellentesque habitant morbi tristique sodales</p>
                </div>
                <a href="#"><img src="resources/images/m7.jpg" alt="" class="img-full" id="song7img"></a>
              </div>
              
              <div class="item"><!-- 12 -->
             	 <div class="item-overlay opacity animated fadeIn wrapper bg-dark">
             	 				<div class="pull-right" id="album7rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album7albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album7title">Donec</a></div>
                  <p class="hidden-xs" id="album7text">Vestibulum ullamcorper</p>
                </div>
                <a href="#"><img src="resources/images/m18.jpg" alt="" class="img-full" id="album7img"></a>
              </div>
              
              <div class="item"><!-- 13 -->
              	<div class="item-overlay opacity animated fadeInUp wrapper bg-dark">
              				<div class="pull-right" id="song8rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song8songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-primary h4 text-u-c text-lt font-bold" id="song8title">Eleifend</a></div>
                  <p class="hidden-xs" id="song8text">Malesuada augue. Donec eleifend condimentum</p>
                </div>
                <a href="#"><img src="resources/images/m32.jpg" alt="" class="img-full" id="song8img"></a>
              </div>
              
              <div class="item"><!-- 14 -->
              	<div class="item-overlay opacity animated fadeInDown wrapper bg-dark">
              				<div class="pull-right" id="album8rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album8albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album8title">Sollicitudin </a></div>
                  <p class="hidden-xs" id="album8text">Mauris convallis mauris at pellentesque volutpat</p>
                </div>
                <a href="#"><img src="resources/images/m40.jpg" alt="" class="img-full" id="album8img"></a>
              </div>
              
             <div class="item"> <!-- 15-1 -->
                <div class="carousel slide auto" data-interval="3000">
                  <div class="carousel-inner">
                    <div class="item active">
                      <div class="item-overlay opacity animated fadeInDown wrapper bg-info">
                      			<div class="pull-right" id="song9rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n"><!--a tag: play by songid -->
                          <a href="#" id="song9songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                      <div class="bottom wrapper bg-info gd"><!-- href="search?albumid=123" -->
                        <div class="m-t m-b"><a href="#" class="b-b b-danger h2 text-u-c text-lt font-bold" id="song9title">Teideal</a></div>
                        <p class="hidden-xs" id="song9text">Morbi nec nunc condimentum, egestas dui nec, fermentum diam. Vivamus vel tincidunt libero, vitae elementum ligula</p>
                      </div>
                      <a href="#"><img src="resources/images/m20.jpg" alt="" class="img-full" id="song9img"></a>
                    </div>
                    <div class="item"><!-- 15-2 -->
                      <div class="item-overlay opacity animated fadeInDown wrapper bg-info">
                      			<div class="pull-right" id="album9rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album9albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                      <div class="bottom wrapper bg-info gd">
                        <div class="m-t m-b"><a href="#" class="b-b b-warning h2 text-u-c text-lt font-bold" id="album9title">Tincidunt</a></div>
                        <p class="hidden-xs" id="album9text">Gestas dui nec, fermentum diam. Vivamus vel tincidunt libero, vitae ligula elementum</p>
                      </div>
                      <a href="#"><img src="resources/images/m22.jpg" alt="" class="img-full" id="album9img"></a>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="item"><!-- 16 -->
              	<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
              				<div class="pull-right" id="song10rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song10songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song10title">Phasellus</a></div>
                  <p class="hidden-xs" id="song10text">Senectus et netus et malesuada fames</p>
                </div>
                <a href="#"><img src="resources/images/m5.jpg" alt="" class="img-full" id="song10img"></a>
              </div>
              
              <div class="item"><!-- 17 -->
              		<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
              				<div class="pull-right" id="song11rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song11songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-white h4 text-u-c text-lt font-bold" id="song11title">Neque</a></div>
                  <p class="hidden-xs" id="song11text">Consectetur adipiscing elit. Morbi id neque quam</p>
                </div>
                <a href="#"><img src="resources/images/a10.png" alt="" class="img-full" id="song11img"></a>
              </div>
              
              <div class="item"><!-- 18 -->
              		<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
              					<div class="pull-right" id="song12rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song12songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song12title">Nisi ne</a></div>
                  <p class="hidden-xs" id="song12text">Orbi tristique senectus et netus et malesuada</p>
                </div>
                <a href="#"><img src="resources/images/m4.jpg" alt="" class="img-full" id="song12img"></a>
              </div>
              
              <div class="item"><!-- 19 -->
              		<div class="item-overlay opacity animated fadeInDown wrapper bg-dark">
              				<div class="pull-right" id="album10rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album10albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album10title">Nisi ne</a></div>
                  <p class="hidden-xs" id="album10text">Orbi tristique senectus et netus et malesuada</p>
                </div>
                <a href="#"><img src="resources/images/m4.jpg" alt="" class="img-full" id="album10img"></a>
              </div>
              
              <div class="item"><!-- 20 -->
              		<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
              				<div class="pull-right" id="song13rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song13songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song13title">Congue</a></div>
                  <p class="hidden-xs" id="song13text">Malesuada est, quis congue nibh</p>
                </div>
                <a href="#"><img src="resources/images/m6.jpg" alt="" class="img-full" id="song13img"></a>
              </div>
              
              <div class="item"><!-- 21 -->
              		<div class="item-overlay opacity animated fadeInUp wrapper bg-dark">
              				<div class="pull-right" id="song14rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song14songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song14title">Congue</a></div>
                  <p class="hidden-xs" id="song14text">Malesuada est, quis congue nibh</p>
                </div>
                <a href="#"><img src="resources/images/m6.jpg" alt="" class="img-full" id="song14img"></a>
              </div>
              
              <div class="item"><!-- 22 -->
              	<div class="item-overlay opacity animated fadeInDown wrapper bg-dark">
              				<div class="pull-right" id="album11rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album11albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album11title">Consectetur</a></div>
                  <p class="hidden-xs" id="album11text">Adipiscing elit senectus et netus mal.</p>
                </div>
                <a href="#"><img src="resources/images/m42.jpg" alt="" class="img-full" id="album11img"></a>
              </div>
              
              <div class="item"><!-- 23 -->
              		<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
              					<div class="pull-right" id="song15rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song15songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song15title">Morbi</a></div>
                  <p class="hidden-xs" id="song15text">Dolor sit amet, consectetur adipiscing elit.</p>
                </div>
                <a href="#"><img src="resources/images/m9.jpg" alt="" class="img-full" id="song15img"></a>
              </div>
              
              <div class="item"><!-- 24 -->
              	<div class="item-overlay opacity animated fadeInUp wrapper bg-dark">
              				<div class="pull-right" id="song16rank">Ranking </div>
                        <p class="text-white"><i class="icon-music-tone-alt">  Song</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="song16songid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="song16title">Soesle</a></div>
                  <p class="hidden-xs" id="song16text">Adipiscing elituis congue</p>
                </div>
                <a href="#"><img src="resources/images/a7.png" alt="" class="img-full" id="song16img"></a>
              </div>
              
              <div class="item"><!-- 25 -->
              		<div class="item-overlay opacity animated fadeIn wrapper bg-dark">
              					<div class="pull-right" id="album12rank">Ranking </div>
                        <p class="text-white"><i class="icon-disc">  Album</i></p>
                        <div class="center text-center m-t-n">
                          <a href="#" id="album12albumid"><i class="icon-control-play i-2x"></i></a>
                        </div>
                      </div>
                <div class="bottom gd bg-info wrapper">
                  <div class="m-t m-b"><a href="#" class="b-b b-info h4 text-u-c text-lt font-bold" id="album12title">Congue</a></div>
                  <p class="hidden-xs" id="album12text">Malesuada est, congue nibh quis elituis</p>
                </div>
                <a href="#"><img src="resources/images/m12.jpg" alt="" class="img-full" id="album12img"></a>
              </div>
              
            </div>
          </section>
          <!-- jplayer -->
          <footer class="footer bg-dark">
			  <div id="jp_container_N">
                    <div class="jp-type-playlist">
                    <div id="jplayer_N" class="jp-jplayer hide"></div>
                      <div class="jp-gui">
					  	<div class="jp-video-play hide">
                         	<a class="jp-video-play-icon">play</a>
                       	</div>                   
                      	<div class="jp-interface">
                          <div class="jp-controls">
                          	<div><a class="jp-previous"><i class="icon-control-rewind i-lg"></i></a></div>
                            <div>
                              <a class="jp-play"><i class="icon-control-play i-2x"></i></a>
                              <a class="jp-pause hid"><i class="icon-control-pause i-2x"></i></a>
                            </div>
                          	<div><a class="jp-next"><i class="icon-control-forward i-lg"></i></a></div>
                            <div class="hide"><a class="jp-stop"><i class="fa fa-stop"></i></a></div>
                            <div><a class="" data-toggle="dropdown" data-target="#playlist"><i class="icon-list"></i></a></div>
                            <div class="jp-progress hidden-xs">
                              <div class="jp-seek-bar dk">
                                <div class="jp-play-bar bg-info">
                                </div>
                                <div class="jp-title text-lt">
                                  <ul>
                                    <li></li>
                                  </ul>
                                </div>
                              </div>
                            </div>
                          	<div class="hidden-xs hidden-sm jp-current-time text-xs text-muted"></div>
                            <div class="hidden-xs hidden-sm jp-duration text-xs text-muted"></div>
                            <div class="hidden-xs hidden-sm">
                              <a class="jp-mute" title="mute"><i class="icon-volume-2"></i></a>
                              <a class="jp-unmute hid" title="unmute"><i class="icon-volume-off"></i></a>
                            </div>
                          	<div class="hidden-xs hidden-sm jp-volume">
                              <div class="jp-volume-bar dk">
                                <div class="jp-volume-bar-value lter"></div>
                              </div>
                            </div>
                            <div>
                              <a class="jp-shuffle" title="shuffle"><i class="icon-shuffle text-muted"></i></a>
                              <a class="jp-shuffle-off hid" title="shuffle off"><i class="icon-shuffle text-lt"></i></a>
                            </div>
                            <div>
                              <a class="jp-repeat" title="repeat"><i class="icon-loop text-muted"></i></a>
                              <a class="jp-repeat-off hid" title="repeat off"><i class="icon-loop text-lt"></i></a>
                            </div>
                            <div class="hide">
                              <a class="jp-full-screen" title="full screen"><i class="fa fa-expand"></i></a>
                              <a class="jp-restore-screen" title="restore screen"><i class="fa fa-compress text-lt"></i></a>
                            </div>
                          </div>
                        </div>
                      </div>
                      	<div class="jp-playlist dropup" id="playlist">
                        <ul class="dropdown-menu aside-xl dker">
                          <!-- The method Playlist.displayPlaylist() uses this unordered list -->
                          <li class="list-group-item"></li>
                        </ul>
                      </div>
                      <div class="jp-no-solution hide">
                        <span>Update Required</span>
                        To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
                      </div> 
                    </div>
               </div>
          </footer>
        </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>    
  </section>
  <!-- Bootstrap -->
  <script src="resources/js/bootstrap.js"></script>
  <!-- App -->
  <script src="resources/js/app.js"></script>  
  <script src="resources/js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="resources/js/masonry/tiles.min.js"></script>
  <script src="resources/js/masonry/demo.js"></script>
  <script src="resources/js/app.plugin.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/demo.js"></script>
  <script type="text/javascript">
	  $(document).ready(function(){
			$(".linkToPage").on("click",function(){
				var targetPage = $(this).attr("movePage")
				$(location).attr('href',targetPage);
			});
		});
  </script>
</body>
</html>