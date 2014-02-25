package se.royalspades.model;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;

@SuppressWarnings("serial")
@Embeddable
public class StoreProductId implements Serializable {
	private Store store;
	private Product product;
	private Category category;
	
	@ManyToOne
	public Store getStore() {
		return store;
	}
	
	public void setStore(Store store) {
		this.store = store;
	}
	
	@ManyToOne
	public Product getProduct() {
		return product;
	}
	
	public void setProduct(Product product) {
		this.product = product;
	}
	
	@ManyToOne
	public Category getCategory(){
		return category;
	}
	
	public void setCategory(Category category) {
		this.category = category;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((category == null) ? 0 : category.hashCode());
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((store == null) ? 0 : store.hashCode());
		return result;
	}

	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		
		StoreProductId that = (StoreProductId) o;
		
		if (store != null ? !store.equals(that.store) : that.store != null) return false;
		if (product != null ? !product.equals(that.product) : that.product != null) return false;
		if(category != null ? !category.equals(that.category) : that.category != null) return false;
		return true;
	}
	
}