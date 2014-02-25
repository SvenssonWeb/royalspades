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

@SuppressWarnings("serial")
@Entity
@Table(name = "grocery_lists_has_products", catalog = "spade_db")
@AssociationOverrides({
	@AssociationOverride(name = "pk.groceryList", 
		joinColumns = @JoinColumn(name = "grocery_list_id")),
	@AssociationOverride(name = "pk.product", 
		joinColumns = @JoinColumn(name = "product_id")) })
public class GroceryListProduct implements Serializable{

	private GroceryListProductId pk = new GroceryListProductId();
	private int volume;
	
	public GroceryListProduct() {
		
	}
	
	@JsonIgnore
	@EmbeddedId
	public GroceryListProductId getPk() {
		return pk;
	}
	
	public void setPk(GroceryListProductId pk) {
		this.pk = pk;
	}
	
	@Transient
	public GroceryList getGroceryList() {
		return getPk().getGroceryList();
	}
	
	public void setGroceryList(GroceryList groceryList) {
		getPk().setGroceryList(groceryList);
	}
	
	@Transient
	public Product getProduct() {
		return getPk().getProduct();
	}
	
	public void setProduct(Product product) {
		getPk().setProduct(product);
	}
	
	@Column(name = "volume", nullable = false, length = 10)
	public int getVolume() {
		return this.volume;
	}
	
	public void setVolume(int volume) {
		this.volume = volume;
	}
	
	public boolean equals(Object o) {
		if(this == o)
			return true;
		if(o == null || getClass() != o.getClass())
			return false;
		
		GroceryListProduct that = (GroceryListProduct) o;
		
		if (getPk() != null ? !getPk().equals(that.getPk())
				: that.getPk() != null)
			return false;
		
		return true;
		
	}
	
	public int hashCode() {
		return (getPk() != null ? getPk().hashCode() : 0);
	}
	
}
