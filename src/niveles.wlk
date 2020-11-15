import extras.*
import wollok.game.*
import estudiante.*

object objetosPrincipales {

	method mostrar() {
		game.addVisual(auto)
		game.addVisual(bici)
		game.addVisual(vidas)
		game.addVisual(bondi)
		game.addVisual(utn)
		game.addVisual(picante)
		game.addVisual(vidaExtra) // ahora la pongo acá pero podriamos ponerla recien en niveles dificiles
		game.addVisualCharacter(estudiante)
	}

}



object niveles {

	var property listaNiveles = [ nivel1, nivel2, nivel5 ]

	method iniciar() {
		self.primerNivel().iniciar()
	}

	method primerNivel() = listaNiveles.first()
	
	method quedaUnNivel() = listaNiveles.size() == 1

	method siguienteNivel() {
		if (self.quedaUnNivel()) { 
			listaNiveles.remove(self.primerNivel())
		}
	}

	method pasarNivel() {
		nivel2.iniciar() // por ahora solo pasa al nivel dos habria que pensar otra manera
		picante.subirNivelPicante()
	}

}


object musica inherits Sound(file = "bgmusic.mp3"){}

object bienvenida{
	method iniciar(){
	game.addVisual(inicio)
	keyboard.space().onPressDo{nivel1.iniciar()}
		}
	}

object nivel1 {

	method iniciar() {
		musica.play()
		musica.shouldLoop(true)
		game.removeVisual(inicio)
		objetosPrincipales.mostrar()
		game.onTick(500, "car moving", { => auto.avanzarIzquierda()})
		game.onTick(1500, "bici moving", { => bici.avanzarIzquierda()})
		game.onTick(300, "bondi moving", { => bondi.avanzarDerecha()})
		config.configurarColisiones()
		game.say(estudiante, "ayudame a cruzar que llego tarde a pdep")
	}

}

object nivel2 {

	method iniciar() {
		game.onTick(300, "car moving", { => auto.avanzarIzquierda()})
		game.onTick(700, "bici moving", { => bici.avanzarIzquierda()})
		game.onTick(250, "bondi moving", { => bondi.avanzarDerecha()})
		config.configurarColisiones()
		game.say(estudiante, "ayudame a cruzar que llego tarde a pdep")
	}

}

object nivel5 {
	
	method iniciar() {
		game.onTick(120, "car moving", { => auto.avanzarIzquierda()})
		game.onTick(250, "bici moving", { => bici.avanzarIzquierda()})
		game.onTick(100, "bondi moving", { => bondi.avanzarDerecha()})
		config.configurarColisiones() //cambiar esto de lugar asi no repito tanto
	}
	
}

object config {

	method configurarColisiones() {
		game.whenCollideDo(auto, { character => character.chocadoPorAuto()})
		game.whenCollideDo(bondi, { character => character.chocadoPorBondi()})
		game.whenCollideDo(utn, { character => character.pasarDeNivel()})
		game.whenCollideDo(vidaExtra, { character => character.comerVida()})
	}

	method configurarTeclado() {
		keyboard.left().onPressDo{ estudiante.imagen("personajeIzquierda.png")}
		keyboard.right().onPressDo{ estudiante.imagen("personajeDerecha.png")}
		keyboard.up().onPressDo{ estudiante.imagen("personajeArriba.png")}
		keyboard.down().onPressDo{ estudiante.imagen("personajeAbajo.png")}
	}

}

