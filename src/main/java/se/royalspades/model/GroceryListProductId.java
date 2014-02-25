package se.royalspades.model;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;


@SuppressWarnings("serial")
@Embeddable
public class GroceryListProductId implements Serializable {
	private GroceryList groceryList;
	private Product product;
	
	@ManyToOne
	public GroceryList getGroceryList() {
		return groceryList;
	}
	
	public void setGroceryList(GroceryList groceryList) {
		this.groceryList = groceryList;
	}
	
	@ManyToOne
	public Product getProduct() {
		return product;
	}
	
	public void setProduct(Product product) {
		this.product = product;
	}
	
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		
		GroceryListProductId that = (GroceryListProductId) o;
		
		if (groceryList != null ? !groceryList.equals(that.groceryList) : that.groceryList != null) return false;
		if (product != null ? !product.equals(that.product) : that.product != null) return false;
		
		return true;
	}
	
	public int hashCode() {
		int result;
		result = (groceryList != null ? groceryList.hashCode() : 0);
		result = 31 * result + (product != null ? product.hashCode() : 0);
		return result;
	}
	
}
