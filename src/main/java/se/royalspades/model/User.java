package se.royalspades.model;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table(name = "users", catalog = "spade_db")
public class User implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private int id;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String firstName;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String lastName;
	private String role;
	@NotEmpty
	@Size(min = 2, max = 45)
	@Email
	private String email;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String username;
	@NotEmpty
	@Size(min = 5, max = 145)
	private String password;
	private String passwordConfirm;
	private String requestedAuthority;
	
	public User(){
		
	}
	
	public User(String firstName, String lastName, String role, String email, String username,
			String password, String requestedAuthority) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.role = role;
		this.email = email;
		this.username = username;
		this.password = password;
		this.requestedAuthority = requestedAuthority;
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
	
    @Column(name = "first_name", length = 45)
	public String getFirstName() {
		return firstName;
	}
    
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
    @Column(name = "last_name", length = 45)
	public String getLastName() {
		return lastName;
	}
    
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
    @Column(name = "role", length = 45)
	public String getRole() {
		return role;
	}
    
	public void setRole(String role) {
		this.role = role;
	}
	
    @Column(name = "email", length = 45)
	public String getEmail() {
		return email;
	}
    
	public void setEmail(String email) {
		this.email = email;
	}
	
    @Column(name = "username", unique = true, length = 45)
	public String getUsername() {
		return username;
	}
    
	public void setUsername(String username) {
		this.username = username;
	}
	
    @Column(name = "password", length = 255)
    @JsonIgnore 
	public String getPassword() {
		return password;
	}
    
    @JsonProperty("password")
	public void setPassword(String password) {
		this.password = password;
	}
    
    @Transient
    @JsonIgnore 
	public String getPasswordConfirm() {
		return passwordConfirm;
	}

	@JsonProperty("passwordConfirm")
	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
	}

	@Column(name = "requested_authority", length = 45)
	public String getRequestedAuthority() {
		return requestedAuthority;
	}

	public void setRequestedAuthority(String requestedAuthority) {
		this.requestedAuthority = requestedAuthority;
	}
}