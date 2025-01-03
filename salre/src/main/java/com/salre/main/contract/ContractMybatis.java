package com.salre.main.contract;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.salre.main.product.ProductContractDTO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository("contractMybatis")
public class ContractMybatis implements ContractDAOInterface{

		@Autowired
		SqlSessionTemplate sqlSession;
		
		
		String namespace = "com.salre.main.contract.";
		public List<ContractDTO> selectAll() {
			List<ContractDTO> contractlist = sqlSession.selectList(namespace+"selectAll");
			log.info("contract조회건수:"+contractlist.size());
			return contractlist;
		}
		public ContractUserDTO selectAllById(int contract_id) {
			ContractUserDTO contractAll = sqlSession.selectOne(namespace+"selectAllById",contract_id);
			return contractAll;
		}
		//contract_id로 매물 조회
		public ProductContractDTO selectContractPById(int contract_id) {
			ProductContractDTO productContract = sqlSession.selectOne(namespace +"selectContractPById",contract_id);
			log.info("productById 1건:" + productContract);
			return productContract;
			
		}
//		//contract_id로 판매자 조회
//		public int selectSellerById(int contract_id) {
//			Integer user_id= sqlSession.selectOne(namespace +"selectSellerById",contract_id);
//			log.info("sellerById 1건:" + user_id);
//			return user_id;
//			
//		}
		public ContractDTO selectById(int contract_id) {
			ContractDTO contract = sqlSession.selectOne(namespace +"selectById",contract_id);
			log.info("contract건:" + contract);
			return contract;

		}

		public int saveContract(ContractDTO contractDTO) {
			int result = sqlSession.insert(namespace + "updateContract",contractDTO);
			log.info("쿼리" + contractDTO);
			log.info("수정건수: " + result);
			return contractDTO.getContract_id();
		}
		public int saveContract2(ProductContractDTO contractDTO) {
			int result = sqlSession.insert(namespace + "insertContract",contractDTO);
			log.info("입력건수: " + result);
			return result;
		}

		public int update(ContractDTO contract) {
			int result = sqlSession.update(namespace + "update",contract);
			log.info("수정건수: " + result);
			return result;
			}

		public int delete(int contract_id) {
			int result = sqlSession.delete(namespace + "delete",contract_id);
			log.info("삭제건수: " + result);
			return result;
		}

		public int deleteArray(Integer[] deptid) {
			return 0;
		}

	}