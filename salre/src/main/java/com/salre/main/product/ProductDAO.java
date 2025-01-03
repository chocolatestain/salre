package com.salre.main.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository("Product") 
public class ProductDAO implements ProductInterface {
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.salre.main.product.";
	//contract_id로 매물정보 전체 조회
	public ProductDTO selectAllByContractId(int contract_id) {
		return sqlSession.selectOne(namespace + "selectAllByContractId",contract_id);	
	}
	
	
	public List<ProductDTO> selectAllProducts() {
        List<ProductDTO> productlist = sqlSession.selectList(namespace + "selectAllProducts");
        return productlist;
    }
	public int InsertProduct(ProductDTO product) {
		int result = sqlSession.insert(namespace + "insert");
		return result;
	}
	public ProductDTO getProductById(int productId) {
	    return sqlSession.selectOne(namespace + "getProductById", productId);

	}
	public int updateProduct(ProductDTO product) {
		int result = sqlSession.update(namespace + "updateProduct", product);
		return result;
	}
	public int deleteProduct(int productId) {
		int result = sqlSession.delete(namespace + "deleteProduct", productId);
		return result;
	}

    public List<ProductDTO> searchProductsByKeyword(String keyword) {
        log.info("", keyword);  
        return sqlSession.selectList(namespace + "searchProductsByKeyword", keyword);
    }

	public ProductDTO selectByIdService(int product_id) {
		return sqlSession.selectOne(namespace + "selectByIdService", product_id);
		
	}
}
