package com.salre.main.contract;

import com.salre.main.product.ProductContractDTO;

public interface ContractDAOInterface {
	public ContractDTO selectById(int  contract_id);
	public ContractUserDTO selectAllById(int  contract_id);
	public ProductContractDTO selectContractPById(int  contract_id);
	public int insert(ContractDTO contract);
	public int update(ContractDTO  contract);
	public int delete(int  contract_id);
	public int deleteArray(Integer[]  contract_id);
}
