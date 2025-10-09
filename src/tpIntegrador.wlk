// Clase date para el manejo de fechas
class Fecha {
    const anio
    const mes
    const dia

    const diasPorMes = [31, self.febrero(), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    method esBisiesto() {
        return (anio % 4 == 0 && anio % 100 != 0) || (anio % 400 == 0)
    }

    method febrero() {
        if (self.esBisiesto()) return 29
        
        return 28
    }

    method string() {
        return "" + dia + "-" + mes + "-" + anio
    }

    method dia() { return dia }

    method mes() { return mes }

    method anio() { return anio }

    method diasEnMes() {
        return diasPorMes[mes - 1]
    }

    method siguienteDia() {
        var nuevoDia = dia + 1
        var nuevoMes = mes
        var nuevoAnio = anio

        if (nuevoDia > self.diasEnMes()) {
            nuevoDia = 1
            nuevoMes += 1

            if (nuevoMes > 12) {
                nuevoMes = 1
                nuevoAnio += 1
            }
        }

        return new Fecha(anio = nuevoAnio, mes = nuevoMes, dia = nuevoDia)
    }

    method esIgualA(otra) {
        return anio == otra.anio() && mes == otra.mes() && dia == otra.dia()
    }
    
    method esAnteriorA(otra) {
        if (anio != otra.anio()) return anio < otra.anio()
        if (mes != otra.mes()) return mes < otra.mes()
        return dia < otra.dia()
    }

    method anteriorDia() {
        var nuevoDia = dia - 1
        var nuevoMes = mes
        var nuevoAnio = anio

        if (nuevoDia < 1) {
            nuevoMes -= 1

            if (nuevoMes < 1) {
                nuevoMes = 12
                nuevoAnio -= 1
            }
            const diasMesAnterior = self.diasEnMes()[nuevoMes - 1]

            nuevoDia = diasMesAnterior
        }

        return new Fecha(anio = nuevoAnio, mes = nuevoMes, dia = nuevoDia)
    }

    method diasEntre(otraFecha) {
        if (self.esIgualA(otraFecha)) return 0

        if (self.esAnteriorA(otraFecha))
            return 1 + self.siguienteDia().diasEntre(otraFecha)
        
        return 1 + self.anteriorDia().diasEntre(otraFecha)
    }
}


// PUNTO 1: Instrumentos
class DatosAfinacion {
    const fecha
    const tecnico

    method fecha() { return fecha }

    method tecnico() { return tecnico }
}

class Instrumento {
    const historialAfinaciones = []

    method afinado() { return true }

    method afinar(tecnico) {
        self.registrarAfinacion(tecnico)
    }

    method registrarAfinacion(tecnico) {
        const datosAfinacion = new DatosAfinacion(
            fecha = new Fecha(anio = 2025, mes = 10, dia = 9),
            tecnico = tecnico
        )

        historialAfinaciones.add(datosAfinacion)
    }

    method costo() { return 20 }

    method esValioso() { return false }

    method familia() { return '' }

    method esCopado() { return false }

    method ultimaAfinacion() {
        if (historialAfinaciones.size() == 0) return null

        return historialAfinaciones.last()
    }

    method historialAfinaciones() { return historialAfinaciones }

    method afinacionesRecientes() {
        const fechaActual = new Fecha(anio = 2025, mes = 10, dia = 9)

        // Tomamos un mes como 30 dias de diferencia
        return historialAfinaciones.filter(
            { da => fechaActual.diasEntre(da.fecha()) < 60 }
        )
    }
}

class GuitarraFender inherits Instrumento {
    const color = 'negro'

    override method costo() {
        if (color == 'negro') return 15
        
        return 10
    }

    override method familia() { return 'cuerda' }

    override method esValioso() { return true }
}

class TrompetaJupiter inherits Instrumento {
    const sordina = true
    var temperatura = 22

    override method afinado() { 
        return temperatura >= 20 && temperatura < 25
    }

    override method afinar(tecnico) { 
        temperatura = 22
        self.registrarAfinacion(tecnico)
    }

    override method costo() {
        if (sordina) return 35
        
        return 30
    }

    override method esValioso() {
    return self.afinado()
}

    override method familia() { return 'viento' }

    override method esCopado() { return sordina }
}

class PianoBechstein inherits Instrumento {
    var anchoHabitacion = 5
    var largoHabitacion = 5

    override method afinado() {
        const metCuadrados = anchoHabitacion * largoHabitacion
        return metCuadrados > 20
    }

    override method afinar(tecnico) {
        anchoHabitacion = 8
        largoHabitacion = 4

        self.registrarAfinacion(tecnico)
    }

    override method costo() {
        return 2 * anchoHabitacion
    }

    override method esValioso() { return self.afinado() }

    override method familia() { return 'cuerda' }

    override method esCopado() { return anchoHabitacion > 6 || largoHabitacion > 6 }

    method setDimensiones(ancho, largo) { anchoHabitacion = ancho; largoHabitacion = largo }
}

class ViolinStagg inherits Instrumento {
    const pintura = 'laca acrilica'
    const costoBase = 20
    const costoMinimo = 15
    var tremolo = 0

    override method afinado() { return tremolo < 10 }    

