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
 pre{
	white-space: pre-wrap;
}
 </style>
 <script>
 	$(function(){
 		$("#checkall").change(function(){
 			$(".checkboxes").prop('checked', $(this).prop("checked"));
 		});
 		viewingInbox(0);
		
 		$("#viewInbox").attr('id', 'viewSent').attr('value', 'Sent messages');
 		
 		$("#deleteMessage").on('click', function(){
 			if ($(".chkclass :checked").size() < 1) {
				alert("삭제할 메세지를 선택해주세요.");
				return;
			}
 			var arrayParam = new Array();
 			$(".chkclass :checked").each(function(){
 				arrayParam.push($(this).val());
 			});
 			var param = {messageids : arrayParam}
 			jQuery.ajaxSettings.traditional = true;
 			$.ajax({
 				  url: "deleteMessages"
 				, method: "POST"
 				, data: param
 				, success: function(){
 					console.log("delete 성공");
 				}
 			});
 			location.reload();
 		});
 		$("body").on('click', "#viewSent", function(){
 			viewingSent();
 			$("h2.m-b-none").text("    Sent messages");
 			$("#viewSent").attr('id', 'viewInbox').attr('value', 'Inbox');
 		});
 		
 		$("body").on('click', "#viewInbox", function(){
 			viewingInbox();
 			$("h2.m-b-none").text("    Inbox");
	 		$("#viewInbox").attr('id', 'viewSent').attr('value', 'Sent messages');
 		});
 		
 		$("#viewCompose").on('click', function(){
			$("#inboxDiv").html(
					'<form class="form-horizontal animated fadeIn" id="composeForm" method="POST" action="composeMessage">'+
										'<div class="form-group">' +
                    '<label class="col-sm-2 control-label">To</label>'+
                    '<div class="col-sm-8">' +
                      '<input type="text" class="form-control" id="sendToId" name="requestId"></div></div>' +
	                  '<div class="line line-dashed b-b line-lg pull-in"></div>' +
					'<div class="form-group">' +
		        '<label class="col-sm-2 control-label">Message</label>' +
		        '<div class="col-sm-8">' +
	          '<div class="btn-toolbar m-b-sm btn-editor" data-role="editor-toolbar" data-target="#editor"></div>' +
	          '<div id="editor" class="form-control" style="overflow:scroll;height:150px;max-height:150px" contenteditable="true">' +
          	'</div><textarea style="display:none" id="divText" name="message"></textarea></div>' +
        /* 	'<div class="line line-dashed b-b line-lg pull-in"></div>' +  */
        	'<div class="col-sm-4 col-sm-offset-2">' +
	          '<button type="button" id="sendCancel" class="btn btn-default">Cancel</button>&nbsp;' +
	          '<button type="button" id="sendSave" class="btn btn-primary">Save changes</button>' +
        	'</div></div></form>');
 		});
 		
 		$("body").on('click', '#sendCancel', function(){
 			viewingInbox();
 		});
 		$("body").on('click', '#sendSave', function(){
			if($("#sendToId").val().trim() == 0){
				alert("수신 아이디를 적어주세요.");
				return false;
			}
 			document.getElementById("divText").value = document.getElementById("editor").innerHTML;
 			var message = document.getElementById("divText").value;
 			if($.trim(message) == ""){
				alert("내용을 적어주세요.");
				return false;
			}
 			var sendTo = {"requestId": $("#sendToId").val()}
 			sendTo = JSON.stringify(sendTo);
 			$.ajax({
 				  url: "checkRequestNick"
 				, method: "POST"
 				, data: sendTo
 				, dataType: "JSON"
 				, contentType: "application/json; charset=UTF-8"
 				, success: function(response){
 					if (! response) {
						alert("없는 사용자 입니다.");
					}else{
			 			$("#composeForm").submit();
					}
 				}
 			});
 		});
 	var messageid;
 		 $("#reportModal").on('show.bs.modal', function(event){
 			  var atag = $(event.relatedTarget);
 			 messageid = atag.data("index");
 		 });
 		 $("#report").on('click', function(){
 			var dat = {"messageid" : messageid}
 			dat = JSON.stringify(dat);
 			$.ajax({
 				 url: "reportMessage" 
 				, method: "POST"
 				, data : dat
 				, contentType: "application/json; charset=UTF-8"
 				, success : function(){
 				}
 			});
 			$("#reportModal").modal("hide");
 		 });
 	});
