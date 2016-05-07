package org.JukeBugs.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.web.multipart.MultipartFile;

/**
 * 노래 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class Song implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 노래 아이디. */
	private String songid;

	/** 노래 제목. */
	private String songtitle;

	
	private String albumid;


	/** ReleaseDate. */
	private String releasedate;

	/** 앨범 트랙 넘버. */
	private int tracknumber;

	/** 작곡가. */
	private String writer;

	/** 작사가. */
	private String lyricwriter;

	/** 음원 위치. */
	private String source;
	
	private String artist;
	
	private String albumtitle;
	
	private String artistid;
	
	private int count;
	
	private String albumimgurl;
	
	private MultipartFile file;
	
	private String originalfile; //파일 원래이름
	
	private String savedfile; //겹칠 경우를 대비해서 파일이름
	
	private boolean like;
	
	private int ranking;
	
	private String artistimgurl;
	/**
	 * 노래 아이디을 설정합니다..
	 * 
	 * @param songid
	 *            노래 아이디
	 */
	public void setSongid(String songid) {
		this.songid = songid;
	}

	/**
	 * 노래 아이디을 가져옵니다..
	 * 
	 * @return 노래 아이디
	 */
	public String getSongid() {
		return this.songid;
	}

	/**
	 * 노래 제목을 설정합니다..
	 * 
	 * @param songtitle
	 *            노래 제목
	 */
	public void setSongtitle(String songtitle) {
		this.songtitle = songtitle;
	}

	/**
	 * 노래 제목을 가져옵니다..
	 * 
	 * @return 노래 제목
	 */
	public String getSongtitle() {
		return this.songtitle;
	}



	/**
	 * 앨범 트랙 넘버을 설정합니다..
	 * 
	 * @param tracknumber
	 *            앨범 트랙 넘버
	 */
	public void setTracknumber(Byte tracknumber) {
		this.tracknumber = tracknumber;
	}

	public String getAlbumid() {
		return albumid;
	}

	public void setAlbumid(String albumid) {
		this.albumid = albumid;
	}


	public String getReleasedate() {
		return releasedate;
	}


	public void setReleasedate(String releasedate) {
		this.releasedate = releasedate;
	}



	/**
	 * 작곡가을 가져옵니다..
	 * 
	 * @return 작곡가
	 */
	public String getWriter() {
		return this.writer;
	}

	/**
	 * 작사가을 설정합니다..
	 * 
	 * @param lyricwriter
	 *            작사가
	 */
	public void setLyricwriter(String lyricwriter) {
		this.lyricwriter = lyricwriter;
	}

	/**
	 * 작사가을 가져옵니다..
	 * 
	 * @return 작사가
	 */
	public String getLyricwriter() {
		return this.lyricwriter;
	}

	/**
	 * 음원 위치을 설정합니다..
	 * 
	 * @param source
	 *            음원 위치
	 */
	public void setSource(String source) {
		this.source = source;
	}

	/**
	 * 음원 위치을 가져옵니다..
	 * 
	 * @return 음원 위치
	 */
	public String getSource() {
		return this.source;
	}
	

	public int getTracknumber() {
		return tracknumber;
	}

	public void setTracknumber(int tracknumber) {
		this.tracknumber = tracknumber;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}
	

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}
	

	public String getAlbumtitle() {
		return albumtitle;
	}

	public void setAlbumtitle(String albumtitle) {
		this.albumtitle = albumtitle;
	}
	
	public String getArtistid() {
		return artistid;
	}

	public void setArtistid(String artistid) {
		this.artistid = artistid;
	}
	

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	

	public String getAlbumimgurl() {
		return albumimgurl;
	}

	public void setAlbumimgurl(String albumimgurl) {
		this.albumimgurl = albumimgurl;
	}
	

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getOriginalfile() {
		return originalfile;
	}

	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}

	public String getSavedfile() {
		return savedfile;
	}

	public void setSavedfile(String savedfile) {
		this.savedfile = savedfile;
	}
	
	public boolean isLike() {
		return like;
	}

	public void setLike(boolean like) {
		this.like = like;
	}

	public int getRanking() {
		return ranking;
	}

	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	

	public String getArtistimgurl() {
		return artistimgurl;
	}

	public void setArtistimgurl(String artistimgurl) {
		this.artistimgurl = artistimgurl;
	}
	


	@Override
	public String toString() {
		return "Song [songid=" + songid + ", songtitle=" + songtitle + ", albumid=" + albumid + ", releasedate="
				+ releasedate + ", tracknumber=" + tracknumber + ", writer=" + writer + ", lyricwriter=" + lyricwriter
				+ ", source=" + source + ", artist=" + artist + ", albumtitle=" + albumtitle + ", artistid=" + artistid
				+ ", count=" + count + ", albumimgurl=" + albumimgurl + ", file=" + file + ", originalfile="
				+ originalfile + ", savedfile=" + savedfile + ", like=" + like + ", ranking=" + ranking
				+ ", artistimgurl=" + artistimgurl + "]";
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((songid == null) ? 0 : songid.hashCode());
		return result;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Song other = (Song) obj;
		if (songid == null) {
			if (other.songid != null) {
				return false;
			}
		} else if (!songid.equals(other.songid)) {
			return false;
		}
		return true;
	}

}