    override method afinar(tecnico) { 
        tremolo = 0
        self.registrarAfinacion(tecnico)
    }

    override method costo() {        
        return (costoBase - tremolo).max(costoMinimo)
    }
    
    override method esValioso() {
        return pintura == 'laca acrilica'
    }

    method hacerTremolo() { tremolo += 1 }

    override method familia() { return 'cuerda' }

    override method esCopado() { return false }
}

// ------------------------------------------------------------------------------------------------------------------------------------------
// PUNTO 2: Musicos
object johann {
    var instrumento = new TrompetaJupiter()

    method instrumento() { return instrumento }

    method esFeliz() { return instrumento.costo() > 20 }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }

    method afinarInstrumento(tecnico) {
        const ultimaAfinacion = instrumento.ultimaAfinacion()
        const fechaActual = new Fecha(anio = 2025, mes = 10, dia = 9)

        if (
            ultimaAfinacion == null || 
            ultimaAfinacion.fecha().diasEntre(fechaActual) > 7
        ) {
            instrumento.afinar(tecnico)
        }
    }

}

object wolfgang {
    var instrumento = null

    method instrumento() { return instrumento }

    method esFeliz() { return johann.esFeliz() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }

    method afinarInstrumento(tecnico) {
        const ultimaAfinacion = instrumento.ultimaAfinacion()
        const fechaActual = new Fecha(anio = 2025, mes = 10, dia = 9)

        if (
            ultimaAfinacion == null || 
            ultimaAfinacion.fecha().diasEntre(fechaActual) > 7
        ) {
            instrumento.afinar(tecnico)
        }
    }
}

object antonio {
    var instrumento = new PianoBechstein()

    method instrumento() { return instrumento }

    method esFeliz() { return instrumento.esValioso() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }

    method afinarInstrumento(tecnico) {
        const ultimaAfinacion = instrumento.ultimaAfinacion()
        const fechaActual = new Fecha(anio = 2025, mes = 10, dia = 9)

        if (
            ultimaAfinacion == null || 
            ultimaAfinacion.fecha().diasEntre(fechaActual) > 7
        ) {
            instrumento.afinar(tecnico)
        }
    }
}

object giuseppe {
    var instrumento = new GuitarraFender()

    method instrumento() { return instrumento }

    method esFeliz() { return instrumento.afinado() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }

    method afinarInstrumento(tecnico) {
        instrumento.afinar(tecnico)
    }
}

object maddalena {
    var instrumento = new ViolinStagg()

    method instrumento() { return instrumento }

    method esFeliz() { return instrumento.costo().even() }

    method cambiarInstrumento(nuevoInstrumento) { 
        instrumento = nuevoInstrumento 
    }

    method afinarInstrumento(tecnico) {
        const ultimaAfinacion = instrumento.ultimaAfinacion()
        const fechaActual = new Fecha(anio = 2025, mes = 10, dia = 9)

        if (
            ultimaAfinacion == null || 
            ultimaAfinacion.fecha().diasEntre(fechaActual) > 7
        ) {
            instrumento.afinar(tecnico)
        }
    }
}

class AsociacioMusical {
    const musicos = [] 

    method musicos() {
    return musicos
    }

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

    method instrumento() { return instrumento }

    method esExperto() {
        return instrumento.familia() == familiaPreferida
    }

    method esFeliz() {
        return instrumento.esCopado()
    }

    method nombre() { return nombre }

    method afinarInstrumento(tecnico) {
        const ultimaAfinacion = instrumento.ultimaAfinacion()
        const fechaActual = new Fecha(anio = 2025, mes = 10, dia = 9)

        if (
            ultimaAfinacion == null || 
            ultimaAfinacion.fecha().diasEntre(fechaActual) > 7
        ) {
            instrumento.afinar(tecnico)
        }
    }
}

class Orquesta {
    const musicos = []
    const cantidadMaxima

    method musicos() { 
        return musicos 
    }


    method agregarMusico(musico) {
        if (musicos.size() < cantidadMaxima - 1) {
            if (!(musicos.any({ m => m.nombre() == musico.nombre() }))) {
                musicos.add(musico)
            }
        }
    }

    method bienConformada() {
        return musicos.all({ m => m.esFeliz() })
    }
}

// ------------------------------------------------------------------------------------------------------------------------------------------
// PUNTO $: Instrumento generico

class InstrumentoGenerico {
    const familia
    var ultimaAfinacion = new Fecha(anio = 2025, mes = 1, dia = 1)

    method costo() {
        var multiplicador

        const azar = (1..10).anyOne()

        if (azar.even()) multiplicador = 2
        else multiplicador = 3

        return familia.size() * multiplicador
    }

    method afinado() {
        // Consultar si hay una forma de obtener la fecha actual
        const fechaActual = new Fecha(anio = 2025, mes = 10, dia = 9)

        // Tomamos un mes como 30 dias de diferencia
        return fechaActual.diasEntre(ultimaAfinacion) < 30
    }

    method afinar() {
        ultimaAfinacion = new Fecha(anio = 2025, mes = 10, dia = 9)
    }

    method esCopado() { return false }

    method familia() { return familia }

    method esValioso() { return false }
}

// ------------------------------------------------------------------------------------------------------------------------------------------
// PUNTO 5: Afinacion de los instrumentos

