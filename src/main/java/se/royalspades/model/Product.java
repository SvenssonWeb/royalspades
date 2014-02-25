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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator=ObjectIdGenerators.IntSequenceGenerator.class, property="@id")
@Table(name = "products", catalog = "spade_db")
public class Product implements Serializable{

	private static final long serialVersionUID = 1L;
	private int id;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String name;
	@Min(0)
	private double volume;
	@NotEmpty
	@Size(min = 1, max = 45)
	private String unit;
	private Brand brand;
	private Category category;
	private Set<GroceryListProduct> groceryListProducts = new HashSet<GroceryListProduct>(0);
	private Set<StoreProduct> storeProducts = new HashSet<StoreProduct>(0);
	
	public Product(){
		
	}
	
	public Product(String name, double volume, String unit, Brand brand,
			Category category) {
		super();
		this.name = name;
		this.volume = volume;
		this.unit = unit;
		this.brand = brand;
		this.category = category;
	}
	
	public Product(String name, double volume, String unit, Brand brand,
			Category category, Set<GroceryListProduct> groceryListProducts) {
		super();
		this.name = name;
		this.volume = volume;
		this.unit = unit;
		this.brand = brand;
		this.category = category;
		this.groceryListProducts = groceryListProducts;
	}
	
	public Product(String name, double volume, String unit, Brand brand,
			Category category, Set<GroceryListProduct> groceryListProducts, Set<StoreProduct> storeProducts) {
		super();
		this.name = name;
		this.volume = volume;
		this.unit = unit;
		this.brand = brand;
		this.category = category;
		this.groceryListProducts = groceryListProducts;
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
	
    @Column(name = "volume")
	public double getVolume() {
		return volume;
	}
    
	public void setVolume(double volume) {
		this.volume = volume;
	}
	
    @Column(name = "unit", length = 45)
	public String getUnit() {
		return unit;
	}
    
	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	//@JsonBackReference
	@JsonIgnoreProperties(value = { "user", "brandProducts" })
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "brand_id", nullable = false)
	public Brand getBrand() {
		return brand;
	}
	
	public void setBrand(Brand brand) {
		this.brand = brand;
	}
	
	@JsonIgnoreProperties(value = { "products" })
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id", nullable = false)
	public Category getCategory() {
		return category;
	}
	
	public void setCategory(Category category) {
		this.category = category;
	} 

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "pk.product")
	public Set<GroceryListProduct> getGroceryListProducts() {
		return groceryListProducts;
	}

	public void setGroceryListProducts(Set<GroceryListProduct> groceryListProducts) {
		this.groceryListProducts = groceryListProducts;
	}
	
	@JsonIgnoreProperties(value = { "storeProduct", "storeProducts", "user" })
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "pk.product", cascade = CascadeType.ALL, orphanRemoval=true)
	public Set<StoreProduct> getStoreProducts() {
		return storeProducts;
	}

	public void setStoreProducts(Set<StoreProduct> storeProducts) {
		this.storeProducts = storeProducts;
	}
	
}
