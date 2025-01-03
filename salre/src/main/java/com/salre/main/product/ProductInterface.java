package com.salre.main.product;

import java.util.List;

public interface ProductInterface {
    public int InsertProduct(ProductDTO product);
    public ProductDTO selectByIdService(int product_id);
    public ProductDTO getProductById(int product_id);
    public List<ProductDTO> selectAllProducts();
    public int updateProduct(ProductDTO product);
    public int deleteProduct(int productId);
	public List<ProductDTO> searchProductsByKeyword(String keyword);
	public ProductDTO selectAllByContractId(int contract_id);
}
