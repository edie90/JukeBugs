package org.JukeBugs.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.JukeBugs.vo.*;
import org.apache.ibatis.session.RowBounds;

public interface AdminDAO {

	public List<Report> getReportedMusicFeed();

	public List<Report> getReportedMessage();

	public List<Report> getReportedSong();

	public List<Report> getReportedAlbum();

	public List<Report> getReportedArtist();

	public void checkRead(String reportid);

	public void checkEnded(String reportid);

	public void setUpdatedEndedAsFalse(String reportid);

	public Song selectOneReportedSong(String reportid);

	public void updateSong(Song updateSongInfo);

	public ArtistAlbum selectOneReportedAlbum(String reportid);

	public void updateAlbum(ArtistAlbum updateAlbumInfo);

	public Artist selectOneReportedArtist(String reportid);

	public void updateArtist(Artist updateArtistInfo);
	
	
}
