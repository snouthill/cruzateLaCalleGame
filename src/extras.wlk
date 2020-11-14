import wollok.game.*
import estudiante.*

class Vehiculo {
	
	var property position
	
	method image()
	
	method avanzarIzquierda() {
		if(position.x() == 0){
			position = game.at(14, position.y())
		} else {
		position = position.left(1)
		}
	}
	
	method avanzarDerecha() {
		if(position.x() == 14){
			position = game.at(0, position.y())
		} else {
		position = position.right(1)
		}
	} 
}

object auto inherits Vehiculo(position = game.at(5, 4)) {

	override method image() = "auto.png"	
}

object bici inherits Vehiculo(position = game.at(9, 2)) {

	override method image() = "bici.png"	
}

object bondi inherits Vehiculo(position = game.at(3,6)) {
	
	override method image() = "bondiAdelante.png"
}

object vidas {
	
	var property position = game.at(14,14)
	var property cantidad = 3
	
	method image() { return if (cantidad == 0) "sinVidas.png" else "vidas.png" }
	
	method perderVidas(cuantas) {if(cuantas > cantidad){cantidad = 0} else{cantidad = cantidad - cuantas}}
}

object utn {
	
	var property position = game.at(5,13)
	
	method image() = "utn.png"
}

object picante {
	
	var property nivelPicante = 0
	
	var property position = game.at(7,12)
	
	method image() = "rip.png" //aca le pongo cualquiera dsp lo cambiamos
	
	method subirNivelPicante() { nivelPicante = nivelPicante + 1 } //tambien habria q cambiar la imagen pero bueno cuando la tengamos
	
	
}

object vidaExtra {
	
	var property position = game.at (7,7)
	
	method image() = "vidaExtra.png"
}

