import wollok.game.*
import extras.*
import niveles.*

object estudiante {
	
	var property position = game.at(7,1)
	var property imagen = "personajeArriba.png"
	
//	method image() {
//		return if (self.position() == auto.position()) "rip.png" else "personajeArriba.png"
//	}
	
	method image() = imagen

	method chocadoPorAuto() {
		game.say(self, "aaaaaa")
		self.volverAlInicio()
		imagen = "personajeArriba.png"
		vidas.perderVidas(1)
	}
	
	method chocadoPorBondi() {
		self.volverAlInicio()
		vidas.perderVidas(2)
	}
	
	method volverAlInicio(){
		position = game.at(7,1)
		imagen = "personajeArriba.png"
	}
	
	method estaEnLaFacu() {
		return position == utn.position()
	}
	
	method pasarDeNivel() {
		self.volverAlInicio()
		niveles.pasarNivel()
	}
	
}
