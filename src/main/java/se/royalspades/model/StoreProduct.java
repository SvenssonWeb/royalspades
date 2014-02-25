package se.royalspades.model;

import java.io.Serializable;

import javax.persistence.AssociationOverride;
import javax.persistence.AssociationOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@SuppressWarnings("serial")
@Entity
@Table(name = "companies_has_products", catalog = "spade_db")
@AssociationOverrides({
	@AssociationOverride(name = "pk.store", 
		joinColumns = @JoinColumn(name = "store_id")),
	@AssociationOverride(name = "pk.product", 
		joinColumns = @JoinColumn(name = "product_id")),
	@AssociationOverride(name = "pk.category", 
		joinColumns = @JoinColumn(name = "category_id")) })
public class StoreProduct implements Serializable{

	private StoreProductId pk = new StoreProductId();
	private double price;
	
	public StoreProduct() {
		
	}
	
	@JsonIgnore
	@EmbeddedId
	public StoreProductId getPk() {
		return pk;
	}
	
	public void setPk(StoreProductId pk) {
		this.pk = pk;
	}
	
	@Transient
	@JsonIgnoreProperties(value = { "storeProducts", "storeProduct", "user", "products" })
	public Store getStore() {
		return getPk().getStore();
	}
	
	public void Store(Store store) {
		getPk().setStore(store);
	}
	
	@Transient
	@JsonIgnoreProperties(value = { "storeProducts", "storeProduct", "store" })
	public Product getProduct() {
		return getPk().getProduct();
	}
	
	public void setProduct(Product product) {
		getPk().setProduct(product);
	}
	
	@Transient
	public Category getCategory() {
		return getPk().getCategory();
	}
	
	public void setCategory(Category category) {
		getPk().setCategory(category);
	}
	
	@Column(name = "price", nullable = true, length = 45)
	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public boolean equals(Object o) {
		if(this == o)
			return true;
		if(o == null || getClass() != o.getClass())
			return false;
		
		StoreProduct that = (StoreProduct) o;
		
		if (getPk() != null ? !getPk().equals(that.getPk())
				: that.getPk() != null)
			return false;
		
		return true;
		
	}
	
	public int hashCode() {
		return (getPk() != null ? getPk().hashCode() : 0);
	}
	
}
