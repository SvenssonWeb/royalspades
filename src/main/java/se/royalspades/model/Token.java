package se.royalspades.model;

import org.springframework.security.web.authentication.rememberme.PersistentRememberMeToken;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Entity;

@Entity
@Table(name = "persistent_logins", catalog = "spade_db")
public class Token {
 
    private String series;
    private String username;
    private String tokenValue;
    private Date date;
 
    public Token() {
    }
 
    public Token(PersistentRememberMeToken persistentRememberMeToken) {
        this.username = persistentRememberMeToken.getUsername();
        this.series = persistentRememberMeToken.getSeries();
        this.date = persistentRememberMeToken.getDate();
        this.tokenValue = persistentRememberMeToken.getTokenValue();
    }
    
    @Id
	@Column(name = "series", unique = true, nullable = false)
    public String getSeries() {
        return series;
    }
 
    public void setSeries(String series) {
        this.series = series;
    }

 
	@Column(name = "username", nullable = false)
    public String getUsername() {
        return username;
    }
 
    public void setUsername(String username) {
        this.username = username;
    }
 
	@Column(name = "token", nullable = false)
    public String getTokenValue() {
        return tokenValue;
    }
 
    public void setTokenValue(String tokenValue) {
        this.tokenValue = tokenValue;
    }
    
	@Column(name = "last_used", nullable = false)
    public Date getDate() {
        return date;
    }
 
    public void setDate(Date date) {
        this.date = date;
    }
}
