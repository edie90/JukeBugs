package org.JukeBugs.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.JukeBugs.dao.jbMusicDAO;
import org.JukeBugs.vo.Log;
import org.JukeBugs.vo.MakeAlbum;
import org.JukeBugs.vo.MakeAlbumSongs;
import org.JukeBugs.vo.RelLogVO;
import org.JukeBugs.vo.Song;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ListenController {
	@Autowired
	SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(ListenController.class);

	@RequestMapping(value = "listen", method = RequestMethod.GET)
	public String listenAction(HttpSession session, Model model) {
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		String userId = (String) session.getAttribute("loginId");
		List<Song>dateRank = new ArrayList<Song>();
		List<Song>monthRank = new ArrayList<Song>();
		List<Song>realTimeRank = new ArrayList<Song>();
		if (userId != null) {
			List<Song> likeMusicList = musicDAO.getLikeMusicList(userId);

			List<MakeAlbum> makeAlbumList = musicDAO.getMakeAlbumList(userId);
			model.addAttribute("likeMusicList", likeMusicList);
			model.addAttribute("makeAlbumList", makeAlbumList);
		}
		int realTimeCheck = 1;
		List<Song> rnkSongInfoList = musicDAO.getRankDaySongInfo();
		List<Song> rnkMonthInfoList = musicDAO.getRankMonthSongInfo();
		List<Song> rnkRealTimeInfoList = musicDAO.getRankRealTimeSongInfo(realTimeCheck);
		boolean realTimeRankCheck = true;
		while(realTimeRankCheck){
			if(rnkRealTimeInfoList.size()>10){
				realTimeRankCheck = false;
			}else{
				realTimeCheck +=1;
				rnkRealTimeInfoList = 
						musicDAO.getRankRealTimeSongInfo(realTimeCheck);
			}
		}
		for(int i = 0; i<10; i++){
			dateRank.add(rnkSongInfoList.get(i));
			monthRank.add(rnkMonthInfoList.get(i));
			realTimeRank.add(rnkRealTimeInfoList.get(i));
		}
		
		model.addAttribute("dateRank",dateRank);
		model.addAttribute("monthRank",monthRank);
		model.addAttribute("realTimeRank",realTimeRank);

		return "listen";
	}

	@RequestMapping(value = "/getMakeAlbumSongs", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Song> getMakeAlbumSongs(@RequestBody String requestMakeAlbumId) {
		ArrayList<Song> result = null;
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		if (requestMakeAlbumId != null) {
			result = (ArrayList<Song>) musicDAO.getMakeAlbumSongs(requestMakeAlbumId);
		}
		return result;
	}

	@RequestMapping(value = "/listenAddLMSelectOne", method = RequestMethod.POST)
	public @ResponseBody Song listenAddLMSelectOne(@RequestBody String songId) {
		Song result = null;
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		if (songId != null) {
			result = musicDAO.getSongSelectOne(songId);
		}
		return result;
	}

	@RequestMapping(value = "/getAlbumSongs", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Song> getAlbumSongs(@RequestBody String requestAlbumId) {
		ArrayList<Song> result = null;
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		if (requestAlbumId != null) {
			result = (ArrayList<Song>) musicDAO.getAlbumSongs(requestAlbumId);
		}
		return result;
	}

	@RequestMapping(value = "/getMakeAlbums", method = RequestMethod.POST)
	public @ResponseBody List<MakeAlbum> getMakeAlbums(HttpSession session) {
		List<MakeAlbum> result = new ArrayList<MakeAlbum>();
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		String userId = session.getAttribute("loginId").toString();
		if (userId != null) {
			result = musicDAO.getMakeAlbumList(userId);
		}
		return result;
	}

	@RequestMapping(value = "/removeMKAlbum", method = RequestMethod.POST)
	public @ResponseBody void removeMKAlbum(@RequestBody String rqMKAlbumId) {
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		int deleteSong = musicDAO.deleteMKAlbumSongs(rqMKAlbumId);
		int deleteAlbum = musicDAO.deleteMKAlbum(rqMKAlbumId);
	}

	@RequestMapping(value = "/addMKAlbum", method = RequestMethod.POST)
	public @ResponseBody void addMKAlbum(@RequestBody Map<String, Object> data, HttpSession session) {
		String cmd = data.get("cmd").toString();
		String userId = session.getAttribute("loginId").toString();
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		String makealbumname  = data.get("makealbumname").toString();
		List<String> songIdList = (List<String>) data.get("songids");
		List<MakeAlbumSongs> masList = new ArrayList<MakeAlbumSongs>();
		String makeAlbumid;
		makeAlbumid = userId+makealbumname;
		
		if(cmd.equals("create")&&
				musicDAO.checkMakeAlbumExits(makeAlbumid)==null){
			MakeAlbum al = new MakeAlbum();
			al.setMakealbumid(makeAlbumid);
			al.setMakealbumname(makealbumname);
			al.setUserid(userId);
			
			musicDAO.insertMKAlbum(al);
		}
		
		if (songIdList.size() == 0)
			return;
		for (String songId : songIdList) {
			MakeAlbumSongs masVo = new MakeAlbumSongs();
			masVo.setMakealbumid(makeAlbumid);
			masVo.setSongid(songId);
			masList.add(masVo);
		}
		musicDAO.insertMKAlbumSongs(masList);
	}
	
	@RequestMapping(value = "/listenEndedSong", method = RequestMethod.POST)
	public @ResponseBody void listenEndedSong(@RequestBody Map<String, Object> data) {
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		RelLogVO relLog = new RelLogVO();
		String endedSongId = data.get("nowPlay").toString();
		String nextSongId = data.get("nextPlay").toString();
		
		relLog.setEndedSongId(endedSongId);
		relLog.setNextSongId(nextSongId);
		musicDAO.insertRelLog(relLog);
	} 
	
	@RequestMapping(value = "/getMakeAlbumList", method = RequestMethod.POST)
	public @ResponseBody List<MakeAlbum> getMakeAlbumList(HttpSession session) {
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		String userId = session.getAttribute("loginId").toString();
		List<MakeAlbum> makeAlbumList = null;
		if (userId != null) {
			makeAlbumList = musicDAO.getMakeAlbumList(userId);
		}
		return makeAlbumList;
	}
	@RequestMapping(value = "/deleteMKAlbumSongs", method = RequestMethod.POST)
	public @ResponseBody void deleteMKAlbumSongs(@RequestBody Map<String, String> data) {
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		int i = musicDAO.deleteTargetMKAlbumSongs(data);
	} 
	
	
	@RequestMapping(value = "/accessauthorityCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> accessauthorityCheck(HttpSession session) {
		Map<String, Object> result = new HashMap<String, Object>();
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		String userId = (String) session.getAttribute("loginId");
		if(userId!=null){
			result.put("loginId", userId);
		}
		else{
			result.put("loginId", "Guest");
		}
		boolean authorityCheck = true;
		if(userId!=null){
			String check = musicDAO.checkUserActive(userId);
			if(check!=null)
				authorityCheck = false;
		}
		result.put("authorityCheck", authorityCheck);
		
		return result;
	}
	
	//결재 명령어
	@RequestMapping(value = "/activePayment", method = RequestMethod.GET)
	public String activePayment(HttpSession session) {
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		String userId = session.getAttribute("loginId").toString();
		if(userId!=null){
			String enddate = musicDAO.checkUserActive(userId);
			if(enddate!=null){
				musicDAO.updateActiveUser(userId);
			}else if(enddate==null){
				musicDAO.insertActiveUser(userId);
			}
		}
		return "listen";
	} 
	
	@RequestMapping(value = "/putLog", method = RequestMethod.POST)
	public @ResponseBody void putLog(HttpSession session, @RequestBody String songid) {
		jbMusicDAO musicDAO = sqlSession.getMapper(jbMusicDAO.class);
		String userId = session.getAttribute("loginId").toString();
		if(userId==null){
			userId = "Guest";
		}
		Log log = new Log();
		log.setUserid(userId);
		log.setSongid(songid);
		musicDAO.insertLogListen(log);
		System.out.println(log);
	} 

}

