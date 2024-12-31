package com.salre.main.product;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductRepository {
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.salre.main.product";
	
	public List<ProductDTO> selectAllProducts() {
		return sqlSession.selectList(namespace + "selectAllProducts");
	}
	public ProductDTO getProductById(int product_id) {		
	
		return sqlSession.selectOne(namespace + "getProductById", product_id);
	}
	public int InsertProduct(ProductDTO building){
		return sqlSession.insert(namespace + "InsertProduct", building);
	}
	public int updateProduct(ProductDTO building) {
		return sqlSession.update(namespace + "updateProduct" , building);
	}
	public int deleteProduct(int product_id) {
		return sqlSession.delete(namespace + "deleteProduct", product_id); 
	}
}
