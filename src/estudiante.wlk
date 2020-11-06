import wollok.game.*
import extras.*

object estudiante {
	
	var property position = game.at(7,1)
	
	method image() {
		return if (self.position() == auto.position()) "rip.png" else "personajeArriba.png"
	}
	
	method chocadoPorAuto() {
		self.volverAlInicio()
		vidas.perderVidas(1)
	}
	
	method chocadoPorBondi() {
		self.volverAlInicio()
		vidas.perderVidas(2)
	}
	
	method volverAlInicio(){
		position = game.at(7,1)
	}
	
	method estaEnLaFacu() {
		return position == utn.position()
	}
}
