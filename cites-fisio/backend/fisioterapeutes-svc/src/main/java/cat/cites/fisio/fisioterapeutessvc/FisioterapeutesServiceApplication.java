package cat.cites.fisio.fisioterapeutessvc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Servei de fisioterapeutes.
 * Gestiona les operacions CRUD sobre els professionals de fisioteràpia.
 */
@SpringBootApplication
public class FisioterapeutesServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(FisioterapeutesServiceApplication.class, args);
    }
}
