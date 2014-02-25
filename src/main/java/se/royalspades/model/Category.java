package se.royalspades.model;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator=ObjectIdGenerators.IntSequenceGenerator.class, property="@id")
@Table(name = "categories", catalog = "spade_db")
public class Category implements Serializable{

	private static final long serialVersionUID = 1L;
	private int id;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String name;
	private Set<Product> products = new HashSet<Product>(0);
	private Set<StoreProduct> storeProducts = new HashSet<StoreProduct>(0);
	
	public Category(){
		
	}
	
	public Category(int id, String name){
		super();
		this.id = id;
		this.name = name;
	}
	
	public Category(int id, String name, Set<Product> products) {
		super();
		this.id = id;
		this.name = name;
		this.products = products;
	}
	
	public Category(int id, String name, Set<Product> products, Set<StoreProduct> storeProducts) {
		super();
		this.id = id;
		this.name = name;
		this.products = products;
		this.storeProducts = storeProducts;
	}
	
	@Id
    @GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
    @Column(name = "name", length = 45)
	public String getName() {
		return name;
	}
    
	public void setName(String name) {
		this.name = name;
	}

	@JsonIgnore
	//@JsonIgnoreProperties(value = { "stores", "products" })
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "category")
	public Set<Product> getProducts() {
		return products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "pk.category", cascade = CascadeType.ALL, orphanRemoval=true)
	public Set<StoreProduct> getStoreProducts() {
		return storeProducts;
	}
	
	public void setStoreProducts(Set<StoreProduct> storeProducts) {
		this.storeProducts = storeProducts;
	}
	
}
