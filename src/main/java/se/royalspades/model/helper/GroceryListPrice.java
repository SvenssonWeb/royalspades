package se.royalspades.model.helper;

import java.io.Serializable;

public class GroceryListPrice implements Serializable{

	private static final long serialVersionUID = 1L;
	private String storeName;
	private int storeId;
	private double price;
	
	public GroceryListPrice(){
		
	}
	
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}	
}
