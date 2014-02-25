package se.royalspades.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import se.royalspades.dao.UserDAO;

@Service
@Transactional(readOnly=true)
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UserDAO userDAO;	

	public UserDetails loadUserByUsername(String login)
			throws UsernameNotFoundException {

		se.royalspades.model.User domainUser = userDAO.getUserByUsername(login);
		
		boolean enabled = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;

		return new User(
				domainUser.getUsername(),
				domainUser.getPassword(), 
				enabled, 
				accountNonExpired, 
				credentialsNonExpired, 
				accountNonLocked,
				getAuthorities(domainUser.getRole())
		);
	}

	public Collection<? extends GrantedAuthority> getAuthorities(String role) {
		List<GrantedAuthority> authList = getGrantedAuthorities(getRoles(role));
		return authList;
	}

	public List<String> getRoles(String role) {

		List<String> roles = new ArrayList<String>();

		if (role.contains("admin")) {
			roles.add("ROLE_ADMIN");
		} else if (role.equals("producer")){
			roles.add("ROLE_SUPERVISOR");
		} else if (role.contains("shopowner")) {
			roles.add("ROLE_MODERATOR");
		} else if(role.contains("user")) {
			roles.add("ROLE_USER");
		}
		return roles;
	}

	public static List<GrantedAuthority> getGrantedAuthorities(List<String> roles) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

		for (String role : roles) {
			authorities.add(new SimpleGrantedAuthority(role));
		}
		return authorities;
	}

}
