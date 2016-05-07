<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  
 <script src="resources/js/jquery-2.2.2.min.js"></script>
  <style type="text/css">
a.hover:hover{
  color: #2a6496;
  text-decoration: underline;
}
pre{
	white-space: pre-wrap;
}
 </style>
 <script>
 $(function(){
/*	 var userId;
 $("#myModal").on('show.bs.modal', function(event){
		 var atag = $(event.relatedTarget);
		 var userNick = atag.data("nick");
		 var userComp = atag.data("comp");
		 userId = atag.data("id");
		 
		 var modal = $(this);
		 modal.find(".modal-title").text("Your compatibility with " + userNick + " is: " + userComp +"%");
		// modal.find(".smallText").text("Compatibility: " + userComp + "%");
		 modal.find(".bodyContent").text("Do you really want to follow "+ userNick +" ?");
		 modal.find(".col-sm-8 input").val(userNick);
		 modal.find("div.progress.progress-xs.progress-striped.active > div").attr("data-original-title", userComp+"%");
		 modal.find("div.progress.progress-xs.progress-striped.active > div").attr("style", "width:"+userComp+"%");
		 
		 if (userComp > 0 && userComp < 20) {
			modal.find("div.progress.progress-xs.progress-striped.active > div").attr("class", "progress-bar bg-danger");
		}else if (userComp > 20 && userComp < 40) {
			modal.find("div.progress.progress-xs.progress-striped.active > div").attr("class", "progress-bar bg-warning");
		}else if (userComp > 40 && userComp < 60) {
			modal.find("div.progress.progress-xs.progress-striped.active > div").attr("class", "progress-bar bg-success");
		}else if (userComp > 60 && userComp < 80) {
			modal.find("div.progress.progress-xs.progress-striped.active > div").attr("class", "progress-bar bg-info");
		}else if (userComp > 80 && userComp <= 100) {
			modal.find("div.progress.progress-xs.progress-striped.active > div").attr("class", "progress-bar bg-primary");
		}
	 });
		 $("#sendSave").on('click', function(){
			var dat = {"requestToId" : userId}
			dat = JSON.stringify(dat);
			$.ajax({
				 url: "FriendRequest" 
				, method: "POST"
				, data : dat
				, contentType: "application/json; charset=UTF-8"
				, success : function(){
					console.log("friendRequest 성공");
					window.location.reload();
				}
			});
			$("#myModal").modal("hide");
		 }); */
		 
	viewMusicFeed();
		 
	 $("#refresh").on('click', function(){
		 window.location.reload();
	 });
	 $("body").on('click', '#postBtn',function(){
		document.getElementById("divText").value = document.getElementById("editor").innerHTML;
 		var message = document.getElementById("divText").value;
			message = {"message" : message}
			message = JSON.stringify(message);
		$.ajax({
			  url: "postMFMessage"
			, method: "POST"
			, data: message
			, dataType: "JSON"
			, contentType: "application/json; charset=UTF-8"
			, success: function(response){
				window.location.reload();
			}
			, error: function(){
				alert("error");
			}
		})
	 });
	 $("body").on('click', '#cancelBtn', function(){window.location.reload();});
	 
	 $("#musicFeed").on('click', function(){
		 viewMusicFeed();
	 });
	 $("#write").on('click', function(){
		 $("div.col-lg-12").html(
					'<form class="form-horizontal animated fadeIn" id="composeForm" method="POST" action="composeMessage">'+
					'<div class="form-group">' +
		       			 '<label class="col-sm-2 control-label">           </label>' +
		       			 '<div class="col-sm-8">' +
					          '<div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar" data-target="#editor"></div>' +
					          '<div id="editor" class="form-control" style="overflow:scroll;height:150px;max-height:150px" contenteditable="true">' +
       						  '</div><textarea style="display:none" id="divText" name="message"></textarea></div>' +
					     	'<div class="col-sm-4 col-sm-offset-2 pull-right">' +
						          '<button type="button" id="cancelBtn" class="btn btn-default">Cancel</button>&nbsp;' +
						          '<button type="button" id="postBtn" class="btn btn-primary">POST</button>' +
					     	'</div></div></form>');
	 });
	 $("body").on('click', 'a.btn.btn-default.btn-xs',function(){
		 if ($(this).attr("check") == "delete") {
			 var musicfeedid = {"musicfeedid" : $(this).attr("data-index")}
				musicfeedid = JSON.stringify(musicfeedid);
			 $.ajax({
				  url: "deleteMusicFeed"
				, method: "POST"
				, data: musicfeedid
				, dataType: "JSON"
				, contentType: "application/json; charset=UTF-8"
			 	, success: function(){
			 		console.log("delete 성공");
			 	}
			 });
			 location.reload();
		 }
	 });
	 $("body").on('click', 'a.btn.btn-default.btn-xs.pull-right',function(){
			 var musicfeedid = {"musicfeedid" : $(this).attr("data-index")}
				musicfeedid = JSON.stringify(musicfeedid);
			 $.ajax({
				  url: "deleteMusicFeed"
				, method: "POST"
				, data: musicfeedid
				, dataType: "JSON"
				, contentType: "application/json; charset=UTF-8"
			 	, success: function(){
			 		console.log("delete 성공");
			 	}
			 });
			 location.reload();
	 });
var musicfeedid;
	 $("#reportModal").on('show.bs.modal', function(event){
		  var atag = $(event.relatedTarget);
		  musicfeedid = atag.data("index");
	 });
	 $("#report").on('click', function(){
			var dat = {"musicfeedid" : musicfeedid}
			dat = JSON.stringify(dat);
			$.ajax({
				 url: "reportMusicFeed" 
				, method: "POST"
				, data : dat
				, contentType: "application/json; charset=UTF-8"
				, success : function(){
					window.location.reload();
				}
			});
			$("#reportModal").modal("hide");
		 });
 });
