<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-js">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>JukeBugs - Music Identification</title>
	<meta name="description" content="Demo for the tutorial on how to create a Shazam-like button effect that morphs into a music player" />
	<meta name="keywords" content="shazam, " />
	<meta name="author" content="Codrops" />
  <style type='text/css'>
    ul { list-style: none; }
    #recordingslist audio { display: block; margin-bottom: 10px; }
  </style>

<link rel="shortcut icon" href="favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="resources/css/icons.css" />
<link rel="stylesheet" type="text/css" href="resources/css/demo.css" />
<link rel="stylesheet" type="text/css" href="resources/css/component.css" />  
<script src="resources/js/modernizr-custom.js"></script>

</head>
<body>

<!--   <h1>Recorder.js simple WAV export example</h1>

  <p>Make sure you are using a recent version of Google Chrome.</p>
  <p>Also before you enable microphone input either plug in headphones or turn the volume down if you want to avoid ear splitting feedback!</p> -->

<!--   <button onclick="startRecording(this);">record</button>
  <button onclick="stopRecording(this);" disabled>stop</button> -->
  
  <!-- 여기서부터 붙이기 시작 -->
  
  <div class="container">
			<header class="codrops-header">
				<div class="codrops-links">
					<a class="codrops-icon codrops-icon--prev" href="javascript:history.back()" title="Return to main page"><span>Go Back</span></a>
					<!-- <a class="codrops-icon codrops-icon--drop" href="http://tympanus.net/codrops/?p=25575" title="Back to the article"><span>Back to the Codrops article</span></a> -->
				</div>
				<h1>Music Recognition<span>Let me hear and tell you what song it is.</span></h1>
			</header>
			<div class="content">
				<p class="mobile-message">Scroll down to the button</p>
				<div class="component" data-path-start="M280,466c0,0.13-0.001,0.26-0.003,0.39c-0.002,0.134-0.004,0.266-0.007,0.396
	C279.572,482.992,266.307,496,250,496h-2.125H51.625H50c-16.316,0-29.592-13.029-29.99-29.249c-0.003-0.13-0.006-0.261-0.007-0.393
	C20.001,466.239,20,466.119,20,466l0,0c0-0.141,0.001-0.281,0.003-0.422C20.228,449.206,33.573,436,50,436h1.625h196.25H250
	c16.438,0,29.787,13.222,29.997,29.608C279.999,465.738,280,465.869,280,466L280,466z" data-path-listen="M181,466c0,0.13-0.001,0.26-0.003,0.39c-0.002,0.134-0.004,0.266-0.007,0.396
	C180.572,482.992,167.307,496,151,496h-2.125h2.75H150c-16.316,0-29.592-13.029-29.99-29.249c-0.003-0.13-0.006-0.261-0.007-0.393
	C120.001,466.239,120,466.119,120,466l0,0c0-0.141,0.001-0.281,0.003-0.422C120.228,449.206,133.573,436,150,436h1.625h-2.75H151
	c16.438,0,29.787,13.222,29.997,29.608C180.999,465.738,181,465.869,181,466L181,466z" data-path-player="M290,40c0,0.13-0.001,380.26-0.003,380.39c-0.002,0.134,0.006,24.479,0.003,24.609 c0,3.095-2.562,5.001-5,5.001h-27.125H41.625H15c-1.875,0-5-1.25-5-5.001c-0.003-0.13,0.004-24.509,0.003-24.641 C10.001,420.239,10,40.119,10,40l0,0c0-0.141-0.002-24.859,0-25c0,0,0-5,5-5h26.625h216.25H285c2.438,0,5,1.906,5,5 C290.002,15.13,290,39.869,290,40L290,40z">
					<!-- SVG with morphing paths and initial start button shape -->
					<svg class="morpher" width="600" height="800">
						<g id="g2" transform="scale(1.4) translate(63,12)">
						<path class="morph__button" d="M280,466c0,0.13-0.001,0.26-0.003,0.39c-0.002,0.134-0.004,0.266-0.007,0.396
	C279.572,482.992,266.307,496,250,496h-2.125H51.625H50c-16.316,0-29.592-13.029-29.99-29.249c-0.003-0.13-0.006-0.261-0.007-0.393
	C20.001,466.239,20,466.119,20,466l0,0c0-0.141,0.001-0.281,0.003-0.422C20.228,449.206,33.573,436,50,436h1.625h196.25H250
	c16.438,0,29.787,13.222,29.997,29.608C279.999,465.738,280,465.869,280,466L280,466z"/>
						</g>
					</svg>
					<!-- Initial start button that switches into the recording button -->
					<button class="button button--start" onclick="startRecording(this);">
						<span class="button__content button__content--start"><font size="5">Listen to this song</font></span>
						<span class="button__content button__content--listen"><span class="icon icon--microphone"></span></span>
					</button>
					<!-- Music player -->
					<div class="player player--hidden">
						<img class="player__cover" src="resources/images/glencheck.jpg" alt="Water 4 The Soul by Gramatik" style="width: 393px; height: 440px;"/>
						<div class="player__meta">
							<h3 class="player__track" id="getTitle"><font size="6">60'S CARDIN</font></h3>
							<h3 class="player__album">
								<span class="player__album-name" id="getAlbumName"><font size="4">HAUTE COUTURE</font></span>
											<br>
											<font size="2"> by</font> 
											<br>
											<span class="player__artist" id="getArtistName"><font size="6">Glen Check</font></span>
							</h3>
							<div class="player__controls">
								<button class="player__control icon icon--skip-back" aria-label="Previous song"></button>
								<button class="player__control player__control--play icon icon--play" aria-label="Play"></button>
								<button class="player__control icon icon--skip-next" aria-label="Next song"></button>
							</div>
						</div>
						<button class="button button--close"><span class="icon icon--cross"></span></button>
					</div><!-- /player -->
				</div><!-- /component -->
			</div><!-- /content -->
		</div><!-- /container -->
  
  <!-- <h2>Recordings</h2> -->
  <ul id="recordingslist"></ul>
  
  <!-- <h2>Log</h2> -->
  <pre id="log"></pre>
  
  <script src="resources/js/classie.js"></script>
  <script src="resources/js/snap.svg-min.js"></script>
  <script src="resources/js/main.js"></script>
  <script src="resources/js/recordmp3.js"></script>
  <script src="resources/js/jquery-2.2.2.min.js"></script>
  <script>
  $(document).ready(function(){
	    //alert("tets")
	});
  
  var requrl;
  
  function __log(e, data) {
    log.innerHTML += "\n" + e + " " + (data || '');
  }

  var audio_context;
  var recorder;

  function startUserMedia(stream) {
    var input = audio_context.createMediaStreamSource(stream);
    //__log('Media stream created.');
    <% System.out.println("3 : Media stream created."); %>

    // Uncomment if you want the audio to feedback directly
    //input.connect(audio_context.destination);
    //__log('Input connected to audio context destination.');
    
    recorder = new Recorder(input);
    //__log('Recorder initialised.');
    <% System.out.println("4 : Recorder initialised."); %>
  }
  
  function startRecording(button) {
	  
    recorder && recorder.record();
    button.disabled = true;
    button.nextElementSibling.disabled = false;
    //__log('Recording...');
    <% System.out.println("Recording"); %>
    //setTimeout(stopRecording(), 1000);
    setTimeout( function stopRecording() {
    	
        recorder && recorder.stop();
        button.disabled = true;
        button.previousElementSibling.disabled = false;
        //__log('Stopped recording.');
        <% System.out.println("Stopped recording."); %>
        // create WAV download link using audio data blob
        createDownloadLink();
        recorder.clear();
      }, 13000);
  }

  function createDownloadLink() {
    recorder && recorder.exportWAV(function(blob) {
      /* var url = URL.createObjectURL(blob);
      var li = document.createElement('li');
      var au = document.createElement('audio');
      var hf = document.createElement('a');
      
      // blob, url
      au.controls = true;
      au.src = url;
      hf.href = url;
      
      hf.download = new Date().toISOString() + '.wav';
      
      hf.innerHTML = hf.download;
      li.appendChild(au);
      li.appendChild(hf);
      recordingslist.appendChild(li);
      
      sendServer(url); */
      
    });
  }

  window.onload = function init() {
    try {
      // webkit shim
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
      window.URL = window.URL || window.webkitURL;
      
      audio_context = new AudioContext;
      //__log('Audio context set up.');
      <% System.out.println("1 : Audio context set up."); %>
      //__log('navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
      <% System.out.println("2 : navigator.getUserMedia available."); %>
    } catch (e) {
      alert('No web audio support in this browser!');
    }
    
    navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
      __log('No live audio input: ' + e);
    });
  };
  
  </script>
</body>
</html>