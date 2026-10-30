package cat.cites.fisio.testing;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * Servei de proves (esquelet).
 * Microservei buit registrat a Eureka, utilitzat per verificar l'arquitectura.
 */
@SpringBootApplication
@EnableDiscoveryClient
public class TestingApplication {

    public static void main(String[] args) {
        SpringApplication.run(TestingApplication.class, args);
    }
}
