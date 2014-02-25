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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator=ObjectIdGenerators.IntSequenceGenerator.class, property="@id")
@Table(name = "grocery_lists", catalog = "spade_db")
public class GroceryList implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int id;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String name;
	private User listOwner;
	private Set<GroceryListProduct> groceryListProducts = new HashSet<GroceryListProduct>(0);
	
	public GroceryList(){
		
	}
	
	public GroceryList(String name, User listOwner) {
		super();
		this.name = name;
		this.listOwner = listOwner;
	}
	
	public GroceryList(String name, User listOwner, Set<GroceryListProduct> groceryListProduct){
		this.name = name;
		this.listOwner = listOwner;
		this.groceryListProducts = groceryListProduct;
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
	
	@OneToOne(fetch = FetchType.EAGER)
	//@PrimaryKeyJoinColumn
	@JoinColumn(name = "user_id")
	public User getListOwner() {
		return listOwner;
	}

	public void setListOwner(User listOwner) {
		this.listOwner = listOwner;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "pk.groceryList", cascade = CascadeType.ALL, orphanRemoval=true)
	public Set<GroceryListProduct> getGroceryListProducts() {
		return groceryListProducts;
	}

	public void setGroceryListProducts(Set<GroceryListProduct> groceryListProducts) {
		this.groceryListProducts = groceryListProducts;
	}
}
