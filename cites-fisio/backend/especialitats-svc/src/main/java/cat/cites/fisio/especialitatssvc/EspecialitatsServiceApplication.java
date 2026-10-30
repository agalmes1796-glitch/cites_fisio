package cat.cites.fisio.especialitatssvc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Servei d'especialitats.
 * Gestiona les operacions CRUD sobre les especialitats de tractament.
 */
@SpringBootApplication
public class EspecialitatsServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(EspecialitatsServiceApplication.class, args);
    }
}
