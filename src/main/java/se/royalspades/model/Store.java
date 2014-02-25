package se.royalspades.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import static javax.persistence.GenerationType.IDENTITY;

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
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
 
@Entity
@JsonIdentityInfo(generator=ObjectIdGenerators.IntSequenceGenerator.class, property="@id")
@Table(name = "stores", catalog = "spade_db")
public class Store implements Serializable{

	private static final long serialVersionUID = 1L;
	private int id;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String name;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String orgNumber;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String address;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String phone;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String city;
	@NotEmpty
	@Size(min = 2, max = 6)
	private String postalCode;
	private User user;
    private Set<StoreProduct> storeProducts = new HashSet<StoreProduct>(0);
    
	public Store(){
	}
	
	public Store(String name, String orgNumber, String address, String phone, User user) {
		this.name = name;
		this.orgNumber = orgNumber;
		this.address = address;
		this.phone = phone;
		this.user = user;
	}
	
	public Store(String name, String orgNumber, String address, String phone, User user, Set<StoreProduct> storeProducts) {
		this.name = name;
		this.orgNumber = orgNumber;
		this.address = address;
		this.phone = phone;
		this.user = user;
		this.storeProducts = storeProducts;
	}
	
	@Id
    @GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}
	
	public void setId(int storeId) {
		this.id = storeId;
	}
	
    @Column(name = "name", length = 45)
	public String getName() {
		return name;
	}
    
	public void setName(String name) {
		this.name = name;
	}
	
    @Column(name = "organisation_number", length = 45)
	public String getOrgNumber() {
		return orgNumber;
	}
    
	public void setOrgNumber(String orgNumber) {
		this.orgNumber = orgNumber;
	}
	
    @Column(name = "address", length = 45)
	public String getAddress() {
		return address;
	}
    
	public void setAddress(String address) {
		this.address = address;
	}
	
    @Column(name = "phone", length = 45)
	public String getPhone() {
		return phone;
	}
    
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
    @Column(name = "city", length = 45)
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

    @Column(name = "postal_code", length = 45)
	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	@OneToOne(fetch = FetchType.EAGER)
	//@PrimaryKeyJoinColumn
	@JoinColumn(name = "user_id")
	public User getUser(){
		return user;
	}
	
	public void setUser(User user){
		this.user = user;
	}
	
	@JsonIgnoreProperties(value = { "storeProduct", "storeProducts", "store", "products" })
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "pk.store", cascade = CascadeType.ALL, orphanRemoval=true)
	public Set<StoreProduct> getStoreProduct() {
		return storeProducts;
	}

	public void setStoreProduct(Set<StoreProduct> storeProducts) {
		this.storeProducts = storeProducts;
	}
	
}