function viewMusicFeed(){
	$.ajax({
		  url:"getMusicFeed"
		, method: "GET"
		, dataType: "JSON"
		, contentType: "application/json; charset=UTF-8"
		, success: function(obj){
			console.log(obj);
			getMusicFeed(obj);
		}
	 });
}
function getMusicFeed(obj){
	var userId = $("#userId").val();
	var list = '<section class="comment-list block">'
		$(obj).each(function(i, item){
					if (item.musicfeedtitle == "Message") {
					list = list + '<article id="comment-id" class="comment-item">'
								  + '<a class="pull-left thumb-sm avatar"><img src="resources/images/a9.png" alt="..."></a>'
						    	  + '<span class="arrow left"></span>'
						    	  + '<section class="comment-body panel panel-default">'
						      	  + '<header class="panel-heading">'
						    if (item.writerUser == userId) {
								list = list + 'My '+item.musicfeedtitle+''
											  + '<span class="text-muted m-l-sm pull-right">'
									          + '<i class="fa fa-clock-o"></i>'+item.writedate+'</span></header>'
									          + '<div class="panel-body">'
									          + '<div><pre>'+item.writemessage+'</pre></div>'
									          + '<div class="comment-action m-t-sm">'
									          + '<a class="btn btn-default btn-xs" check="delete" data-index="'+item.musicfeedid+'">'
									          + '<i class="fa fa-trash-o text-muted"></i> Remove</a></div></div></section></article>'
							}else{
								list = list + item.writerUser+'\'s '+item.musicfeedtitle+'' 
									          + '<span class="text-muted m-l-sm pull-right">'
									          + '<i class="fa fa-clock-o"></i>'+item.writedate+'</span></header>'
									          + '<div class="panel-body">'
									          + '<div><pre>'+item.writemessage+'</pre></div>'
									          + '<div class="comment-action m-t-sm pull-right">'
									          + '<a class="btn btn-default btn-xs" check="report"  data-toggle="modal" data-target="#reportModal" data-index="'+item.musicfeedid+'">'
									          + '<i class="icon-flag text-muted"></i> Report</a>'
									          + '</div></div></section></article>'
							}
					}else{
						list = list + '<article id="comment-id" class="comment-item">'
						  + '<a class="pull-left thumb-sm avatar"><img src="resources/images/a9.png" alt="..."></a>'
				    	  + '<span class="arrow left"></span>'
				    	  + '<section class="comment-body panel panel-default">'
				      	  + '<header class="panel-heading">'                      
				          + '<a href="searchAlbumSong?albumid='+item.musicfeedtitle+'" class="hover">'+item.writemessage+'</a>'
				          + '<span class="text-muted m-l-sm pull-right">'
				          + '<i class="fa fa-clock-o"></i>'+item.writedate+'</span>'
						  + '<a class="btn btn-default btn-xs pull-right" data-index="'+item.musicfeedid+'">'
				          + '<i class="fa fa-trash-o text-muted"></i></a></header></section></article>'
					}
		});
			list = list + '</section>'
			$("div.col-lg-12").html(list);
}
 </script>
