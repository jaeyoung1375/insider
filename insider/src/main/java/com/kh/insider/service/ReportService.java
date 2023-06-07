package com.kh.insider.service;

public interface ReportService {
	void manageDeleted(String table, int tableNo);
	void manageDeleted(String table, long tableNo);
}
