package se.royalspades.model.Validation;

import java.io.Serializable;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class PasswordValidation implements Serializable{

	private static final long serialVersionUID = 1L;
	int id;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String password;
	private String passwordConfirm;
	@NotEmpty
	@Size(min = 2, max = 45)
	private String oldPassword;
	
	public PasswordValidation(){
		
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPasswordConfirm() {
		return passwordConfirm;
	}
	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
	}
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
}