function viewingInbox(num){
	var currentPage = num;
	$.ajax({
		  url: "getMessages"
		, method: "GET"
		, data: {"currentPage" :currentPage}
		, dataType: "JSON"
		, contentType: "application/json; charset=UTF-8"
		, success: function(obj){
			messageInbox(obj);
		}
	});
}
function viewingSent(num){
	var currentPage = num;
	$.ajax({
		  url: "getSentMessages"
		, method: "GET"
		, data: {"currentPage" : currentPage}
		, dataType: "JSON"
		, contentType: "application/json; charset=UTF-8"
		, success: function(obj){
			messageSent(obj);
		}
	});
}
function messageInbox(obj){
	
	var list = '<div class="chkclass">';
	$(obj.inboxList).each(function(i, item){
		list = list + '<article class="media animated fadeIn">'
					  + '<span class="pull-left"><input type="checkbox" class="checkboxes" value="'+item.messageid+'"></span>'
					  + '<span class="pull-left thumb-sm"><img src="resources/images/a2.png" alt="..."></span>'
					  + '<div class="media-body">'
					  + '<div class="pull-right media-xs text-center text-muted">'
					  + '<strong class="h4">'+item.senddate+'</strong><br></div>'
					  + '<a href="#" class="h4">'+item.sendidjbuser+'</a>'
					  + '<div class="pull-right">'
					  + '<a href="#comment-id" class="btn btn-default btn-xs" check="report"  data-toggle="modal" data-target="#reportModal" data-index="'+item.messageid+'">'
			          + '<i class="icon-flag text-muted"></i> Report</a>&nbsp;&nbsp;&nbsp;'
			          + '</div>'
					  + '<small class="block m-t-sm"><pre>'+item.message+'</pre></small></div></article>'
	});
		  list = list + '<div class="paging-position" style="margin-left: 44%">'
		  list = list + '<ul class="pagination pagination">'
		  list = list + '<li><a href="javascript:viewingInbox('+obj.pagenavi.currentPage+' - 1)"><i class="fa fa-chevron-left"></i></a></li>';
		  for (var i = obj.pagenavi.startPageGroup ; i < obj.pagenavi.endPageGroup+1 ; i++) {
			if (obj.pagenavi.currentPage != i) {
				list = list + '<li><a href="javascript:viewingInbox('+i+')">'+i+'</a></li>'
			}else {
				list = list + '<li class="active"><a href="javascript:viewingInbox('+i+')">'+i+'</a></li>'
			}
		}
		  list = list + '<li><a href="javascript:viewingInbox('+obj.pagenavi.currentPage+' + 1)"><i class="fa fa-chevron-right"></i></a></li>';
		  list = list + '</ul>'
		  list = list + '</div>'
		  list = list + '</div>';
          $("#inboxDiv").html(list);
}
function messageSent(obj){
	var list = '<div class="chkclass">';
	$(obj.sentList).each(function(i, item){
		list = list + '<article class="media animated fadeIn">'
					  + '<span class="pull-left"><input type="checkbox" class="checkboxes" value="'+item.messageid+'"></span>'
					  + '<span class="pull-left thumb-sm"><img src="resources/images/a2.png" alt="..."></span>'
					  + '<div class="media-body">'
					  + '<div class="pull-right media-xs text-center text-muted">'
					  + '<strong class="h4">'+item.senddate+'</strong><br></div>'
					  + '<a href="#" class="h4">'+item.sendidjbuser+'</a>'
					  + '<div class="pull-right">'
				/* 	  + '<a href="#comment-id" class="btn btn-default btn-xs" check="report"  data-toggle="modal" data-target="#reportModal" data-index="'+item.messageid+'">'
			          + '<i class="icon-flag text-muted"></i> Report</a>&nbsp;&nbsp;&nbsp;' */
			          + '</div>'
					  + '<small class="block m-t-sm"><pre>'+item.message+'</pre></small></div></article>'
	});
		  list = list + '<div class="paging-position" style="margin-left: 44%">'
		  list = list + '<ul class="pagination pagination">'
		  list = list + '<li><a href="javascript:viewingSent('+obj.pagenavi.currentPage+' - 1)"><i class="fa fa-chevron-left"></i></a></li>';
		  for (var i = obj.pagenavi.startPageGroup ; i < obj.pagenavi.endPageGroup+1 ; i++) {
			if (obj.pagenavi.currentPage != i) {
				list = list + '<li><a href="javascript:viewingSent('+i+')">'+i+'</a></li>'
			}else {
				list = list + '<li class="active"><a href="javascript:viewingSent('+i+')">'+i+'</a></li>'
			}
		}
		  list = list + '<li><a href="javascript:viewingSent('+obj.pagenavi.currentPage+' + 1)"><i class="fa fa-chevron-right"></i></a></li>';
		  list = list + '</ul>'
		  list = list + '</div>'
		  list = list + '</div>';
          $("#inboxDiv").html(list);
}
 </script>
