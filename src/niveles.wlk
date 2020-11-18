import extras.*
import wollok.game.*
import estudiante.*

object objetosPrincipales {

	method mostrar() {
		game.addVisual(auto)
		game.addVisual(autoDoble1)
		game.addVisual(autoDoble2)
		game.addVisual(bici)
		game.addVisual(vidas)
		game.addVisual(bondi)
		game.addVisual(bondi2)
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

	var property listaNiveles = [ nivel1, nivel2, nivel3, nivel4, nivel5 ]

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
object musicaEnding inherits Sound(file = "endmusic.mp3"){}

object bienvenida{
	method iniciar(){
	game.addVisual(inicio)
	keyboard.space().onPressDo{nivel1.iniciar()}
		}
	}

object objetosMovimiento {
	
	var property velocidadAuto = 500
	var property velocidadBici = 400
	var property velocidadBondi = 700
	
	method comenzar() {
		game.onTick(velocidadAuto, "car moving", { => auto.avanzarIzquierda()})
		game.onTick(velocidadAuto, "car moving", { => autoDoble1.avanzarIzquierda()})
		game.onTick(velocidadAuto, "car moving", { => autoDoble2.avanzarIzquierda()})
		game.onTick(velocidadBici, "bici moving", { => bici.avanzarIzquierda()})
		game.onTick(velocidadBondi, "bondi moving", { => bondi.avanzarDerecha()})	
		game.onTick(velocidadBondi, "bondi moving", { => bondi2.avanzarDerecha()})	
	}
	method aumentarVelocidad() {
		velocidadAuto = velocidadAuto - 50
		velocidadBici = velocidadBici - 50
		velocidadBondi = velocidadBondi - 50
	}
	method aumentarVelocidadLento() {
		velocidadAuto = velocidadAuto - 5
		velocidadBici = velocidadBici - 5
		velocidadBondi = velocidadBondi - 5
	}
}

object nivel1 {

	method iniciar() {
		musica.play()
		musica.shouldLoop(true)
		game.removeVisual(inicio)
		objetosPrincipales.mostrar()
		objetosMovimiento.comenzar()	
		game.onTick(10000, "mostrarVidaExtra", { => vidaExtra.spawn()})
		game.say(estudiante, "Dale que llego tarde a cursar :(")
	}

}

object nivel2 {

	method iniciar() {
		objetosMovimiento.aumentarVelocidad()
		objetosMovimiento.comenzar()
		
	}

}

object nivel3 {

	method iniciar() {
		objetosMovimiento.aumentarVelocidad()
		objetosMovimiento.comenzar()
		bondi2.position(game.at(8,5)) 
	}

}

object nivel4 {

	method iniciar() {
		objetosMovimiento.aumentarVelocidad()
		objetosMovimiento.comenzar()
		//aca podemos agregar otro vehiculo
	}

}

object nivel5 {
	
	method iniciar() {
		objetosMovimiento.aumentarVelocidadLento()
		objetosMovimiento.comenzar()
	}
	
}

object config {

	method configurarColisiones() {
		game.whenCollideDo(auto, { character => character.chocadoPorAuto()})
		game.whenCollideDo(autoDoble1, { character => character.chocadoPorAuto()})
		game.whenCollideDo(autoDoble2, { character => character.chocadoPorAuto()})
		game.whenCollideDo(bondi, { character => character.chocadoPorBondi()})
		game.whenCollideDo(bondi2, { character => character.chocadoPorBondi()})
		game.whenCollideDo(utn, { character => character.pasarDeNivel()})
		game.whenCollideDo(vidaExtra, { character => character.comerVida()})
		game.whenCollideDo(bici, { character => character.volverAlInicio()})
		
	}

	method configurarTeclado() {
		keyboard.left().onPressDo{ estudiante.mover(estudiante.position().left(1), izquierda)}
		keyboard.right().onPressDo{ estudiante.mover(estudiante.position().right(1), derecha)}
		keyboard.up().onPressDo{ estudiante.mover(estudiante.position().up(1), arriba)}
		keyboard.down().onPressDo{ estudiante.mover(estudiante.position().down(1), abajo)}

	}

	method gameOver(){
		musica.stop()
		game.clear()
		musicaEnding.play()
		musicaEnding.shouldLoop(false)
		game.addVisual(final)
		scoreIzq.scoreFinal()
		scoreDer.scoreFinal()
		keyboard.f().onPressDo{game.stop()}
			
	}
}

