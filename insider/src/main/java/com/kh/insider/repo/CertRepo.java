package com.kh.insider.repo;

import com.kh.insider.dto.CertDto;

public interface CertRepo {
	void insert(CertDto certDto);
	boolean exist(CertDto certDto);
	void delete(CertDto certDto);
	void clean();
}
