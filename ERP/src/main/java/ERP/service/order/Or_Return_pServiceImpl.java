package ERP.service.order;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ERP.dao.order.IOr_Return_pDAO;
import enums.ServiceResult;
import vo.order.Or_Ret_PlistVO;
import vo.order.Or_Return_PVO;

@Service
public class Or_Return_pServiceImpl implements IOr_Retrun_pService {

	@Inject
	IOr_Return_pDAO dao;
	
	@Override
	public ServiceResult insertOrReturn(Or_Return_PVO retVO) {
		//상품반품목록 pk만들기
		if(retVO.getRet_pList() != null) {
			int prodPK = dao.selectOr_Ret_pListPK();
			int prodSize = retVO.getRet_pList().size();
			if(prodSize != 0) {
				for(Or_Ret_PlistVO prod : retVO.getRet_pList()) {
					prod.setRet_list_no(prodPK++);
				}
			}
		}
		System.out.println("\n\n\n"+retVO);
		int result = dao.insertOrReturn(retVO);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

	@Override
	public ServiceResult deleteOrReturn(Or_Return_PVO retVO) {
		int result = dao.deleteOrReturn(retVO);
		if(result>0) return ServiceResult.OK;
		else return ServiceResult.FAIL;
	}

}
