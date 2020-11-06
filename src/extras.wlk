import wollok.game.*
import estudiante.*

class Vehiculo {
	
	var property position
	
	method image()
	
	method avanzarIzquierda() {
		if(position.x() == 0){
			position = game.at(9, position.y())
		} else {
		position = position.left(1)
		}
	}
	
	method avanzarDerecha() {
		if(position.x() == 9){
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
	
	override method image() = "bondi.png"
}

object vidas {
	
	var property position = game.at(8,8)
	var property cantidad = 3
	
	method image() { return if (cantidad == 0) "sinVidas.png" else "vidas.png" }
	
	method perderVidas(cuantas) {if(cuantas > cantidad){cantidad = 0} else{cantidad = cantidad - cuantas}}
}

object utn {
	
	var property position = game.at(5,8)
	
	method image() = "universidad.png"
}


