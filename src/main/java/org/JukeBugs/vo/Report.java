package org.JukeBugs.vo;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * 신고 정보 테이블 모델 클래스.
 * 
 * @author generated by ERMaster
 * @version $Id$
 */
public class Report implements Serializable {

	/** serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** 리포트 아이디. */
	private int reportid;

	/** 리포트 내용. */
	private String reportsubstance;
	
	private String reportdate;
	
	private String reportreaded;
	
	private String reportupdateended;
	
	private String reportedItemId;


	public int getReportid() {
		return reportid;
	}

	public void setReportid(int reportid) {
		this.reportid = reportid;
	}

	public String getReportsubstance() {
		return reportsubstance;
	}

	public void setReportsubstance(String reportsubstance) {
		this.reportsubstance = reportsubstance;
	}

	public String getReportdate() {
		return reportdate;
	}

	public void setReportdate(String reportdate) {
		this.reportdate = reportdate;
	}

	public String getReportreaded() {
		return reportreaded;
	}

	public void setReportreaded(String reportreaded) {
		this.reportreaded = reportreaded;
	}

	public String getReportupdateended() {
		return reportupdateended;
	}

	public void setReportupdateended(String reportupdateended) {
		this.reportupdateended = reportupdateended;
	}

	public String getReportedItemId() {
		return reportedItemId;
	}

	public void setReportedItemId(String reportedItemId) {
		this.reportedItemId = reportedItemId;
	}
	
	

	@Override
	public String toString() {
		return "Report [reportid=" + reportid + ", reportsubstance=" + reportsubstance + ", reportdate=" + reportdate
				+ ", reportreaded=" + reportreaded + ", reportupdateended=" + reportupdateended + ", reportedItemId="
				+ reportedItemId + "]";
	}
	

}