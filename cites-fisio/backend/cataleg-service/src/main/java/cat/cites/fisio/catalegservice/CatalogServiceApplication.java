package cat.cites.fisio.catalegservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Servei intern de catàleg.
 * Proporciona dades estàtiques sobre serveis i especialitats disponibles.
 */
@SpringBootApplication
public class CatalogServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(CatalogServiceApplication.class, args);
    }
}
