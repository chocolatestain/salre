package com.salre.main.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service 
public class ProductService {
    
	//@Autowired : typeï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½Úµï¿½ï¿½ï¿½ï¿½ï¿½ Injectionï¿½Ñ´ï¿½.
	//ï¿½ï¿½ï¿½ï¿½Å¸ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ 
	//@Qualifier : ï¿½Ì¸ï¿½ï¿½ï¿½ï¿½ï¿½ Injectionï¿½Ñ´ï¿½.
	@Autowired  
	@Qualifier("Product")
	ProductInterface productDAO ;

	// 1.ëª¨ë‘ì¡°íšŒ
	public List<ProductDTO> selectAllProducts() {
		return productDAO.selectAllProducts();
	}

	// ¸Å¹° Á¤º¸ Á¶È£
	public ProductDTO selectByIdService(int product_id) {
		ProductDTO product = productDAO.getProductById(product_id);
		if (product == null) {
            throw new IllegalArgumentException("Invalid product ID: " + product_id);
        }
		return productDAO.getProductById(product_id);
	}
	public ProductDTO selectByContractId(int contract_id) {
		return productDAO.selectAllByContractId(contract_id);
	}
	

	// 3.?ï¿½ï¿½?ï¿½ï¿½
	public int insertProduct(ProductDTO product) {
		
		return productDAO.InsertProduct(product);
	}

	// 4.?ï¿½ï¿½?ï¿½ï¿½
	public int updateProduct(ProductDTO product) {
		return productDAO.updateProduct(product);
	}
	
	// 5.?ï¿½ï¿½?ï¿½ï¿½
	public int deleteProduct(int productid) {
		return productDAO.deleteProduct(productid);
	}
    public List<ProductDTO> searchProducts(String keyword) {
        return productDAO.searchProductsByKeyword(keyword);
    }
}






