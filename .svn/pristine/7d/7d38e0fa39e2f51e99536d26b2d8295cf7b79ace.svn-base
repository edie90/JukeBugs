<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="app">
<head>  
  <meta charset="utf-8" />
  <title>Musik | Web Application</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  
  <!-- confirm 모달창 css -->
  <link href="resources/js/alertUI/Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
  <link href="resources/js/alertUI/Styles/jquery-ui.theme.css" rel="stylesheet" type="text/css" />
  <!--  -->
  <link rel="stylesheet" href="resources/js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="resources/css5/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="resources/css5/animate.css" type="text/css" />
  <link rel="stylesheet" href="resources/css5/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="resources/css5/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="resources/css5/font.css" type="text/css" />
  <link rel="stylesheet" href="resources/css5/app.css" type="text/css" />
    
    
  <script src="resources/js/jquery-2.2.2.min.js"></script>
    <!--[if lt IE 9]>
    <script src="js/ie/html5shiv.js"></script>
    <script src="js/ie/respond.min.js"></script>
    <script src="js/ie/excanvas.js"></script>
  <![endif]-->
</head>
<body class="">
  <section class="vbox">
    <header class="bg-black lter header header-md navbar navbar-fixed-top-xs">
      <div class="navbar-header aside bg-success nav-xs">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="icon-list"></i>
        </a>
        <a href="#" class = "navbar-brand text-lt linkToPage" movePage = "main" >
          <i class="icon-earphones"></i>
          <img src="images/logo.png" alt="." class="hide">
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
              <button type="submit" class="btn btn-sm bg-white btn-icon rounded"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border rounded" placeholder="Search songs, albums...">
          </div>
        </div>
      </form>
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
                      <img src="images/a0.png" alt="..." class="img-circle">
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
                <img src="images/a0.png" alt="...">
              </span>
              John.Smith <b class="caret"></b>
            </a>
            <ul class="dropdown-menu animated fadeInRight">            
              <li>
                <span class="arrow top"></span>
                <a href="#">Settings</a>
              </li>
              <li>
                <a href="profile.html">Profile</a>
              </li>
              <li>
                <a href="#">
                  <span class="badge bg-danger pull-right">3</span>
                  Notifications
                </a>
              </li>
              <li>
                <a href="docs.html">Help</a>
              </li>
              <li class="divider"></li>
              <li>
                <a href="modal.lockme.html" data-toggle="ajaxModal" >Logout</a>
              </li>
            </ul>
          </li>
        </ul>
      </div>      
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
                    <c:if test="${not empty loginId }">
                    <li>
                      <a href="#" class = "linkToPage" movePage = "home">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">What's new</span>
                      </a>
                    </li>
                    </c:if>
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
                    <c:if test="${not empty loginId }">
                    <li>
                      <a href="#" class = "linkToPage" movePage = "logInfo" 
                      data-target="#content" data-el="#bjax-el" data-replace="true">
                        <i class="icon-screen-desktop icon"></i>
                        <span class="font-bold">Log</span>
                      </a>
                    </li>
                    </c:if>
                    <li>
                   	 <a href="#" class="auto linkToPage" movePage = "musicRecognition">       
                        <i class="icon-microphone"></i>
                        <span class="font-bold">Music Recognition</span>
                      </a>
                    </li>
                  </ul>
                  <c:if test="${empty loginId }">
                  <ul class="nav" data-ride="collapse">
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-settings">
                        </i>
                        <span>Setting</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li >
                          <a href="#" class="auto linkToPage" movePage = "signin" >                                                        
                            <i class="fa fa-angle-right text-xs"></i>
                            <span>Sign in</span>
                          </a>
                        </li>
                        <li >
                          <a href="#" class="auto linkToPage" movePage = "join">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Sign up</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                  </ul>
                  </c:if>
                </nav>
                <!-- / nav -->
              </div>
            </section>
            
            <c:if test="${ not empty loginId }">    
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
               </c:if>
          </section>
        </aside>
        <!-- /.aside -->
        <section id="content">
          <section class="vbox">
          <section class="w-f-md">
            <section class="hbox stretch bg-black dker">
              <!-- side content -->
              <aside class="col-sm-5 no-padder" id="sidebar">
                <section class="vbox animated fadeInUp">
               		<section class="scrollable" id="listen_PlayList" style="margin-bottom: 35px">
               			<!-- 현재 재생 목록 페이지 -->
               			
               		</section>
                  	<div id="listenMKAlbumAdd" style="position:absolute; bottom:0px; width:100%;height: 35px; 
						vertical-align: middle; background-color: #333"
						align="center" onclick="">
						<a href="#" style="margin: 0">Add Album</a>
					</div>
                </section>
              </aside>
              <!-- / side content -->
              <section class="col-sm-4 bg" style="padding: 2px">
                <section class="vbox">
	                    <header class="panel-heading" style="background-color: #232c32;">
	                    <!-- 3500번줄 bootstrap.css 수정. 관련 border px 0으로 설정. -->
	                      <ul class="nav nav-tabs nav-justified">
	                        <li class="active" style="background-color: #232c32">
	                        <a href="#likeMusic" data-toggle="tab" onclick="listenSelectClick('music')">Like Music</a>
	                        </li>
	                        <li style="background-color: #232c32"> 
	                        	<a href="#makeAlbum" data-toggle="tab" onclick="listenSelectClick('album')">Make Album List</a>
	                        </li>
	                      </ul>
	                    </header>
	                    <!-- 라이크 뮤직(Like Music) 부분 -->
	                  <section class="scrollable hover" style="margin-bottom: 35px">
	                    <div class="panel-body" style="overflow:auto; padding: 0; background-color: #232c32;">
	                      <div class="tab-content" style="border: 0px" >
	                        <div class="tab-pane active" style="border: 0px" id="likeMusic">
	                        <!-- 곡 추가 부분 -->
			                    <ul class="list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" >
			                      
			                      <c:forEach var="likeSong" items="${likeMusicList}">
				                      <li class="list-group-item clearfix" style="border: 0px">
				                        <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">
				                          <%-- <i class="fa fa-plus text" songid="${likeSong.songid}" ></i> --%>
				                          <i class="fa fa-plus text-active likeMusicPlus" id="likeMusicPlus" songid="${likeSong.songid}" ></i>
				                        </a>
				                        <span class="pull-left">
				                        	<input type="checkbox" name="listen_LikeCheckBox_toPlayCheck"
				                        	title ="${likeSong.songtitle}"
			                    			artist="${likeSong.artist}"
			                    			mp3="${likeSong.source}"
			                    			ImgUrl="${likeSong.albumimgurl}"
			                    			songid="${likeSong.songid}"
				                        	>&nbsp;&nbsp;&nbsp;
				                        </span>
				                        <a href="#" class="pull-left thumb-sm m-r">
				                          <img src="${likeSong.albumimgurl}" alt="..."
				                          onerror="this.src='resources/images/defaultAlbumImg.jpg'">
				                        </a>
				                        <a class="clear" href="#">
				                          <span class="block text-ellipsis">${likeSong.songtitle}</span>
				                        </a>
				                        <a class="clear" href="#">
				                          <small>
				                          	<span class="text-ellipsis" >${likeSong.artist}</span>
				                          </small>
				                        </a>
				                      </li>
			                      </c:forEach>
			                      
			                    </ul>
	                        </div>
	                        <div class="tab-pane" id="makeAlbum">
	                        	<div class="panel-group m-b listen_MakeAlbumList_show" id="accordion2">
	                        	<!-- 메이크 앨범 리스트 (make Album List 확인) -->
				                    <c:forEach var="makeAlbum" items="${makeAlbumList}" varStatus="status">
					                    
					                    <div class="panel panel-default" style="background-color: #333; border: 0px">
					                    	<div class="panel panel-default" style="background-color: #333; border: 0px; padding: 0px">
					                    		<div style="float: left; width: 30%" >
					                    			<a class="accordion-toggle getMakeAlbumSongs" mkAlbumId = "${makeAlbum.makealbumid}"
					                    			mkShowCnt = "${status.index}" mkAlbumName = "${makeAlbum.makealbumname}" data-toggle="collapse" data-parent="#accordion2" 
													href="#${status.index}" style="font-size: 20px">
							                    		<img src="${makeAlbum.savedfile}" alt="..." style="width: 100%"
						                         		 onerror="this.src='resources/images/defaultAlbumImg.jpg'" >
					                         		 </a>
					                    		</div>
					                    		<div style="margin: 10px">
					                    			<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" 
													href="#${status.index}" style="font-size: 20px">
												  	<span class="pull-right getMakeAlbumSongs" mkAlbumId = "${makeAlbum.makealbumid}"
					                    			mkShowCnt = "${status.index}" mkAlbumName = "${makeAlbum.makealbumname}">${makeAlbum.makealbumname}<br></span>
												  	</a>
					                    		</div>
					                    	</div>
					                      <div class="panel-heading" style="background-color: #333; border: 0px; padding: 0px">
											<div class="panel-heading" style="background-color: #333; border: 0px;" align="right">
												<a href="#"><i class="fa fa-times removeMKAlbum" mkAlbumId="${makeAlbum.makealbumid}"></i></a>
												&nbsp;&nbsp;
												<a href="#"><i class="fa fa-list-ul listenAddMKALBList" mkAlbumId="${makeAlbum.makealbumid}"></i></a>
												&nbsp;&nbsp;
												<a href="#"><i class="fa fa-play listenPlayMKALBList" mkAlbumId="${makeAlbum.makealbumid}"></i></a>
											</div>
					                      </div>
					                      <div id="${status.index}" class="panel-collapse collapse"
					                      style="background-color: #333; border: 0px">
					                        <div class="panel-body text-sm" style="background-color: #333; border-top: 1px; border-top-color: navy;">
					                          	<!-- 메이크 앨범 추가 부분. -->
					                          	<div class="inner_FD"></div>
					                        </div>
					                      </div>
					                    </div> 
				                    </c:forEach>
		                        </div>
		                  	</div>
                      	</div>
                    </div>
	                    
				    </section>
				    
						<div id="overDiv" style="position:absolute; bottom:0px; width:100%;height: 35px; 
						vertical-align: middle; background-color: #333"
						align="center" onclick="" onmouseover="mouseOverdivColor('over')" onmouseleave="mouseOverdivColor('leave')">
								    		<a>Add Music</a>
						</div>
						
                </section>
              </section>
              <section class="col-sm-3 no-padder lt">
                <section class="vbox">
                <!-- 3번째 섹션 -->
                  <section class="scrollable hover">
                  
                    <div class="m-t-n-xxs">
                      <div class="item pos-rlt">
                      	<div class="carousel slide carousel-fade panel-body" id="c-fade">
	                        <ol class="carousel-indicators out">
	                          <li data-target="#c-fade" data-slide-to="0" class="active"></li>
	                          <li data-target="#c-fade" data-slide-to="1" class=""></li>
	                          <li data-target="#c-fade" data-slide-to="2" class=""></li>
	                        </ol>
	                        <div class="carousel-inner">
	                          <div class="item active" rankType = "date" style="padding: 10px">
	                          	<p class="text-center">
	                              <em class="h4 text-mute">Ranking</em><br>
	                              <small class="text-muted">Today</small>
	                            </p>
	                            <div class="panel-body" style="overflow:auto; padding: 10px; background-color: #434c52;">
	                          		<ul class="list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" >
				                      <c:forEach var="likeSong" items="${dateRank}">
					                      <li class="list-group-item clearfix" style="border: 1px;padding: 10px">
					                        <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md" 
					                        style="margin-right: 10px">
					                          <i class="fa fa-plus text likeMusicPlus" 
					                          id="likeMusicPlus" songid="${likeSong.songid}" ></i>
					                          <i class="fa fa-plus text-active likeMusicPlus" 
					                          id="likeMusicPlus" songid="${likeSong.songid}" ></i>
					                        </a>
					                        <a href="#" class="pull-left thumb-sm m-r">
					                          <img src="${likeSong.albumimgurl}" alt="..."
					                          onerror="this.src='resources/images/defaultAlbumImg.jpg'">
					                        </a>
					                        <a class="clear" href="#">
					                          <span class="block text-ellipsis">${likeSong.songtitle}</span>
					                        </a>
					                        <a class="clear" href="#">
					                          <small>
					                          	<span class="text-ellipsis" >${likeSong.artist}</span>
					                          </small>
					                        </a>
					                      </li>
				                      </c:forEach>
			                    	</ul>
			                      </div>
	                          </div>
	                          
	                          <div class="item" rankType = "month" style="padding: 10px">
	                          	<p class="text-center">
	                              <em class="h4 text-mute">Ranking</em><br>
	                              <small class="text-muted">Now</small>
	                            </p>
	                            <div class="panel-body" style="overflow:auto; padding: 10px; background-color: #434c52;">
	                          		<ul class="list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" >
				                      <c:forEach var="likeSong" items="${realTimeRank}">
					                      <li class="list-group-item clearfix" style="border: 1px;padding: 10px">
					                        <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md" 
					                        style="margin-right: 10px">
					                          <i class="fa fa-plus text likeMusicPlus" 
					                          id="likeMusicPlus" songid="${likeSong.songid}" ></i>
					                          <i class="fa fa-plus text-active likeMusicPlus" 
					                          id="likeMusicPlus" songid="${likeSong.songid}" ></i>
					                        </a>
					                        <a href="#" class="pull-left thumb-sm m-r">
					                          <img src="${likeSong.albumimgurl}" alt="..."
					                          onerror="this.src='resources/images/defaultAlbumImg.jpg'">
					                        </a>
					                        <a class="clear" href="#">
					                          <span class="block text-ellipsis">${likeSong.songtitle}</span>
					                        </a>
					                        <a class="clear" href="#">
					                          <small>
					                          	<span class="text-ellipsis" >${likeSong.artist}</span>
					                          </small>
					                        </a>
					                      </li>
				                      </c:forEach>
			                    	</ul>
			                      </div>
	                          </div>
	                          
	                          <div class="item" rankType = "month" style="padding: 10px">
	                          	<p class="text-center">
	                              <em class="h4 text-mute">Ranking</em><br>
	                              <small class="text-muted">Monthly</small>
	                            </p>
	                            <div class="panel-body" style="overflow:auto; padding: 10px; background-color: #434c52;">
	                          		<ul class="list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" >
				                      <c:forEach var="likeSong" items="${monthRank}">
					                      <li class="list-group-item clearfix" style="border: 1px;padding: 10px">
					                        <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md" 
					                        style="margin-right: 10px">
					                          <i class="fa fa-plus text likeMusicPlus" 
					                          id="likeMusicPlus" songid="${likeSong.songid}" ></i>
					                          <i class="fa fa-plus text-active likeMusicPlus" 
					                          id="likeMusicPlus" songid="${likeSong.songid}" ></i>
					                        </a>
					                        <a href="#" class="pull-left thumb-sm m-r">
					                          <img src="${likeSong.albumimgurl}" alt="..."
					                          onerror="this.src='resources/images/defaultAlbumImg.jpg'">
					                        </a>
					                        <a class="clear" href="#">
					                          <span class="block text-ellipsis">${likeSong.songtitle}</span>
					                        </a>
					                        <a class="clear" href="#">
					                          <small>
					                          	<span class="text-ellipsis" >${likeSong.artist}</span>
					                          </small>
					                        </a>
					                      </li>
				                      </c:forEach>
			                    	</ul>
			                      </div>
	                          </div>
	                        </div>
	                        
	                        
	                        <a class="left carousel-control" href="#c-fade" data-slide="prev">
	                          <i class="fa fa-angle-left"></i>
	                        </a>
	                        <a class="right carousel-control" href="#c-fade" data-slide="next">
	                          <i class="fa fa-angle-right"></i>
	                        </a>
	                    </div>

                      </div>
                    </div>
                    
                  </section>
                </section>
              </section>
            </section>
          </section>
          <footer class="footer bg-success dker">
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
                                <div class="jp-play-bar bg">
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
  <script src="resources/js/app.plugin.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/demo.js"></script>
  <script type="text/javascript" src="resources/js/alertUI/jquery-ui.min.js"></script>
  <script>
  
  function mouseOverdivColor(checkOver) {
		var overDiv = $("div#overDiv");
		if(checkOver=='over'){
			overDiv.css('background-color', '#191f23');
		}else{
			overDiv.css('background-color', '#333');	
		}
	}
	//like Music 또는 Make Album 리스트 선택.
	function listenSelectClick(displayCheck) {
		var overDiv = $("div#overDiv");
		if(displayCheck=='album'){
	  		overDiv.css('display','none');
		}else{
	  		overDiv.css('display','inline');
		}
	}
	
	
  
  function list() {
      $.ajax({
         url : "getMakeAlbums"
         , method : "POST"
         , dataType : "json"
         , contentType: "application/json;charset=utf-8"
         , success : function(obj) {
            if(obj.length != 0) {
            	var str = '';
                $.each(obj, function(index, item) {
                   str += "<div class='playlist-list-item padder-v b-b clearfix'>";
                   str += "<div class='row'>";
                   str += "<div class='col-xs-12 .col-sm-6 .col-md-8' style='width: 78%;'>";
                      str += "<a href='#' id='playlist-title' class='font-bold'>" + item.makealbumname + "</a>";
                      str += "<div id='playlist-count' class='text-muted'>" + item.count + "</div>";
                      str += "</div>";
                      str += "<div class='.col-xs-6 .col-md-4'>";
                      str += '<button id="playlist-add" style="display: inline-block; margin-top: 10px;" '+
                      'onclick="listInsertAlbum('+"'"+item.makealbumname+"'"+')">Add to playlist</button>';
                      str += '<button id="playlist-remove" class="playlist-remove" title="Remove" '+
                      'onclick="removeMKAlbum('+"'"+item.makealbumid+"'"+')"><i class="fa fa-times"'+
                      'style="margin-top: 10px; margin-left: 12px;"></i></button>';
                      //str += '<a href"#"><span onclick="removeMKAlbum('+"'"+item.makealbumid+"'"+')">TTTT</span></a>';
                      str += "</div>";
                      str += "</div>";
                      str += "</div>";
                });
            }
            $('#playlist-list').html(str);
            $('#playlist-new-title').val("");
            addMKAlbumEventAdd();
	      }
	   });
	  }
	function removeMKAlbum(mkalbumId) {
		//alert("test");
	   $.ajax({
	      url : "removeMKAlbum"
	      , method : "post"
	      , data : mkalbumId
	      , contentType: "application/json;charset=utf-8"
	      , success : function() {
	         list();
	      }
	      , error : function(request,status,error){
	           alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	   })
	}
   
   function listInsertAlbum(makealbumname) {
		var data={}; 
		var arr = new Array();
		$.each($(".hv_Songs"),function(index, item){
			var c = $(item).attr('songId');
			arr.push(c);
		})
		if(makealbumname!=null){
			data.makealbumname = makealbumname; 
			data.songids = arr;
			data.cmd = "save";
		}
		var e = JSON.stringify(data);
		
		$.ajax({
	        url : "addMKAlbum"
	        , method : "post"
	        , data : e
	        , contentType: "application/json;charset=utf-8"
	        , success : function() {
	           list();
	           $("#save-text").prop('style', 'display:none');
	        }
	        , error : function(request,status,error){
	             //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
	     })  
	}

$(document).ready(function() {
	$(".linkToPage").on("click",function(){
		var targetPage = $(this).attr("movePage")
		$(location).attr('href',targetPage);
	});
	addMKAlbumEventAdd();
	Event_removeAlbum();
	removeMKAlbum_in_Songs();
	Event_GetMakeAlbumSongsConnect();
});
function showConfirm(msg, titleMsg,mkAlbumId) {
    var $messageBox = $.parseHTML('<div id="confirmDialog"></div>');
    $("body").append($messageBox);
    
    $($messageBox).dialog({
        open: $($messageBox).append(msg),
        title: titleMsg,
        autoOpen: true,
        modal: true,
        buttons: {
            OK: function () {
            	removeMKAlbum(mkAlbumId);
            	$("#confirmDialog").dialog("close");
            	listen_MakeAlbumList_Refresh();
            },
    		Cancel : function () {
    			$("#confirmDialog").dialog("close");
			}
        }
    });
}
	
function Event_removeAlbum() {
	$("i.removeMKAlbum").off("click")
	$("i.removeMKAlbum").on("click",removeMKAlbum_ConfirmCheck);
}


function removeMKAlbum_ConfirmCheck(){
	var mkalbumId = $(this).attr("mkAlbumId");
	//alert(mkalbumId);
	showConfirm("Delete your Album?","Delete Album", mkalbumId);
}



function removeMKAlbum_in_Songs(){
	$("i.delete_MKSongs").off("click");
	$("i.delete_MKSongs").on("click",function(){
		var deleteTarget = $(this).attr("deleteTarget");
		var makeAlbumId = $(this).attr("mkAlbumId");
		var songid = $(this).attr("songid");
		
		var target = $(this).parent().parent();
		target.hide();
		var data = {};
		data.makealbumid = makeAlbumId;
		data.songid = songid;
		var e = JSON.stringify(data);
		
		$.ajax({
	        url : "deleteMKAlbumSongs"
	        , method : "post"
	        , data : e
	        , contentType: "application/json;charset=utf-8"
	        , success : function() {
	        }
	     })   
		
	});
}

function addMKAlbumEventAdd() {
	$('#listenMKAlbumAdd').off('click');
	$('#listenMKAlbumAdd').on('click',function() {
		var arr = new Array();
		
		jQuery.ajaxSettings.traditional = true;
		$("#save-text").prop('style', 'display:block');   
		list();
		$('#myModal').modal();
		$('#saveButton').off('click');
		$('#saveButton').on('click',function() {
			var title = $('#playlist-new-title').val();
			var data={}; 
			var arr = new Array();
			$.each($(".hv_Songs"),function(index, item){
				var c = $(item).attr('songId');
				arr.push(c);
			})
			if(title!=null){
				data.makealbumname = title; 
				data.songids = arr;
				data.cmd="create";
			}
			var e = JSON.stringify(data);

			$.ajax({
				url : "addMKAlbum"
	            , method : "post"
	            , data : e
	            , contentType: "application/json;charset=utf-8"
	            , success : function() {
	               list();
	               listen_MakeAlbumList_Refresh();
	               $("#save-text").prop('style', 'display:none');
	            }
	            , error : function(request,status,error){
	                 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
			})
		})
	});
}

function Event_GetMakeAlbumSongsConnect(){
	$('.getMakeAlbumSongs').off('click');
	$('.getMakeAlbumSongs').on('click',function(){
		var cnt = $(this).attr("mkShowCnt");
		var makeAlbumId = $(this).attr("mkAlbumId");
		var mkAlbumName = $(this).attr("mkAlbumName");
		var makeAlbumHtml = "";
		var innerMKAlbumDiv = $(".inner_FD");
		$.ajax({
			url : "getMakeAlbumSongs",
	        method : "post",
	        data : makeAlbumId,
	        dataType : "json",
	        contentType : "application/json;charset=UTF-8",
	        success : function(res){
	        	var rownum = 0;
	        	 makeAlbumHtml +=
	        		'<ul class="list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" >';
	        		for(var i in res){
	        			var songtitle = res[i].songtitle;
	        			var songid = res[i].songid;
	        			var artist = res[i].artist;
	        			var albumID = res[i].albumID;
	        			var albumImgUrl = res[i].albumimgurl;
	        			rownum +=1;
	        			makeAlbumHtml +=
		                    '<li class="list-group-item " style="border: 0px" id = "mkAlSongList_'+mkAlbumName+rownum+'">'+
		                      '<a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">'+
		                      	'<i class="fa fa-plus text likeMusicPlus" songid="'+songid+'"></i>'+
		                        '<i class="fa fa-plus text-active likeMusicPlus" songid="'+songid+'"></i>'+
		                      '</a>'+ 
		                      '<a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">'+
		                      	'<i class="fa fa-times text delete_MKSongs" '+ 
		                      	'deleteTarget = "mkAlSongList_'+mkAlbumName+rownum+'" mkAlbumId = "'+makeAlbumId+'" songid="'+songid+'"></i>'+
		                        '<i class="fa fa-times text-active delete_MKSongs" '+ 
		                        'deleteTarget = "mkAlSongList_'+mkAlbumName+rownum+'" mkAlbumId = "'+makeAlbumId+'" songid="'+songid+'"></i>'+
		                      '</a>'+
		                      '<a href="#" class="pull-left thumb-sm m-r">'+
		                        '<img src="'+albumImgUrl+'" alt="..." '+
		                        'onerror="this.src='+"'resources/images/defaultAlbumImg.jpg'"+'" '+
		                        '>'+
		                      '</a>'+
		                      '<a class="clear" href="#">'+
		                        '<span class="block text-ellipsis">'+songtitle+'</span>'+
		                        '<small class="text-muted">'+artist+'</small>'+
		                     '</a>'+
		                    '</li>';
	        		}
	        		makeAlbumHtml+='</ul>';
	        		innerMKAlbumDiv.html(makeAlbumHtml);
	        		removeMKAlbum_in_Songs();
	        		setEventAll();
	        
	        } 
		});
	});
}

	function listen_MakeAlbumList_Refresh() {
		var makeAlbumList;
		$.ajax({
			url : "getMakeAlbumList"
            , method : "post"
            , dataType : "json"
            , contentType: "application/json;charset=utf-8"
            , success : function(obj) {
				var targetDiv = $("div.listen_MakeAlbumList_show");
				var html_MakeAlbumList = ""
            	for(t in obj){
            		html_MakeAlbumList += 
            	'<div class="panel panel-default" style="background-color: #333; border: 0px">'+
                	'<div class="panel panel-default getMakeAlbumSongs" mkAlbumId="'+obj[t].makealbumid+'" mkAlbumName = "'+obj[t].makealbumname+'" mkShowCnt = "'+t+'" style="background-color: #333; border: 0px; padding: 0px">'+
                    		'<div style="float: left; width: 30%" >'+
                    			'<a class="accordion-toggle getMakeAlbumSongs" mkAlbumId="'+obj[t].makealbumid+'" mkAlbumName = "'+obj[t].makealbumname+'" mkShowCnt = "'+t+'"  data-toggle="collapse" data-parent="#accordion2"'+ 
								'href="#'+t+'" style="font-size: 20px">'+
                       				'<img src="'+obj[t].savedfile+'" alt="..." style="width: 100%" onerror="this.src='+"'resources/images/defaultAlbumImg.jpg'"+'">'+
                  				'</a>'+
                    		'</div>'+
                    		'<div style="margin: 10px">'+
                    			'<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2"'+ 
								'href="#'+t+'" style="font-size: 20px">'+
							  	'<span class="pull-right getMakeAlbumSongs" mkAlbumId="'+obj[t].makealbumid+'" mkAlbumName = "'+obj[t].makealbumname+'" mkShowCnt = "'+t+'" >'+obj[t].makealbumname+'<br></span>'+
							  	'</a>'+
                    		'</div>'+
                    	'</div>'+
                      '<div class="panel-heading" style="background-color: #333; border: 0px; padding: 0px">'+
						'<div class="panel-heading" style="background-color: #333; border: 0px;" align="right">'+
							'<a href="#"><i class="fa fa-times removeMKAlbum" mkAlbumId="'+obj[t].makealbumid+'"></i></a>'+
							'&nbsp;&nbsp;'+
							'<a href="#"><i class="fa fa-list-ul listenAddMKALBList" mkAlbumId="'+obj[t].makealbumid+'"></i></a>'+
							'&nbsp;&nbsp;'+
							'<a href="#"><i class="fa fa-play listenPlayMKALBList" mkAlbumId="'+obj[t].makealbumid+'"></i></a>'+
						'</div>'+
                      '</div>'+
                      '<div id="'+t+'" class="panel-collapse collapse" style="background-color: #333; border: 0px">'+
                        '<div class="panel-body text-sm" style="background-color: #333; border-top: 1px; border-top-color: navy;">'+
                          	'<div>&nbsp;</div>'+
                          	'<div class="inner_FD">'+
                          	'</div>'+
	                   	'</div>'+
	               	'</div>'+
	           	'</div>'
                            
        		}
            	targetDiv.html(html_MakeAlbumList);
				setEventAll();
				addMKAlbumEventAdd();
				Event_removeAlbum();
				Event_GetMakeAlbumSongsConnect();
            }
		})
	}
  
  </script>
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 style="color:red;"><i class="fa fa-plus"></i> <b style="font-size: 13pt;">Add to List</b></h4>
        </div>
        <div class="modal-body" style="padding-bottom: 6px; padding-left: 30px; padding-right: 30px;">
         <div id="playlist-list" class="m-b">
         </div>
          <form role="form">
          </form>
        </div>
        <div class="modal-body" id="save-text" style="padding-bottom: 20px; padding-top: 10px; display: block; padding-left: 30px; padding-right: 30px;" >
           <div class="form-group">
           <label for="usrname" style="font-size: 15pt; margin-bottom: 2%;"> Create New</label>
           <br />
              <label for="usrname" style="padding-bottom: 7px;"> Playlist title</label>
              <br />
              <input type="text" class="form-control input-sm text-md" id="playlist-new-title">
           </div>
           <button type="button" class="red-button" 
           id="saveButton">Save</button>
        </div>
      </div>
    </div>
  </div> 
  
  
</body>
</html>