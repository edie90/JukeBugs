<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="app">
<head>  
  <meta charset="utf-8" />
  <title>Musik | Web Application</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="resources/js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/animate.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/font.css" type="text/css" />
  <link rel="stylesheet" href="resources/css2/app.css" type="text/css" />  
  
  <script src="resources/js/jquery.min.js"></script>
  <script>
  function fileUpload() {
	alert("파일업로드");
		
	var stringData = new FormData($('#goForm')[0]);
    alert(typeof stringData);
    alert("시작");
       
	    $.ajax({
	       url : 'uploadmp',
	       method : 'post',
	       data : stringData,
	       processData : false,
           contentType : false,
	       success : function(obj){
	    	  alert(obj.artist);
	    	  alert(obj.songtitle);
	    	  $('#artistValue').val(obj.artist);
	    	  $('#albumTitleValue').val(obj.albumtitle);
	    	  $('#songTitleValue').val(obj.songtitle);
	    	  $('#releaseValue').val(obj.releasedate);
	    	  $('#writerValue').val(obj.writer);
	    	  $('#lyricWriterValue').val(obj.lyricwriter);
	    	  $('#imgUrl').prop('src',obj.savedfile);
	    	  $('#savedFile').val(obj.savedfile);
              $('#originalFile').val(obj.originalfile);
	          alert("성공");
	          alert($('#savedFile').val(obj.savedfile));
	          alert($('#originalFile').val(obj.originalfile));
	          $('#onInputValue').trigger('click');
	       }
	       , error : function(request,status,error){
        	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    	
		   }
	    })
  }
  var artistlist;
  
  function searchArtist() {
	  alert("aa");
	  var artistName = $('#artistValue').val();
	  alert("이름 :: " + artistName);
	  alert(artistName.length);
	  
	  $.ajax({
		  url : "artistNameCheck"
		  , method : "get"
		  , data : "artistName="+artistName
	  	  , dataType : "json"
		  , contentType: "application/json;charset=utf-8"
		  , success : function(obj) {
			  alert(obj.status);
			  if(obj.status == 0) {
				  //alert("000");
				  var str = '';
				  str += "<a href='#' class='btn btn-s-md btn-success' style='margin-left:20px'>New Artist</a>";
              	$('.doc-buttons').html(str);
			  }else {
				  //alert("111");
				  var list = obj.artistNameCheckList;
				  artistlist = list;
				  alert(JSON.stringify(list));
				  var str = '';
				  str += "<a href='javascript:selectList();' class='btn btn-s-md btn-success' style='margin-left:20px'>Select the Artist</a>";
						  
              	$('.doc-buttons').html(str);
			  }
			
		}
	  	  , error : function(request,status,error){
      			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	  }) 
}
  
  function selectList() {
	alert(JSON.stringify(artistlist));
	var str = '';
	str += "<div class='row'>";
	str += "<div class='col-md-4' style='color:black;'>Artist</div>";
	str += "<div class='col-md-4' style='color:black;'>BirthDay</div>";
	str += "<div class='col-md-4' style='color:black;'>Active</div>";
	str += "</div><hr style='margin-top: 1px;'/>";
	for(var i in artistlist){
		str += "<div class='row'>";
		str += "<a href='#'><div ";
		str += 'onclick="goArtistText('+"'"+artistlist[i].artistname+"'"+','+"'"+artistlist[i].artistid+"'"+')">';
		str += "<div class='col-md-4'>"+artistlist[i].artistname+"</div>";
		str += "<input type='hidden' value='"+artistlist[i].artistid+"' />";
		str += "<div class='col-md-4'>"+artistlist[i].artistbirthday+"</div>";
		str += "<div class='col-md-4'>"+artistlist[i].artistactive+"</div>";
		str += "</div></a>";
		str += "</div>";
	}
	
	$("#myModal").modal('show').css({
	    'margin-top': function () { //vertical centering
	        return ($(this).height() / 4);
	    },
	    
	});
    
	$('#playlist-list').html(str);
	$('#myModal').modal();
	
  }
  
  function goArtistText(artistname, artistid) {
	  alert("이름 :: "+artistname);
	  alert("아이디 :: "+	artistid);
	  $('#artistValue').val(artistname);
	  $('#artistId').val(artistid);
	  $("#myModal").modal("hide");
  }
  
  
  </script>
  <script>
  	$(document).ready(function() {
		$('#goSubmit').on('click',function(){
			alert($('#artistId').val());
			alert($('#artistId').val().length);
			$('#insertSongForm').submit();
		})
		$('#fileUploadButton').on('click',function(){
			$('#file').trigger('click');			
		})
	})
  </script>
  
  
  <!--[if lt IE 9]>
    <script src="js/ie/html5shiv.js"></script>
    <script src="js/ie/respond.min.js"></script>
    <script src="js/ie/excanvas.js"></script>
  <![endif]-->
</head>
<body class="">
  <section class="vbox">
    <header class="bg-white-only header header-md navbar navbar-fixed-top-xs" style="background-color: #797fb4">
      <div class="navbar-header aside bg-info nav-xs" style="background-color: #3e4589">
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
      </div>      
      <ul class="nav navbar-nav hidden-xs">
        <li>
          <a href="#nav,.navbar-header" data-toggle="class:nav-xs,nav-xs" class="text-muted">
            <i class="fa fa-indent text" style="color: #b8bbdb !important"></i>
            <i class="fa fa-dedent text-active" style="color: #b8bbdb !important"></i>
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
                <a href="#">Settings</a>
              </li>
              <li>
                <a href="profile">Profile</a>
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
                    <li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">
                      Discover
                    </li>
                    <c:if test="${not empty loginId }">
                    <li>
                      <a href="home">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">What's new</span>
                      </a>
                    </li>
                    </c:if>
                    <li>
                      <a href="main">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">Main</span>
                      </a>
                    </li>
                    <li>
                      <a href="genres.html">
                        <i class="icon-music-tone-alt icon text-info"></i>
                        <span class="font-bold">Genres</span>
                      </a>
                    </li>
                    <li>
                      <a href="listen.html">
                        <i class="icon-list icon  text-info-dker"></i>
                        <span class="font-bold">Listen</span>
                      </a>
                    </li>
                    <li class="m-b hidden-nav-xs"></li>
                  </ul>
                  <ul class="nav" data-ride="collapse">
                    <li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">
                      Admin
                    </li>
                    <li >
                      <a href="reports" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-drawer icon text-primary-lter">
                        </i>
                        <span>Help</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li >
                          <a href="reports" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Reports</span>
                          </a>
                        </li>
                        <li >
                          <a href="newSongAdd" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>New SongAdd</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                  </ul>
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
            <section class="scrollable">
              <section class="hbox stretch">
                <aside class="aside-lg bg-light lter b-r">
                  <section class="vbox">
                    <section class="scrollable">
                      <div class="wrapper">
                        <div class="text-center m-b m-t">
                          <a href="#" class="thumb-lg">
                            <img src="images/a0.png" class="img-circle">
                          </a>
                          <div>
                            <div class="h3 m-t-xs m-b-xs">${userNick}</div>
                            <small class="text-muted"><i class="fa fa-map-marker"></i> Seoul, KOR</small>
                          </div>                
                        </div>
                        <div class="btn-group btn-group-justified m-b">
                          <a class="btn btn-success btn-rounded" data-toggle="button">
                            <span class="text">
                              <i class="fa fa-eye"></i> Follow
                            </span>
                            <span class="text-active">
                              <i class="fa fa-eye"></i> Following
                            </span>
                          </a>
                          <a class="btn btn-dark btn-rounded">
                            <i class="fa fa-comment-o"></i> Chat
                          </a>
                        </div>
                        <div>
                          <small class="text-uc text-xs text-muted">about me</small>
                          <p>Administrator</p>
                          <small class="text-uc text-xs text-muted">info</small>
                          <p>Music Management and New song Add</p>
                          <div class="line"></div>
                          <small class="text-uc text-xs text-muted">connection</small>
                          <p class="m-t-sm">
                            <a href="#" class="btn btn-rounded btn-twitter btn-icon"><i class="fa fa-twitter"></i></a>
                            <a href="#" class="btn btn-rounded btn-facebook btn-icon"><i class="fa fa-facebook"></i></a>
                            <a href="#" class="btn btn-rounded btn-gplus btn-icon"><i class="fa fa-google-plus"></i></a>
                          </p>
                        </div>
                      </div>
                    </section>
                  </section>
                </aside>
                
                
                <!-- 파일 업로드 -->
                <div>
                <form id="goForm" method="POST" enctype="multipart/form-data">
                <br><br>
                	<a href="#" id="fileUploadButton" class="btn btn-s-md btn-default btn-rounded"
                	style="margin-left: 20px">Upload File</a>
                	<input type="file" name="file" id="file" onchange="javascript:fileUpload()" style="visibility: hidden;">
                </form>
                </div>
                <div class="col-sm-8">
                  <form class="form-horizontal" action="saveInfo" id="insertSongForm" method="POST" data-validate="parsley">
                  <input type="hidden" id="savedFile" name="savedfile">
                  <input type="hidden" id="originalFile" name="originalfile">
                    <section class="panel panel-default">
                      <header class="panel-heading">
                        <strong>Type constraints</strong>
                      </header>
                      <div class="panel-body">
                      	<div class="form-group">
                          <label class="col-sm-3 control-label">AlbumCover</label>
                          <div class="col-sm-9">
                            <img id="imgUrl" src="" style="height: 120px; width: 120px; margin-left: 20px">    
                          </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>                    
                        <div class="form-group">
                          <label class="col-sm-3 control-label">Artist</label>
                          <div class="col-sm-9">
                            <input type="text" class="form-control" id="artistValue" onkeyup="javascript:searchArtist()" name="artist" placeholder="Artist" required="required" style="margin-left: 20px">
                            <input type="hidden" id="artistId" name="artistid">
                            <div class="doc-buttons">
                            	
                            </div>
                            <input type="button" id="onInputValue" onclick="javascript:searchArtist()" style="display: none;margin-left: 20px">    
                          </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                          <label class="col-sm-3 control-label">AlbumTitle</label>
                          <div class="col-sm-9">
                            <input type="text" data-type="url" id="albumTitleValue" name="albumtitle" class="form-control" placeholder="AlbumTitle" required="required" style="margin-left: 20px">
                          </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                          <label class="col-sm-3 control-label">SongTitle</label>
                          <div class="col-sm-9">
                            <input type="text" name="songtitle" id="songTitleValue" placeholder="SongTitle" class="form-control" required="required" style="margin-left: 20px">
                          </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                          <label class="col-sm-3 control-label">Release</label>
                          <div class="col-sm-9">
                            <input type="text" data-type="digits" id="releaseValue" name="releasedate" class="form-control" placeholder="Release" required="required" style="margin-left: 20px">
                          </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                          <label class="col-sm-3 control-label">Writer</label>
                          <div class="col-sm-9">
                            <input type="text" data-type="number" id="writerValue" name="writer" class="form-control" placeholder="Writer" style="margin-left: 20px" >
                          </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                          <label class="col-sm-3 control-label">LyricWriter</label>
                          <div class="col-sm-9">
                            <input type="text" data-type="alphanum" id="lyricWriterValue" name="lyricwriter" class="form-control" placeholder="LyricWriter" style="margin-left: 20px">
                          </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                      </div>
                      <footer class="panel-footer text-right bg-light lter">
                        <button type="button" id="goSubmit" class="btn btn-success btn-s-xs">Submit</button>
                      </footer>
                    </section>
                  </form>
                </div>
                
              </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>    
  </section>
  
  
  
 <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 style="color:red;"><i class="fa fa-plus"></i> <b style="font-size: 13pt;">Show ArtistName</b></h4>
        </div>
        <div class="modal-body" style="padding-bottom: 6px; padding-left: 30px; padding-right: 30px;">
         <div id="playlist-list" class="m-b">
          <!-- <div id="myList" class="playlist-list-item padder-v b-b clearfix" pid="1698">
          
          </div> -->
         </div>
          <form role="form">
            <!-- <div class="form-group"> -->
              <!-- <label for="usrname"><span class="glyphicon glyphicon-user"></span> Username</label>
              <input type="text" class="form-control" id="usrname" placeholder="Enter email"> -->
            <!-- </div> -->
            <!-- <div class="form-group"> -->
             <!--  <label for="psw"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
              <input type="text" class="form-control" id="psw" placeholder="Enter password"> -->
            <!-- </div> -->
            <!-- <div class="checkbox">
              <label><input type="checkbox" value="" checked>Remember me</label>
            </div> -->
            <!-- <button type="submit" class="btn btn-default btn-success btn-block"><span class="glyphicon glyphicon-off"></span> Login</button> -->
          	
          </form>
        </div>
        
        <!-- <div class="modal-footer">
          <button type="submit" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
          <p>Not a member? <a href="#">Sign Up</a></p>
          <p>Forgot <a href="#">Password?</a></p>
        </div> -->
      </div>
    </div>
  </div> 
  
  
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