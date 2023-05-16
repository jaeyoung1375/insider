package com.kh.insider.vo;

import lombok.Data;

@Data
public class PaginationVO {
	private String column = "";
	private String keyword = "";
	private int page = 1;
	private int size = 10;	//기본값 설정
	private int count;
	private int blockSize=10;

	//시작행 번호 계산
	public int getBegin() {
		return page*size-size+1;
	}
	//종료행 번호 계산
	public int getEnd() {
		return Math.min(page*size, count);
	}
	public int getTotalPage() {
		return (count+size-1)/size;
	}
	//시작 블록번호 계산
	public int getStartBlock() {
		return (page-1)/blockSize*blockSize+1;
	}
	//종료 블록번호 계산
	public int getFinishBlock() {
		int value = (page-1)/blockSize*blockSize+blockSize;
		return Math.min(getTotalPage(), value);
	}
	//첫 페이지인가?
	public boolean isFirst() {
		return page==1;
	}
	//마지막페이지인가?
	public boolean isLast() {
		return page==getTotalPage();
	}
	//[이전]이 나오는 조건 - 시작블록이 1보다 크면(페이지가 blockSize보다 크면)
	public boolean isPrev() {
		return getStartBlock()>1;
	}
	//[다음]이 나오는 조건 - 종료블록이 마지막페이지보다 작으면
	public boolean isNext() {
		return getFinishBlock()<getTotalPage();
	}
	//[다음]을 누르면 나올 페이지 번호
	public int getNextPage() {
		return getFinishBlock()+1;
	}
	//[이전]을 누르면 나올 페이지 번호
	public int getPrevPage() {
		return getStartBlock()-1;
	}
}