</head>
<body class="">
<input type="hidden" id="userId" value="${userId}">
  <section class="vbox">
    <header class="bg-white-only header header-md navbar navbar-fixed-top-xs">
      <div class="navbar-header aside bg-info dk">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="icon-list"></i>
        </a>
        <a href="index.html" class="navbar-brand text-lt">
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
              <button type="submit" class="btn btn-sm bg-white btn-icon rounded"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border rounded" placeholder="Search songs, albums...">
          </div>
        </div>
      </form>
      <div class="navbar-right ">
        <ul class="nav navbar-nav m-n hidden-xs nav-user user">
          <!-- <li class="hidden-xs">
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
          </li> -->
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
    </header>
    <section>
      <section class="hbox stretch">
        <!-- .aside -->
        <aside class="bg-black dk aside hidden-print" id="nav">          
          <section class="vbox">
            <section class="w-f-md scrollable">
              <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                


                <!-- nav -->                 
                <nav class="nav-primary hidden-xs">
                  <ul class="nav bg clearfix">
                    <li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">
                      Discover
                    </li>
                    <li>
                      <a href="home">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">What's new</span>
                      </a>
                    </li>
                    <li>
                      <a href="All">
                        <i class="icon-music-tone-alt icon text-info"></i>
                        <span class="font-bold">Genres</span>
                      </a>
                    </li>
                    <li>
                      <a href="listen">
                        <i class="icon-list icon  text-info-dker"></i>
                        <span class="font-bold">Listen</span>
                      </a>
                    </li>
                    <li>
                      <a href="logInfo">
                        <i class="icon-screen-desktop icon"></i>
                        <span class="font-bold">Log</span>
                      </a>
                    </li>
                    <li>
                      <a href="musicRecognition">
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
            <section class="scrollable">
              <section class="hbox stretch">
                <aside class="aside-lg bg-light lter b-r">
                  <section class="vbox">
                    <section class="scrollable">
                      <div class="wrapper">
                        <div class="text-center m-b m-t">
                          <a href="#" class="thumb-lg">
                            <img src="resources/images/a0.png" class="img-circle">
                          </a>
                          <div>
                            <div class="h3 m-t-xs m-b-xs">${userNick}</div>
                            <small class="text-muted"><!-- <i class="fa fa-map-marker"></i>-->${userId}</small>
                          </div>                
                        </div>
                        <div class="list-group no-radius alt">
                          <a class="list-group-item" href="message">
                            <span class="badge bg-success animated fadeIn">${messageCount}</span>
                            <i class="fa fa-comment icon-muted"></i> 
                            Messages
                          </a>
                          <a class="list-group-item" href="likes">
                            <span class="badge bg-primary animated fadeIn">${userLikesCount}</span>
                            <i class="icon-music-tone icon-muted"></i> 
                            Likes
                          </a>
                        </div>
                        <div class="panel wrapper">
                          <div class="row text-center">
                            <div class="col-xs-6">
                              <a href="followers">
                                <span class="m-b-xs h4 block animated fadeIn">${followerCount}</span>
                                <small class="text-muted">Followers</small>
                              </a>
                            </div>
                            <div class="col-xs-6">
                              <a href="followers">
                                <span class="m-b-xs h4 block animated fadeIn">${followingCount}</span>
                                <small class="text-muted">Following</small>
                              </a>
                            </div>
                          </div>
                        </div>
                        <div class="btn-group btn-group-justified m-b">
                          <!-- <a class="btn btn-success btn-rounded" data-toggle="button">
                            <span class="text">
                               Follow
                            </span>
                            <span class="text-active">
                              <i class="fa fa-eye"></i> Following
                            </span>
                          </a> -->
                        </div>
                        <div>
                          <small class="text-uc text-xs text-muted"></small>
                          <p></p>
                          <small class="text-uc text-xs text-muted"></small>
                          <p></p>
                          <div class="line"></div>
                          <small class="text-uc text-xs text-muted"></small>
                          <p class="m-t-sm">
                            <!-- <a href="#" class="btn btn-rounded btn-twitter btn-icon"><i class="fa fa-twitter"></i></a>
                            <a href="#" class="btn btn-rounded btn-facebook btn-icon"><i class="fa fa-facebook"></i></a>
                            <a href="#" class="btn btn-rounded btn-gplus btn-icon"><i class="fa fa-google-plus"></i></a> -->
                          </p>
                        </div>
                      </div>
                    </section>
                  </section>
                </aside>
                <aside class="bg-white">
                  <section class="vbox">
                    <header class="header bg-light lt">
                      <ul class="nav nav-tabs nav-white">
                        <li class="active"><a id="musicFeed" data-toggle="tab" style="cursor: pointer;">MusicFeed</a></li>
                        <li class=""><a id="write" data-toggle="tab" style="cursor: pointer;">Write</a></li>
                      </ul>
                    </header>
                    <section class="scrollable">
   				  <div class="col-lg-12">
   				  		
   				  
		            </div>
                    </section>
                  </section>
                </aside>
                <aside class="col-lg-3 b-l">
                <section class="vbox animated fadeInRight">
                <section class="w-f-md scrollable hover">
                  <h4 class="font-thin m-l-md m-t">Start Following</h4>
                  <ul class="list-group no-bg no-borders auto m-t-n-xxs">
                 <!-- findFriends --> 
                 <c:forEach items="${findFriends}" var="f">
                    <li class="list-group-item">
                      <span class="pull-left thumb-xs m-t-xs avatar m-l-xs m-r-sm">
                        <img src="resources/images/a1.png" alt="..."> <!--  class="img-circle" -->
                        <i class="on b-light right sm"></i>
                      </span>
                      <div class="clear">
                        <div><a href="profileOthers?otherUserId=${f.recomUserId}">${f.recomUserNick}</a></div>
                        <small class="text-muted">Your compatibility with ${f.recomUserNick} :<!-- ${f.recomUserId} --></small>
                        <div class="progress progress-xs progress-striped active">
                        		<c:if test="${f.compatibility > 0 && f.compatibility < 20}">
                          <div class="progress-bar bg-danger" data-toggle="tooltip" 
                          			data-original-title="${f.compatibility}%" style="width: ${f.compatibility}%"></div>
                        		</c:if>
                        		<c:if test="${f.compatibility > 20 && f.compatibility < 40}">
                          <div class="progress-bar bg-warning" data-toggle="tooltip" 
                          			data-original-title="${f.compatibility}%" style="width: ${f.compatibility}%"></div>
                        		</c:if>
                     			<c:if test="${f.compatibility > 40 && f.compatibility < 60}">
                          <div class="progress-bar bg-success" data-toggle="tooltip" 
                          			data-original-title="${f.compatibility}%" style="width: ${f.compatibility}%"></div>
                        		</c:if>
                        		<c:if test="${f.compatibility > 60 && f.compatibility < 80}">
                          <div class="progress-bar bg-info" data-toggle="tooltip" 
                          			data-original-title="${f.compatibility}%" style="width: ${f.compatibility}%"></div>
                        		</c:if>
                        		<c:if test="${f.compatibility > 80 && f.compatibility <= 100}">
                          <div class="progress-bar bg-primary" data-toggle="tooltip" 
                          			data-original-title="${f.compatibility}%" style="width: ${f.compatibility}%"></div>
                        		</c:if>
                        </div>
                      </div>
                    </li>
                 </c:forEach>
                  </ul>
                </section>
                <footer class="footer footer-md bg-black" style="margin-bottom: 21%;">
                    <div class="form-group clearfix m-b-none">
                      <div class="input-group m-t m-b">
						<span class="pull-right">
							<input type="button" class="btn btn-s-md btn-info" id="refresh" value="Refresh list">
						</span>
                      </div>
                    </div>
                </footer>
              </section>              
                  <!-- <section class="vbox">
                    <section class="scrollable padder-v">
                      <div class="panel">
                        <h4 class="font-thin padder">Latest Tweets</h4>
                        <ul class="list-group">
                          <li class="list-group-item">                     
                              <p><a href="#" class="text-info">@Josh Long</a> Vestibulum ullamcorper sodales nisi nec adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis</p>
                              <small class="block text-muted"><i class="fa fa-clock-o"></i> 2 hours ago</small>
                          </li>
                        </ul>
                      </div>
                      <div class="panel clearfix">
                        <div class="panel-body">
                          <a href="#" class="thumb pull-left m-r">
                            <img src="images/a0.png" class="img-circle">
                          </a>
                          <div class="clear">
                            <a href="#" class="text-info">@Mike Mcalidek <i class="fa fa-twitter"></i></a>
                            <small class="block text-muted">2,415 followers / 225 tweets</small>
                            <a href="#" class="btn btn-xs btn-success m-t-xs">Follow</a>
                          </div>
                        </div>
                      </div>
                    </section>
                  </section> -->              
                </aside>
                
              </section>
            </section>
            		
                 <div class="modal fade" id="reportModal" role="dialog">
    						<div class="modal-dialog">
    
					      <div class="modal-content">
					        <div class="modal-header">
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					          <h4 class="modal-title">Report this feed</h4>
					        </div>
					        
					        <div class="modal-body">
									<div class="form-group">
										<h4 class="modal-title">Do you really want to report this feed?</h4>
        							</div>
					        </div>
					        <div class="modal-footer">
	          						<button type="button" id="report" class="btn btn-danger">Report</button>
					        </div>
					      </div>
					      
					    </div>
					  </div>
					  
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
  <script src="resources/js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="resources/js/bootstrap.js"></script>
  <!-- App -->
  <script src="resources/js/app.js"></script>  
  <script src="resources/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="resources/js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
  <script src="resources/js/app.plugin.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/demo.js"></script>
</body>
</html>