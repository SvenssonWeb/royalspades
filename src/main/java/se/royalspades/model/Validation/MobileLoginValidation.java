package se.royalspades.model.Validation;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class MobileLoginValidation implements Serializable{

	private static final long serialVersionUID = 1L;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String username;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String password;
	
	public MobileLoginValidation(){
		
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
