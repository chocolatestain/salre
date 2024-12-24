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
    public List<ProductDTO> selectAllProducts() {
        // SQL 쿼리 호출
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
        log.info("검색어로 DB에서 검색: {}", keyword);  // 로그로 검색어 확인
        return sqlSession.selectList(namespace + "searchProductsByKeyword", keyword);
    }
}
