package se.royalspades.model.helper;

import java.io.Serializable;

import javax.validation.constraints.Min;

public class GroceryListHelperProduct implements Serializable{

	private static final long serialVersionUID = 1L;
	private int id;
	@Min(0)
	private int volume;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getVolume() {
		return volume;
	}
	public void setVolume(int volume) {
		this.volume = volume;
	}
}
