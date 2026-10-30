package cat.cites.fisio.testing;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controlador de salut del servei de proves.
 * Permet verificar que el servei és actiu sense implementar cap regla de negoci.
 */
@RestController
public class TestingHealthController {

    private final String nomServei;

    public TestingHealthController(@Value("${spring.application.name}") String nomServei) {
        this.nomServei = nomServei;
    }

    @GetMapping("/api/health")
    public Map<String, String> salut() {
        return Map.of(
                "servei", nomServei,
                "estat", "UP"
        );
    }
}
