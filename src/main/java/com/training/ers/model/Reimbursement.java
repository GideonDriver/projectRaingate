package com.training.ers.model;

import java.util.Objects;

public class Reimbursement {
	private int reimbursementId;
	private int requesterId;
	private String reason;
	private double amount;
	private String formattedAmount;
	private String note;
	private String status;
	private String dateTime;

	public Reimbursement() {
		// TODO Auto-generated constructor stub
	}

	public Reimbursement(int reimbursementId, int requesterId, String reason, double amount, String formattedAmount,
			String note, String status, String dateTime) {
		super();
		this.reimbursementId = reimbursementId;
		this.requesterId = requesterId;
		this.reason = reason;
		this.amount = amount;
		this.formattedAmount = formattedAmount;
		this.note = note;
		this.status = status;
		this.dateTime = dateTime;
	}

	public int getReimbursementId() {
		return reimbursementId;
	}

	public void setReimbursementId(int reimbursementId) {
		this.reimbursementId = reimbursementId;
	}

	public int getRequesterId() {
		return requesterId;
	}

	public void setRequesterId(int requesterId) {
		this.requesterId = requesterId;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getFormattedAmount() {
		return formattedAmount;
	}

	public void setFormattedAmount(String formattedAmount) {
		this.formattedAmount = formattedAmount;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	@Override
	public int hashCode() {
		return Objects.hash(amount, dateTime, formattedAmount, note, reason, reimbursementId, requesterId, status);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Reimbursement other = (Reimbursement) obj;
		return Double.doubleToLongBits(amount) == Double.doubleToLongBits(other.amount)
				&& Objects.equals(dateTime, other.dateTime) && Objects.equals(formattedAmount, other.formattedAmount)
				&& Objects.equals(note, other.note) && Objects.equals(reason, other.reason)
				&& reimbursementId == other.reimbursementId && requesterId == other.requesterId
				&& Objects.equals(status, other.status);
	}

	@Override
	public String toString() {
		return "Reimbursement [reimbursementId=" + reimbursementId + ", requesterId=" + requesterId + ", reason="
				+ reason + ", amount=" + amount + ", formattedAmount=" + formattedAmount + ", note=" + note
				+ ", status=" + status + ", dateTime=" + dateTime + "]";
	}

	
	
}
