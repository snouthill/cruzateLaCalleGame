import wollok.game.*
import extras.*

object estudiante {
	
	var property position = game.origin()
	
	method image() {
		return if (self.position() == auto.position()) "rip.png" else "caminando.png"
	}
}
