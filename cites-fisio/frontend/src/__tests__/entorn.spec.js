import { describe, expect, it } from 'vitest'

/**
 * Proves d'aprenentatge sobre l'entorn, no sobre el domini.
 * Cada prova verifica un comportament bàsic de JavaScript o de la configuració.
 */

describe("Entorn", () => {
  /**
   * ID: E-01
   * Comportament: Una data ISO sense Z s'interpreta com a hora local
   * Resultat esperat: new Date("2026-10-06T10:00") té getHours() 10, getMinutes() 0 i getDay() 2 (dimarts)
   */
  it("E-01 - Una data ISO sense Z s'interpreta com a hora local", () => {
    // Arrange
    const dataISO = "2026-10-06T10:00"

    // Act
    const data = new Date(dataISO)

    // Assert
    expect(data.getHours()).toBe(10)
    expect(data.getMinutes()).toBe(0)
    expect(data.getDay()).toBe(2)
  })

  /**
   * ID: E-02
   * Comportament: Les proves s'executen en el timezone Europe/Madrid
   * Resultat esperat: new Date("2026-10-06T10:00").getTimezoneOffset() retorna -120
   */
  it("E-02 - Les proves s'executen en el timezone Europe/Madrid", () => {
    // Arrange
    const dataISO = "2026-10-06T10:00"

    // Act
    const data = new Date(dataISO)

    // Assert
    expect(data.getTimezoneOffset()).toBe(-120)
  })

  /**
   * ID: E-03
   * Comportament: El constructor numèric compta mesos a partir de 0
   * Resultat esperat: new Date(2026, 9, 6) és igual a new Date("2026-10-06T00:00")
   */
  it("E-03 - El constructor numèric compta mesos a partir de 0", () => {
    // Arrange
    const anyData = null

    // Act
    const dataConstructor = new Date(2026, 9, 6)
    const dataISO = new Date("2026-10-06T00:00")

    // Assert
    expect(dataConstructor).toEqual(dataISO)
  })

  /**
   * ID: E-04
   * Comportament: Els cèntims enteros s'afegeixen exactament; el flotant no
   * Resultat esperat: 0.1 + 0.2 no és 0.3, i 10 + 20 és 30
   */
  it("E-04 - Els cèntims enteros s'afegeixen exactament; el flotant no", () => {
    // Arrange
    const centimFlotant = 0.1
    const centimFlotant2 = 0.2
    const sumaEnteres = 10
    const centsEnteres2 = 20

    // Act
    const sumaFlotant = centimFlotant + centimFlotant2
    const sumaEntera = sumaEnteres + centsEnteres2

    // Assert
    expect(sumaFlotant).not.toBe(0.3)
    expect(sumaEntera).toBe(30)
  })
})
