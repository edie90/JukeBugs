package org.JukeBugs.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 프리미엄 활성화 유저 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class Activate implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 사용자. */
	private Jbuser jbuser;

	/** 프리미엄 활성화 시작 날짜. */
	private Date activedate;

	/** 활성화 종료 일짜. */
	private Date enddate;

	/**
	 * 생성자.
	 */
	public Activate() {
	}

	/**
	 * 사용자을 설정합니다..
	 * 
	 * @param jbuser
	 *            사용자
	 */
	public void setJbuser(Jbuser jbuser) {
		this.jbuser = jbuser;
	}

	/**
	 * 사용자을 가져옵니다..
	 * 
	 * @return 사용자
	 */
	public Jbuser getJbuser() {
		return this.jbuser;
	}

	/**
	 * 프리미엄 활성화 시작 날짜을 설정합니다..
	 * 
	 * @param activedate
	 *            프리미엄 활성화 시작 날짜
	 */
	public void setActivedate(Date activedate) {
		this.activedate = activedate;
	}

	/**
	 * 프리미엄 활성화 시작 날짜을 가져옵니다..
	 * 
	 * @return 프리미엄 활성화 시작 날짜
	 */
	public Date getActivedate() {
		return this.activedate;
	}

	/**
	 * 활성화 종료 일짜을 설정합니다..
	 * 
	 * @param enddate
	 *            활성화 종료 일짜
	 */
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	/**
	 * 활성화 종료 일짜을 가져옵니다..
	 * 
	 * @return 활성화 종료 일짜
	 */
	public Date getEnddate() {
		return this.enddate;
	}


}
