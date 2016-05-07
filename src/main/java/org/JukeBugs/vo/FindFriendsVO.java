package org.JukeBugs.vo;

public class FindFriendsVO implements Comparable<FindFriendsVO>{
	
	private String recomUserId;
	private String recomUserNick;
	private int compatibility;
	private int cnt;
	
	public FindFriendsVO() {
	}

	public String getRecomUserId() {
		return recomUserId;
	}

	public void setRecomUserId(String recomUserId) {
		this.recomUserId = recomUserId;
	}

	public String getRecomUserNick() {
		return recomUserNick;
	}

	public void setRecomUserNick(String recomUserNick) {
		this.recomUserNick = recomUserNick;
	}

	public int getCompatibility() {
		return compatibility;
	}

	public void setCompatibility(int compatibility) {
		this.compatibility = compatibility;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	@Override
	public String toString() {
		return "FindFriendsVO [recomUserId=" + recomUserId + ", recomUserNick=" + recomUserNick + ", compatibility="
				+ compatibility + ", cnt=" + cnt + "]";
	}
	
	@Override
	public int compareTo(FindFriendsVO o) {
		if (this.compatibility > o.compatibility) return 1;
		else if (this.compatibility == o.compatibility) return 0;
		else return -1;
	}

}
