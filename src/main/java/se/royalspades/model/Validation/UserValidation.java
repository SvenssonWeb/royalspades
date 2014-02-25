package se.royalspades.model.Validation;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class UserValidation implements Serializable{

	private static final long serialVersionUID = 1L;
	int id;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String firstName;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String lastName;
	@NotEmpty
	@Size(min = 2, max = 45)
	@Email
	private String email;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String username;
	
	public UserValidation(){
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}
