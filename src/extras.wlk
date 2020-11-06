import wollok.game.*
import estudiante.*

object auto {
	
	var property persona = estudiante
	
	method position() = game.at(contador.sumar(), 0)

	method image() = "auto.png"
	
}

object bici {

	method image() = "bici.png"

	method position() = game.at(7, 3)
}

object contador { //se mueve literalmente a la velocidad de la luz
	
	var property valor = 0
	
	method sumar(){
		if (valor > 10){
			valor = 0
			return valor
		} else {
			valor = valor + 1
			return valor
		}
	}
}
