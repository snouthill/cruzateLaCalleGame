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
		game.addVisual(estudiante)
		game.addVisual(scoreIzq)
		game.addVisual(scoreDer)
		self.generarMuros()
		
		
		
		config.configurarColisiones()
	}
	method generarMuros(){
	const columnas = -1 .. 15
	const filas = 0 .. 13
	columnas.forEach({ columna => game.addVisual(new MuroInvisible(position = game.at(columna, -1)))})
    filas.forEach({ fila => game.addVisual(new MuroInvisible(position = game.at(-1, fila)))})
    filas.forEach({ fila => game.addVisual(new MuroInvisible(position = game.at(15, fila)))})
    
    // Hasta aca genere a los costados y abajo, ahora genero los bordes de la utn
    game.addVisual(new MuroInvisible(position = game.at(0,14)))
    game.addVisual(new MuroInvisible(position = game.at(1,14))) 
    game.addVisual(new MuroInvisible(position = game.at(1,13)))
    game.addVisual(new MuroInvisible(position = game.at(2,13)))
    game.addVisual(new MuroInvisible(position = game.at(3,13)))
    game.addVisual(new MuroInvisible(position = game.at(4,13)))
    game.addVisual(new MuroInvisible(position = game.at(5,13)))
    game.addVisual(new MuroInvisible(position = game.at(6,13)))
    game.addVisual(new MuroInvisible(position = game.at(7,13)))
    game.addVisual(new MuroInvisible(position = game.at(8,13)))
    game.addVisual(new MuroInvisible(position = game.at(9,13)))
    game.addVisual(new MuroInvisible(position = game.at(10,13)))
    game.addVisual(new MuroInvisible(position = game.at(11,13)))
    game.addVisual(new MuroInvisible(position = game.at(12,13)))
	game.addVisual(new MuroInvisible(position = game.at(13,13))) 
	game.addVisual(new MuroInvisible(position = game.at(13,14))) 
	game.addVisual(new MuroInvisible(position = game.at(14,14))) 
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
		if (!self.quedaUnNivel()) { 
			listaNiveles.remove(self.primerNivel())
		}
	}

	method pasarNivel() {
		self.siguienteNivel()
		self.primerNivel().iniciar() 
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
		game.say(estudiante, "ayudame a cruzar que llego tarde a pdep")
	}

}

object nivel2 {

	method iniciar() {
		game.onTick(300, "car moving", { => auto.avanzarIzquierda()})
		game.onTick(700, "bici moving", { => bici.avanzarIzquierda()})
		game.onTick(250, "bondi moving", { => bondi.avanzarDerecha()})
		game.say(estudiante, "ayudame a cruzar que llego tarde a pdep")
	}

}

object nivel5 {
	
	method iniciar() {
		game.onTick(50, "car moving", { => auto.avanzarIzquierda()})
		game.onTick(50, "bici moving", { => bici.avanzarIzquierda()})
		game.onTick(100, "bondi moving", { => bondi.avanzarDerecha()})
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
		keyboard.left().onPressDo{ estudiante.mover(estudiante.position().left(1), izquierda)}
		keyboard.right().onPressDo{ estudiante.mover(estudiante.position().right(1), derecha)}
		keyboard.up().onPressDo{ estudiante.mover(estudiante.position().up(1), arriba)}
		keyboard.down().onPressDo{ estudiante.mover(estudiante.position().down(1), abajo)}
	}

}

