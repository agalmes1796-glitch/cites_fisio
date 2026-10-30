package cat.cites.fisio.citesservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Servei principal de cites.
 * Gestiona la reserva, cancel·lació i visualització de cites per a fisioteràpia.
 */
@SpringBootApplication
public class CitesServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(CitesServiceApplication.class, args);
    }
}
