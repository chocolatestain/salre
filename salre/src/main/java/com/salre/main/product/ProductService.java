package com.salre.main.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service 
public class ProductService {
    
	//@Autowired : type�� ������ �ڵ����� Injection�Ѵ�.
	//����Ÿ���� ������������ ���� 
	//@Qualifier : �̸����� Injection�Ѵ�.
	@Autowired  
	@Qualifier("Product")
	ProductInterface productDAO ;

	// 1.모두조회
	public List<ProductDTO> selectAllProducts() {
		return productDAO.selectAllProducts();
	}

	// 2.?��?��보기
	public ProductDTO selectByIdService(int productId) {
		return productDAO.getProductById(productId);
	}

	// 3.?��?��
	public int insertProduct(ProductDTO product) {
		
		return productDAO.InsertProduct(product);
	}

	// 4.?��?��
	public int updateProduct(ProductDTO product) {
		return productDAO.updateProduct(product);
	}
	
	// 5.?��?��
	public int deleteProduct(int productid) {
		return productDAO.deleteProduct(productid);
	}
    public List<ProductDTO> searchProducts(String keyword) {
        return productDAO.searchProductsByKeyword(keyword);
    }
}






