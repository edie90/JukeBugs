package org.JukeBugs.dao;

import java.util.List;
import java.util.Map;

import org.JukeBugs.vo.Log;
import org.JukeBugs.vo.MakeAlbum;
import org.JukeBugs.vo.MakeAlbumSongs;
import org.JukeBugs.vo.RelLogVO;
import org.JukeBugs.vo.Song;

public interface jbMusicDAO {
	
	public List<Song> getLikeMusicList(String userId);
	public List<MakeAlbum> getMakeAlbumList(String userId);
	public List<Song> getMakeAlbumSongs(String makeAlbumID);
	public List<Song> getAlbumSongs(String albumID);
	public List<Song> getRankDaySongInfo();
	public List<Song> getRankMonthSongInfo();
	public List<Song> getRankRealTimeSongInfo(int time);
	public Song getSongSelectOne(String songid);
	public String checkMakeAlbumExits(String makeAlbumID);
	public void updateGenre(String genere);
	public void insertRelLog(RelLogVO relLog);
	public void insertMKAlbumSongs(List<MakeAlbumSongs> list);
	public void insertMKAlbum(MakeAlbum makeAlbum);
	public int deleteMKAlbumSongs(String rqMKAlbumId);
	public int deleteMKAlbum(String rqMKAlbumId);
	public int deleteTargetMKAlbumSongs(Map<String, String> delInfo);
	
	public String checkUserActive(String userId);
	public void insertActiveUser(String userId);
	public void updateActiveUser(String userId);
	public void insertLogListen(Log log);
	
	public String checkAlbumId(String albumid);
	public String checkSongId(String songid);
	public String checkArtistId(String artistid);
}
