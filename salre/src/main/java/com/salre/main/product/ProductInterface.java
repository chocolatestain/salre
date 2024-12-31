package com.salre.main.product;

import java.util.List;

public interface ProductInterface {
    public int InsertProduct(ProductDTO product);
    public ProductDTO getProductById(int productId);
    public List<ProductDTO> selectAllProducts();
    public int updateProduct(ProductDTO product);
    public int deleteProduct(int productId);
	public List<ProductDTO> searchProductsByKeyword(String keyword);
	public List<ProductDTO> searchByConditions();
    public int countProduct();
}
