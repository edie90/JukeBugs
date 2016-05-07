package org.JukeBugs.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.JukeBugs.dao.*;
import org.JukeBugs.vo.*;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mpatric.mp3agic.ID3v2;
import com.mpatric.mp3agic.InvalidDataException;
import com.mpatric.mp3agic.Mp3File;
import com.mpatric.mp3agic.UnsupportedTagException;

@Controller
public class AdminController {
	@Autowired 
	SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value="reports", method=RequestMethod.GET)
	public String reports(){			//신고 페이지 띄움. (이거 정리하실때 오빠가 만든 관리자 페이지에서 버튼이든 뭐든 눌러서 호출해주셔야함.)
													//지금은 아무도 호출 안함.
		System.out.println("reports===================");
		return "reports";
	}
	
	
	
	@RequestMapping(value="getReportedMusicFeed", method=RequestMethod.GET)
	public @ResponseBody List<Report> getReportedMusicFeed(){		//신고먹은 뮤직피드 가져오기
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);
		JbuserDAO dao1 = sqlSession.getMapper(JbuserDAO.class);
		List<Report> reportedMusicFeed = dao.getReportedMusicFeed();		//신고먹은 뮤직피드 가져옴
		System.out.println(reportedMusicFeed.toString());
		/*for (int i = 0; i < reportedMusicFeed.size(); i++) {
			Musicfeed mf = new Musicfeed();
			mf = dao1.getMusicFeedById(reportedMusicFeed.get(i).getReportedItemId());
			reportedMusicFeed.get(i).setReportsubstance(mf.getWritemessage());
		}*/
		
		System.out.println("getReportedMusicFeed");
		return reportedMusicFeed;
	}
	
	@RequestMapping(value="getReportedMessage", method=RequestMethod.GET)
	public @ResponseBody List<Report> getReportedMessage(){		//신고 먹은 메세지 가져오기
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);
		JbuserDAO dao1 = sqlSession.getMapper(JbuserDAO.class);
		List<Report> reportedMessage = dao.getReportedMessage();
		/*for (int i = 0; i < reportedMessage.size(); i++) {
			Message m = new Message();
			m = dao1.getMessageById(reportedMessage.get(i).getReportedItemId());
			reportedMessage.get(i).setReportsubstance(m.getMessage());
		}*/
		
		System.out.println("getReportedMessage");
		return reportedMessage;
	}
	
	@RequestMapping(value="getReportedSong", method=RequestMethod.GET)
	public @ResponseBody List<Report> getReportedSong(){		//신고 먹은 곡 가져오기
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);
		List<Report> reportedSong = dao.getReportedSong();
		
		System.out.println("getReportedSong");
		return reportedSong;
	}
	
	@RequestMapping(value="getReportedAlbum", method=RequestMethod.GET)
	public @ResponseBody List<Report> getReportedAlbum(){		//신고 먹은 앨범 가져오기
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);
		List<Report> reportedAlbum = dao.getReportedAlbum();
		
		System.out.println("getReportedAlbum");
		return reportedAlbum;
	}
	
	@RequestMapping(value="getReportedArtist", method=RequestMethod.GET)
	public @ResponseBody List<Report> getReportedArtist(){		//신고 먹은 아티스트 가져오기
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);
		List<Report> reportedArtist = dao.getReportedArtist();
		System.out.println(reportedArtist);
		System.out.println("getReportedArtist");
		return reportedArtist;
	}
	
	@RequestMapping(value="checkRead", method=RequestMethod.POST)
	public @ResponseBody void checkRead(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);					//읽은 순간 이 컨트롤러 호출
		String reportid = map.get("reportid");		
		dao.checkRead(reportid);							//읽었다고 체크하기
		System.out.println("checkRead");
	}
	
	@RequestMapping(value="checkEnded", method=RequestMethod.POST)
	public @ResponseBody void checkEnded(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);				//신고내용을 무시했을때
		String reportid = map.get("reportid");
		dao.checkEnded(reportid);					//신고내용 무시
		System.out.println("checkEnded");
	}
	
	@RequestMapping(value="deleteReported", method=RequestMethod.POST)
	public @ResponseBody void deleteReported(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);			//뮤직피드나 메세지가 부적절해서 삭제처리(이용자가 더이상 못봄)
		String reportid = map.get("reportid");
		dao.setUpdatedEndedAsFalse(reportid);
		System.out.println(reportid);				//부!적!절!
		System.out.println("deleteReported");
	}
	
	@RequestMapping(value="getReportedInfoSong", method=RequestMethod.POST)
	public @ResponseBody Song getReportedInfoSong(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);		//신고된 곡을 수정하겠다고 클릭하면 호출되는 컨트롤러
		String reportid = map.get("reportid");
		Song reportedSong = dao.selectOneReportedSong(reportid);		//신고된 곡의 현재 정보를 가져와서 뿌려줌
		System.out.println("getReportedInfoSong : " + reportedSong);
		return reportedSong;
	}
	
	@RequestMapping(value="updateInfoSong", method=RequestMethod.POST)
	public @ResponseBody void updateInfoSong(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);			//신고된 곡의 정보를 수정하는 컨트롤러(수정하겠다고 눌러서 뜬 모달의 수정버튼을 눌렀을시 호출)
		String songid = map.get("songid");
		String songtitle = map.get("songtitle");
		String releasedate = map.get("releasedate");
		int tracknumber = Integer.parseInt(map.get("tracknumber"));
		String writer = map.get("writer");
		String lyricwriter = map.get("lyricwriter");
		String source = map.get("source");							//입력 받았건, 빈칸 이건, 그대로 이건 다 가져옴
		
		Song updateSongInfo = new Song();
		updateSongInfo.setSongid(songid);
		updateSongInfo.setSongtitle(songtitle);
		updateSongInfo.setReleasedate(releasedate);
		updateSongInfo.setTracknumber(tracknumber);
		updateSongInfo.setWriter(writer);
		updateSongInfo.setLyricwriter(lyricwriter);
		updateSongInfo.setSource(source);					//입력 입력
		
		dao.updateSong(updateSongInfo);			//수정 수정
		System.out.println("updateInfoSong : " + updateSongInfo);
	}
	
	@RequestMapping(value="getReportedInfoAlbum", method=RequestMethod.POST)
	public @ResponseBody ArtistAlbum getReportedInfoAlbum(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);			//신고된 앨범을 수정하겠다고 클릭하면 호출되는 컨트롤러
		String reportid = map.get("reportid");
		ArtistAlbum reportedAlbum = dao.selectOneReportedAlbum(reportid);  //신고된 앨범의 현재 정보를 가져와서 뿌려줌
		System.out.println("getReportedInfoAlbum : " + reportedAlbum);
		return reportedAlbum;
	}
	
	@RequestMapping(value="updateInfoAlbum", method=RequestMethod.POST)
	public @ResponseBody void updateInfoAlbum(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);//신고된 앨범의 정보를 수정하는 컨트롤러(수정하겠다고 눌러서 뜬 모달의 수정버튼을 눌렀을시 호출)
		String albumid = map.get("albumid");
		String albumrelease = map.get("albumrelease");
		String albumtitle = map.get("albumtitle");
		String albumdiscription = map.get("albumdiscription");
		String albumimgurl = map.get("albumimgurl");            //입력 받았건, 빈칸 이건, 그대로 이건 다 가져옴
		
		ArtistAlbum updateAlbumInfo = new ArtistAlbum();
		updateAlbumInfo.setAlbumid(albumid);
		updateAlbumInfo.setAlbumrelease(albumrelease);
		updateAlbumInfo.setAlbumtitle(albumtitle);
		updateAlbumInfo.setAlbumdiscription(albumdiscription);
		updateAlbumInfo.setAlbumimgurl(albumimgurl);     
		
		dao.updateAlbum(updateAlbumInfo); //수정 수정
		System.out.println("updateInfoAlbum : " + updateAlbumInfo);
	}
	
	@RequestMapping(value="getReportedInfoArtist", method=RequestMethod.POST)
	public @ResponseBody Artist getReportedInfoArtist(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);		//이하 아티스트도 똑같음.
		String reportid = map.get("reportid");
		Artist reportedArtist = dao.selectOneReportedArtist(reportid);
		System.out.println("getReportedInfoArtist : " + reportedArtist);
		return reportedArtist;
	}
	
	@RequestMapping(value="updateInfoArtist", method=RequestMethod.POST)
	public @ResponseBody void updateInfoArtist(@RequestBody Map<String, String> map){
		AdminDAO dao = sqlSession.getMapper(AdminDAO.class);			//똑같 똑같
		String artistid = map.get("artistid");
		String artistname = map.get("artistname");
		String artistdebut = map.get("artistdebut");
		String artistactive = map.get("artistactive");
		if (artistactive.equals("yes")) {
			artistactive = "true";
		}else if (artistactive.equals("no")) {
			artistactive = "false";
		}
		String artistimgurl = map.get("artistimgurl");
		String artistposition = map.get("artistposition");
		
		Artist updateArtistInfo = new Artist();
		updateArtistInfo.setArtistid(artistid);
		updateArtistInfo.setArtistname(artistname);
		updateArtistInfo.setArtistdebut(artistdebut);
		updateArtistInfo.setArtistactive(artistactive);
		updateArtistInfo.setArtistimgurl(artistimgurl);
		updateArtistInfo.setArtistposition(artistposition);
		
		dao.updateArtist(updateArtistInfo);
		System.out.println("updateInfoArtist : " + updateArtistInfo);
	}
	
	
	
	///////////       신곡 추가기능         ///////////////////
	
	@RequestMapping(value="newSongAdd", method=RequestMethod.GET)
	public String goProfile () {
		
		return "admin";
	}
	
	
	@RequestMapping(value="uploadmp", method=RequestMethod.POST)
	public @ResponseBody Song upload (MultipartFile file, HttpServletRequest request) throws IOException, UnsupportedTagException, InvalidDataException{
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		System.out.println(file);
		
		String uidValue = null;
		String fpath = null;
		String savedFile = null;
		Song song = new Song();
		String loadpath = "http://203.233.196.55/";
		//포스터 선택 한 경우
				if(!file.isEmpty()) {
					
					String originalFile = file.getOriginalFilename();
					//UUID - 단일의 값을 발생
					UUID uid = UUID.randomUUID();
					savedFile = uid.toString()+"_"+originalFile;
					uidValue = uid.toString();
					logger.info(originalFile);
					logger.info(savedFile);
					
					//업로드의 실제위치를 알려달라
					String path = "C:\\music";
					fpath = path+"\\"+savedFile; // 경로+실제파일이 합쳐진 것
					String lpath = loadpath+savedFile;
					//클라이언트가 올린 땐 input이고 input에서 우리 서버에 저장하려면 output이다
					System.out.println("===> 저장경로" + fpath);
					//fpath = "C:\\music\\"+savedFile;
					FileOutputStream fs = new FileOutputStream(fpath);
					fs.write(file.getBytes());
					song.setSource(lpath);
					fs.close();
					
				}
				
				//DB에 저장함
				
				System.out.println("===> 실제 저장경로와 파일명 :: " + fpath);
				
				//mp3파일 태그 읽어오기
				Mp3File mp3file = new Mp3File(fpath);
				
				if(mp3file.hasId3v2Tag()) {
					ID3v2 id3v2Tag = mp3file.getId3v2Tag();
					song.setArtist(id3v2Tag.getArtist());
					song.setAlbumtitle(id3v2Tag.getAlbum());
					song.setSongtitle(id3v2Tag.getTitle());
					song.setReleasedate(id3v2Tag.getYear());
					song.setWriter(id3v2Tag.getComposer());
					song.setLyricwriter(id3v2Tag.getPublisher());
					
					byte[] imageData = id3v2Tag.getAlbumImage();
					BufferedImage img = null;
					if(imageData!=null)
						img = ImageIO.read(new ByteArrayInputStream(imageData));
					
					if(imageData != null) {
						String mimeType = id3v2Tag.getAlbumImageMimeType();
						System.out.println("===> 마임타입 :: " + mimeType);
						String fileType = null;
						String location = null;
						String totalName = null;
						
						int lastIndexOf = mimeType.lastIndexOf('/');
						
						if(lastIndexOf == -1) {
							fileType = "";
						} else {
							fileType = mimeType.substring(lastIndexOf + 1);
							System.out.println("그림확장자 :: " + fileType);
						}
						
						int fpathLength = fpath.length()-5;
						
						if(fpathLength == 0) {
							location = "";
						} else {
							location = fpath.substring(0, fpathLength + 1);
							System.out.println("저장위치 :: " + location);
						}
						System.out.println("최종 위치 및 확장자 :: " + location + "." + fileType);
						
						File albumCover = new File(location+"."+fileType);
						//totalName = location+"."+fileType;
						
						ImageIO.write(img, fileType, albumCover);
						
						int savedFileLastIndex = savedFile.length()-5;
						if(savedFileLastIndex == 0) {
							totalName = "";
						} else {
							totalName = savedFile.substring(0, savedFileLastIndex + 1);
						}
						System.out.println(totalName + "." + fileType);
						song.setSavedfile(loadpath+totalName + "." + fileType);
						song.setOriginalfile(fpath);
					}
				}
				
				//dao.insert(vo);
		
		return song;
	}
	
	@RequestMapping(value="saveInfo", method=RequestMethod.POST)
	public String saveInfo (HttpServletRequest request, Song so) {
		/*try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println("===> song 객체 :: " + request.getParameter("songtitle"));*/
		System.out.println("===> :: " + so);
		System.out.println("송타이틀 :: " + so.getSongtitle());
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		jbMusicDAO checkDao = sqlSession.getMapper(jbMusicDAO.class);
		String songid = UUID.randomUUID().toString();
		String albumid = UUID.randomUUID().toString();
		String artistid = UUID.randomUUID().toString();
		boolean check = true;
		while(checkDao.checkSongId(songid)!=null){
			songid = UUID.randomUUID().toString();
		}
		while(checkDao.checkAlbumId(albumid)!=null){
			albumid = UUID.randomUUID().toString();
		}
		while(checkDao.checkArtistId(artistid)!=null){
			artistid = UUID.randomUUID().toString();
		}
		
		so.setSongid(songid);
		//so.setSource(so.getOriginalfile());
		so.setAlbumid(albumid);
		
		System.out.println(so);
		
		if(so.getArtistid().length() == 0) {
			so.setArtistid(artistid.toString());
			dao.insertSongInfo(so);
			dao.insertNewArtist(so);	
		}else {
			dao.insertSongInfo(so);
		}
		
		Map<String, String> insertHaveMap = new HashMap<String, String>();
		insertHaveMap.put("artistid", so.getArtistid());
		insertHaveMap.put("songid", so.getSongid());
		insertHaveMap.put("albumid", so.getAlbumid());
				
		dao.insertHaveAlbum(insertHaveMap);
		dao.insertHaveSongs(insertHaveMap);
		System.out.println(songid);
		System.out.println(albumid);
		System.out.println(artistid);
		
		return "adminMain";
	}
	
	@RequestMapping(value="artistNameCheck", method=RequestMethod.GET)
	public @ResponseBody Map<String, Object> artistNameCheck (String artistName) {
		MusicDAO dao = sqlSession.getMapper(MusicDAO.class);
		System.out.println("아티스트이름 :: " + artistName.length());
		String message = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
			Artist artistNameCheck = null;
			artistNameCheck = dao.artistNameCheck(artistName);
			
			if(artistNameCheck == null) {
				map.put("status", "0");
			} else {
				List<Artist> artistNameCheckList = new ArrayList<>();
				artistNameCheckList = dao.artistNameCheckList(artistName);
				System.out.println("아티스트이름 리스트 :: " + artistNameCheckList);
				map.put("artistNameCheckList", artistNameCheckList);
				map.put("status", "1");
			}
		/*map.put("aaa", message);
		obj.status
		
		var t = obj.aaa;*/
		
		return map;
	}
	
}
