package kh.member.controller;

import java.util.ArrayList;

import kh.member.model.dao.MemberDao;
import kh.member.model.vo.Member;
import kh.member.view.MemberView;

public class MemberController {
	MemberView view;
	MemberDao dao;
	public MemberController() {
		super();
		view = new MemberView();
		dao = new MemberDao();
	}
	public void main() {
		while(true) {
			int sel = view.showMenu();
			switch(sel) {
			case 0:
				return;
			case 1:
				printAllMember();
				break;
			case 2:
				printMemberId();
				break;
			case 3:
				printMemberName();
				break;
			case 4:
				insetMember();
				break;
			case 5:
				updateMember();
				break;
			case 6:
				deleteMember();
				break;			
			}
		}
	}
	public void updateMember() {
		view.printMrg("----- 회원 수정 -----");
		String memberId = view.getId();
		Member member = dao.selectOneMember(memberId);
		if(member == null) {
			view.printMrg("회원정보 찾을 수 없습니다.");
		}else {
			Member m = view.getMembers(memberId);
			int result = dao.updateMember(memberId,m);
			if(result >0) {
				view.printMrg("수정성공");
			}else {
				view.printMrg("실패");
			}
		}
	}
	public void deleteMember() {
		view.printMrg("----- 화원 탈퇴 -----");
		String memberId = view.getId();
		int result = dao.deleteMember(memberId);
		if(result >0) {
			view.printMrg("삭제성공");
		}else {
			view.printMrg("회원정보를 찾을 수 없습니다.");
		}
	}
	public void insetMember() {
		view.printMrg("----- 회원 가입 -----");
		String memberId = null;
		while(true) {
			memberId = view.getId();
			Member member = dao.selectOneMember(memberId);
			if(member == null) {
				break;
			}else {
				view.printMrg("중복된 아이디입니다. 다시 입력해주세요.");
			}
		}
		Member m = view.getMember(memberId); 
		int result = dao.insertMember(m);
		if(result >0) {
			view.printMrg("가입성공");
		}else {
			view.printMrg("실패");
		}
	}
	public void printMemberName() {
		String memberName = view.getName();
		ArrayList<Member> list = dao.selectMemberName(memberName);
		if(list.isEmpty()) {
			//조회실패
			view.printMrg("검색결과 없음!");
		}else {
			//조회성공
			view.printAllMember(list);
		}
	}
	public void printMemberId() {
		String memberId = view.getId();
		Member m = dao.selectOneMember(memberId);
		if(m==null) {
			//조회실패
			view.printMrg("조회 실패!");
		}else {
			//조회성공
			view.printOneMember(m);
		}
	}
	public void printAllMember() {
		//dao를 통해서 DB에서 전체회원정보를 ArrayList로 받음
		ArrayList<Member> list = dao.seletAllMember();
		if(list.size()==0) {
			//회원이 한명도 없는경우
		}else {
			view.printAllMember(list);
		}
	}
}
