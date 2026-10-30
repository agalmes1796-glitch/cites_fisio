package cat.cites.fisio.testing;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

/**
 * Prova de fum de l'esquelet: arrossega tot el context i comprova
 * que el punt de salut respon correctament.
 *
 * S'emet la crida HTTP de veritat a traves de MockMvc sobre el context
 * real de la aplicacio. Sense mocks ni espies.
 */
@SpringBootTest
class TestingApplicationTest {

    @Autowired
    private WebApplicationContext context;

    private MockMvc mockMvc;

    @BeforeEach
    void muntaMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    void el_context_arrenca() {
        assertThat(context).isNotNull();
        assertThat(context.getBean(TestingHealthController.class)).isNotNull();
    }

    @Test
    void la_ruta_de_salut_respon_el_servei_actiu() throws Exception {
        MvcResult resposta = mockMvc.perform(get("/api/health"))
                .andExpect(status().isOk())
                .andReturn();

        String cos = resposta.getResponse().getContentAsString();
        assertThat(cos)
                .contains("\"servei\":\"testing\"")
                .contains("\"estat\":\"UP\"");
    }
}
