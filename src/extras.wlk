import wollok.game.*
import estudiante.*

class Vehiculo {
	
	var property position
	
	method image()
	method esAtravesable() = true
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
	
	var property position = game.at(12,17)
	var property cantidad = 3
	var property maximo = 3
	
	
	method image() {  return if (cantidad == 1) "vida1.png"
						else if (cantidad == 2) "vida2.png"
						else if (cantidad == 3) "vida3.png"
						else "vacio.png"
	}
	
	method perderVidas(cuantas) {if(cuantas > cantidad){cantidad = 0} else{cantidad = cantidad - cuantas}}
	method ganarVidas(cuantas) { if (cantidad<maximo) cantidad = cantidad + cuantas }
	method vidasAlMax(){
		cantidad = maximo
	}
}

object inicio {
	var property position = game.at(0,0)
	method image() = "inicio.png"
}

object final {
	var property position = game.at(0,0)
	method image() = "final.png"
}

object utn {
	
	var property position = game.at(7,12)
	method image() = "vacio.png"
	method esAtravesable() = true
}



object picante {
	
	var property nivelPicante = 0
	
	var property position = game.at(2,18)
	
	method image() = "vacio.png" //aca le pongo cualquiera dsp lo cambiamos
	
	method subirNivelPicante() { nivelPicante = nivelPicante + 1 } //tambien habria q cambiar la imagen pero bueno cuando la tengamos
	method esAtravesable() = true
	
}

object vidaExtra {
	
	var property position = game.at (7,7)
	
	method image() = "vidaExtra.png"
	method esAtravesable() = true
}

class MuroInvisible {
	var property position
  	method image() = "vacio.png"
  	method esAtravesable() = false
}

////// Score //////

object scoreIzq{
	var property position = game.at(3,17)
	var property image = "vacio.png"
	method scoreFinal(){
	position =  game.at(9,4)
	game.addVisual(self)
	}
	method mostrar(puntaje){
	if(puntaje>=10){ image = numberConverter.getNumberImage((puntaje/10).truncate(0)) }
		else {image = "vacio.png"}
	}
}

object scoreDer{
	var property position = game.at(4,17)
	var property image = numberConverter.getNumberImage(0)
	method scoreFinal(){
	position =  game.at(10,4)
	game.addVisual(self)
	}
	method mostrar(puntaje){
		image = numberConverter.getNumberImage(puntaje % 10) 
	}	
}

object numberConverter{
	method getNumberImage(number){
    	return ( "nro" + number + ".png")
}
}

