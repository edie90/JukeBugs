package org.JukeBugs.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * 가수 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class Artist implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 가수 아이디(가수명+데뷔날짜). */
	private String artistid;

	/** 이름. */
	private String artistname;

	/** 데뷔날짜. */
	private String artistdebut;

	/** 생일. */
	private String artistbirthday;

	/** 혈액형. */
	private String artistbloodtype;

	/** 활동여부. */
	private String artistactive;

	/** 가수 이미지. */
	private String artistimgurl;

	/** 포지션. */
	private String artistposition;

	
	

	public String getArtistid() {
		return artistid;
	}

	public void setArtistid(String artistid) {
		this.artistid = artistid;
	}

	public String getArtistname() {
		return artistname;
	}

	public void setArtistname(String artistname) {
		this.artistname = artistname;
	}

	public String getArtistdebut() {
		return artistdebut;
	}

	public void setArtistdebut(String artistdebut) {
		this.artistdebut = artistdebut;
	}

	public String getArtistbirthday() {
		return artistbirthday;
	}

	public void setArtistbirthday(String artistbirthday) {
		this.artistbirthday = artistbirthday;
	}

	public String getArtistbloodtype() {
		return artistbloodtype;
	}

	public void setArtistbloodtype(String artistbloodtype) {
		this.artistbloodtype = artistbloodtype;
	}

	public String getArtistactive() {
		return artistactive;
	}

	public void setArtistactive(String artistactive) {
		this.artistactive = artistactive;
	}

	public String getArtistimgurl() {
		return artistimgurl;
	}

	public void setArtistimgurl(String artistimgurl) {
		this.artistimgurl = artistimgurl;
	}

	public String getArtistposition() {
		return artistposition;
	}

	public void setArtistposition(String artistposition) {
		this.artistposition = artistposition;
	}

	

	@Override
	public String toString() {
		return "Artist [artistid=" + artistid + ", artistname=" + artistname + ", artistdebut=" + artistdebut
				+ ", artistbirthday=" + artistbirthday + ", artistbloodtype=" + artistbloodtype + ", artistactive="
				+ artistactive + ", artistimgurl=" + artistimgurl + ", artistposition=" + artistposition + "]";
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((artistid == null) ? 0 : artistid.hashCode());
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
		Artist other = (Artist) obj;
		if (artistid == null) {
			if (other.artistid != null) {
				return false;
			}
		} else if (!artistid.equals(other.artistid)) {
			return false;
		}
		return true;
	}

}
