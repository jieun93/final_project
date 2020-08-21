package ERP.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import vo.emp.EmployeeVO;
import vo.emp.Salary_TransVO;

@Repository
public interface IMyinfomationDAO {

	public EmployeeVO selectMyInfo(EmployeeVO emp_no); // 내 정보 가저오는거 
	public int updateMyInfo(EmployeeVO vo); // 내 정보 수정
	
	public int selectCerNO(); // 자격증 불러오는거??
	
	public int deleteCer(EmployeeVO vo); // 자격증 삭제
	public int insertCer(EmployeeVO vo); // 자격증 등록 
	
	// 급여 내역 가져오기
//	public EmployeeVO selectMySalary(EmployeeVO vo);
	public List<EmployeeVO> selectMyMoney(String emp_no);
	
	// 비밀번호 번경
	public int updateMyPASS(EmployeeVO vo); // 비밀번호 변경 
	
}