</head>
<body class="">
  <section class="vbox">
    <header class="bg-white-only header header-md navbar navbar-fixed-top-xs">
      <div class="navbar-header aside bg-info nav-xs">
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
                    <li>
                      <a href="index.html">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">What's new</span>
                      </a>
                    </li>
                    <li>
                      <a href="genres.html">
                        <i class="icon-music-tone-alt icon text-info"></i>
                        <span class="font-bold">Genres</span>
                      </a>
                    </li>
                    <li>
                      <a href="events.html">
                        <i class="icon-drawer icon text-primary-lter"></i>
                        <b class="badge bg-primary pull-right">6</b>
                        <span class="font-bold">Events</span>
                      </a>
                    </li>
                    <li>
                      <a href="listen.html">
                        <i class="icon-list icon  text-info-dker"></i>
                        <span class="font-bold">Listen</span>
                      </a>
                    </li>
                    <li>
                      <a href="video.html" data-target="#content" data-el="#bjax-el" data-replace="true">
                        <i class="icon-social-youtube icon  text-primary"></i>
                        <span class="font-bold">Video</span>
                      </a>
                    </li>
                    <li class="m-b hidden-nav-xs"></li>
                  </ul>
                  <ul class="nav" data-ride="collapse">
                    <li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">
                      Interface
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-screen-desktop icon">
                        </i>
                        <span>Layouts</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li >
                          <a href="layout-color.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Color option</span>
                          </a>
                        </li>
                        <li >
                          <a href="layout-boxed.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Boxed layout</span>
                          </a>
                        </li>
                        <li >
                          <a href="layout-fluid.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Fluid layout</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-chemistry icon">
                        </i>
                        <span>UI Kit</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li >
                          <a href="buttons.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Buttons</span>
                          </a>
                        </li>
                        <li >
                          <a href="icons.html" class="auto">                            
                            <b class="badge bg-info pull-right">369</b>                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Icons</span>
                          </a>
                        </li>
                        <li >
                          <a href="grid.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Grid</span>
                          </a>
                        </li>
                        <li >
                          <a href="widgets.html" class="auto">                            
                            <b class="badge bg-dark pull-right">8</b>                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Widgets</span>
                          </a>
                        </li>
                        <li >
                          <a href="components.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Components</span>
                          </a>
                        </li>
                        <li >
                          <a href="list.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>List group</span>
                          </a>
                        </li>
                        <li >
                          <a href="#table" class="auto">                            
                            <span class="pull-right text-muted">
                              <i class="fa fa-angle-left text"></i>
                              <i class="fa fa-angle-down text-active"></i>
                            </span>                            
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Table</span>
                          </a>
                          <ul class="nav dker">
                            <li >
                              <a href="table-static.html">
                                <i class="fa fa-angle-right"></i>
                                <span>Table static</span>
                              </a>
                            </li>
                            <li >
                              <a href="table-datatable.html">
                                <i class="fa fa-angle-right"></i>
                                <span>Datatable</span>
                              </a>
                            </li>
                          </ul>
                        </li>
                        <li >
                          <a href="#form" class="auto">                            
                            <span class="pull-right text-muted">
                              <i class="fa fa-angle-left text"></i>
                              <i class="fa fa-angle-down text-active"></i>
                            </span>                            
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Form</span>
                          </a>
                          <ul class="nav dker">
                            <li >
                              <a href="form-elements.html">
                                <i class="fa fa-angle-right"></i>
                                <span>Form elements</span>
                              </a>
                            </li>
                            <li >
                              <a href="form-validation.html">
                                <i class="fa fa-angle-right"></i>
                                <span>Form validation</span>
                              </a>
                            </li>
                            <li >
                              <a href="form-wizard.html">
                                <i class="fa fa-angle-right"></i>
                                <span>Form wizard</span>
                              </a>
                            </li>
                          </ul>
                        </li>
                        <li >
                          <a href="chart.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Chart</span>
                          </a>
                        </li>
                        <li >
                          <a href="portlet.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Portlet</span>
                          </a>
                        </li>
                        <li >
                          <a href="timeline.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Timeline</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-grid icon">
                        </i>
                        <span>Pages</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li >
                          <a href="profile.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Profile</span>
                          </a>
                        </li>
                        <li >
                          <a href="blog.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Blog</span>
                          </a>
                        </li>
                        <li >
                          <a href="invoice.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Invoice</span>
                          </a>
                        </li>
                        <li >
                          <a href="gmap.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Google Map</span>
                          </a>
                        </li>
                        <li >
                          <a href="jvectormap.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Vector Map</span>
                          </a>
                        </li>
                        <li >
                          <a href="signin.action" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Signin</span>
                          </a>
                        </li>
                        <li >
                          <a href="signup.action" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>Signup</span>
                          </a>
                        </li>
                        <li >
                          <a href="404.html" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span>404</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                  </ul>
                  <ul class="nav text-sm">
                    <li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">
                      <span class="pull-right"><a href="#"><i class="icon-plus i-lg"></i></a></span>
                      Playlist
                    </li>
                    <li>
                      <a href="#">
                        <i class="icon-music-tone icon"></i>
                        <span>Hip-Pop</span>
                      </a>
                    </li>
                    <li>
                      <a href="#">
                        <i class="icon-playlist icon text-success-lter"></i>
                        <b class="badge bg-success dker pull-right">9</b>
                        <span>Jazz</span>
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
                        <span class="text-muted text-xs block m-l">Art Director</span>
                      </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight aside text-left">                      
                      <li>
                        <span class="arrow bottom hidden-nav-xs"></span>
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
                  </div>
                </div>            </footer>
          </section>
        </aside>
        <!-- /.aside -->
        <section id="content">
              <section class="vbox animated fadeInUp">
              	<section class="scrollable padder">
	              	<div class="m-b-md">
	                	<h2 class="m-b-none">    Messages</h2>
	              	</div>
	              	<div class="row">
	              		<div class="col-lg-12">
	              		<section class="panel panel-default">
                    <header class="panel-heading">
                      	<span><input type="checkbox" id="checkall">&nbsp;&nbsp;&nbsp;
                      				<input type="button" class="btn btn-s-md btn-danger" id="deleteMessage" 
                      						value="Delete selected messages"></span>
                      	<span class="pull-right">
                      				<input type="button" class="btn btn-s-md btn-success" id="viewInbox" value="Inbox">
                      				<input type="button" class="btn btn-s-md btn-info" id="viewCompose" value="Compose message"></span> 
                    </header>
                    <section class="panel-body slim-scroll" data-height="700px" data-size="10px">
	              		<div id="inboxDiv">
		                <!--   <article class="media">
	                      	<span class="pull-left"><input type="checkbox" class="checkboxes"></span>
	                        <span class="pull-left thumb-sm"><img src="resources/images/a2.png" alt="..."></span>
	                        <div class="media-body">
	                          <div class="pull-right media-xs text-center text-muted">
	                            <strong class="h4">12:18</strong><br>
	                            <small class="label bg-light">pm</small>
	                          </div>
	                          <a href="#" class="h4">Bootstrap 3 released</a>
	                          <small class="block"><a href="#" class="">John Smith</a> <span class="label label-success">Circle</span></small>
	                          <small class="block m-t-sm">Sleek, intuitive, and powerful mobile-first front-end framework for faster and easier web development.</small>
	                        </div>
	                      </article> -->
	              	</div><!-- /end div class=col-lg-12 -->
                    </section>
                  </section>
	              		</div>
	              		</div>
              </section>
                
                
              	</section>
                <div class="modal fade" id="reportModal" role="dialog">
    						<div class="modal-dialog">
    
					      Modal content
					      <div class="modal-content">
					        <div class="modal-header">
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					          <h4 class="modal-title">Report this message</h4>
					        </div>
					        
					        <div class="modal-body">
									<div class="form-group">
										<h4 class="modal-title">Do you really want to report this message?</h4>
        							</div>
					        </div>
					        <div class="modal-footer">
	          						<button type="button" id="report" class="btn btn-danger">Report</button>
					        </div>
					      </div>
					      
					    </div>
					  </div>
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
    <script src="resources/js/app.plugin.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="resources/js/jPlayer/demo.js"></script>
</body>
</html>