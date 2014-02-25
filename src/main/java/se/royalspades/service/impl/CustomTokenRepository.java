package se.royalspades.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.rememberme.PersistentRememberMeToken;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.stereotype.Component;

import se.royalspades.dao.impl.TokenDao;
import se.royalspades.model.Token;

import java.util.Date;

@Component
public class CustomTokenRepository implements PersistentTokenRepository {

   @Autowired
   private TokenDao tokenDao;

   @Override
   public void createNewToken(PersistentRememberMeToken token) {
       tokenDao.createNewToken(new Token(token));
   }

   @Override
   public void updateToken(String series, String tokenValue, Date lastUsed) {
       tokenDao.updateToken(series, tokenValue, lastUsed);
   }

   @Override
   public PersistentRememberMeToken getTokenForSeries(String seriesId) {
       Token token = tokenDao.getTokenForSeries(seriesId);
       return new PersistentRememberMeToken(token.getUsername(),
               token.getSeries(), token.getTokenValue(), token.getDate());
   }

   @Override
   public void removeUserTokens(String username) {
       tokenDao.removeUserTokens(username);
   }
}