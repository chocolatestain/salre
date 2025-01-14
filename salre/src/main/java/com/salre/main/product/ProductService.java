package com.salre.main.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service 
public class ProductService { 

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
	public List<ProductDTO> searchByConditions(ProductDTO productDTO) {
		return productDAO.searchByConditions(productDTO);
	}
	
	public int countProduct() {
		return productDAO.countProduct();
	}
	public int nextId() {
		return productDAO.nextId();
	}

	public List<ProductDTO> searchProducts(String searchQuery) {
		return productDAO.searchProductsByKeyword(searchQuery);
	}

	public List<ProductDTO> searchProductsByKeyword(String keyword) {
 
		return productDAO.searchProductsByKeyword(keyword);
	}
	public int incrementViewCount(int product_id) {
		return productDAO.incrementViewCount(product_id);
	}
	
	
	public ProductDTO selectByContractId(int contract_id) {
		return productDAO.selectByContractId(contract_id);
	}

	public List<ProductDTO> findProductsByRegionCode(int regionCode) {
		return productDAO.findProductsByRegionCode(regionCode);
	}
	public int updateProductStatusByContract(int product_id, int product_status) {
		return productDAO.updateProductStatusByContract(product_id, product_status);
	}
}






