// Configurat vitest per executar només els fitxers de prova tests/**/*.test.js
// I establir el timezone a Europe/Madrid abans que defineConfig ho faci
process.env.TZ = "Europe/Madrid"

export default {
  test: {
    include: ["tests/**/*.test.js"]
  }
}
