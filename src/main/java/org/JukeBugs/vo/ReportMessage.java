package org.JukeBugs.vo;

import java.io.Serializable;

/**
 * 신고 메세지 기록 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class ReportMessage implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	private int reportid;
	
	private String messageid;

	public int getReportid() {
		return reportid;
	}

	public void setReportid(int reportid) {
		this.reportid = reportid;
	}

	public String getMessageid() {
		return messageid;
	}

	public void setMessageid(String messageid) {
		this.messageid = messageid;
	}

	@Override
	public String toString() {
		return "ReportMessage [reportid=" + reportid + ", messageid=" + messageid + "]";
	}
	
}