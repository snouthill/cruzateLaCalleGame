import wollok.game.*
import extras.*

object estudiante {
	
	var property position = game.origin()
	
	method image() {
		return if (self.position() == auto.position()) "rip.png" else "caminando.png"
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
		position = game.origin()
	}
	
	method estaEnLaFacu() {
		return position == utn.position()
	}
}
