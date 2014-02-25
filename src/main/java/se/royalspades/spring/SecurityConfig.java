package se.royalspades.spring;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

@Configuration
@ImportResource({ "classpath:webSecurityConfig.xml" })
@ComponentScan("se.royalspades.security")
public class SecurityConfig {

    public SecurityConfig() {
        super();
    }

}