// PUNTO 1: Instrumentos
class GuitarraFender {
    const color = 'negro'
    const familia = 'cuerda'

    method afinado() { return true }

    method afinar() {}

    method costo() {
        if (color == 'negro') return 15
        
        return 10
    }

    method esValioso() { return true }

    method familia() { return familia }

    method esCopado() { return false }
}

class TrompetaJupiter {
    const sordina = true
    const familia = 'viento'
    const temperaturaAmbiente = 20
    var seAfino = false

    method afinado() { 
        if (temperaturaAmbiente >= 20 && temperaturaAmbiente <= 25) 
            return true
         
        return seAfino 
    }

    method afinar() { seAfino = true }

    method costo() {
        if (sordina) return 35
        
        return 30
    }

    method esValioso() { return false }

    method familia() { return familia }

    method esCopado() { return sordina }
}

class PianoBechstein {
    const anchoHabitacion = 5
    const largoHabitacion = 5
    const familia = 'cuerda'
    var ultimaRevision = '2025-01-01'

    method afinado() {
        const metCuadrados = anchoHabitacion * largoHabitacion
        return metCuadrados > 20
    }

    method afinar() {}

    method costo() {
        return 2 * anchoHabitacion
    }

    method esValioso() { return self.afinado() }

    method revisar(fecha) { ultimaRevision = fecha }

    method familia() { return familia }

    method esCopado() { return anchoHabitacion > 6 || largoHabitacion > 6 }
}

class ViolinStagg {
    const familia = 'cuerda'
    const pintura = 'laca acrilica'
    const costoBase = 20
    const costoMinimo = 15
    var tremolo = 0

    method afinado() { return tremolo < 10 }

    method afinar() { }

    method costo() {        
        return (costoBase - tremolo).max(costoMinimo)
    }
    
    method esValioso() {
        return pintura == 'laca acrilica'
    }

    method hacerTremolo() { tremolo += 1 }

    method familia() { return familia }

    method esCopado() { return false }
}

// ------------------------------------------------------------------------------------------------------------------------------------------
// PUNTO 2: Musicos
object johann {
    var instrumento = new TrompetaJupiter()

    method esFeliz() { return instrumento.costo() > 20 }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }
}

object wolfgang {
    var instrumento = null

    method esFeliz() { return johann.esFeliz() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }
}

object antonio {
    var instrumento = new PianoBechstein()

    method esFeliz() { return instrumento.esValioso() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }
}

object giuseppe {
    var instrumento = new GuitarraFender()

    method esFeliz() { return instrumento.afinado() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }
}

object maddalena {
    var instrumento = new ViolinStagg()

    method esFeliz() { return instrumento.costo().even() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }
}

class AsociacioMusical {
    const musicos = []

    method sonFelices() {
        return musicos.filter({ m => m.esFeliz() })
    }
}

// ------------------------------------------------------------------------------------------------------------------------------------------
// PUNTO 3: Musicos y orquesta

class Musico {
    const familiaPreferida
    const instrumento
    const nombre

    method esExperto() {
        return instrumento.familia() == familiaPreferida
    }

    method esFeliz() {
        return instrumento.esCopado()
    }

    method nombre() { return nombre }
}

class Orquesta {
    const musicos = []
    const cantidadMaxima

    method agregarMusico(musico) {
        if (musicos.size() < cantidadMaxima) {
            if (!(musicos.any({ m => m.nombre() == musico.nombre() }))) {
                musicos.add(musico)
            }
        }
    }

    method bienConformada() {
        return musicos.all({ m => m.esFeliz() })
    }
}


