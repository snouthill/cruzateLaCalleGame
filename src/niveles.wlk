import extras.*
import wollok.game.*
import estudiante.*

object objetosPrincipales {

	method mostrar() {
		
		objetosMovimiento.generarBicis(9,2,"r",2)
		
//		game.addVisual(biciDerecha1)
//		game.addVisual(biciDerecha2)
//		game.addVisual(biciDerecha3)
//		game.addVisual(biciIzquierda1)
//		game.addVisual(biciIzquierda2)
//		game.addVisual(biciIzquierda3)

//
//		game.addVisual(autoDerecha1)
//		game.addVisual(autoDerecha2)
//		game.addVisual(autoDerecha3)
//		game.addVisual(bondiDerecha4)		
//		game.addVisual(bondiDerecha5)		
//		game.addVisual(autoDerecha6)
//		game.addVisual(autoDerecha7)
//		game.addVisual(autoIzquierda1)
//		game.addVisual(autoIzquierda2)
//		game.addVisual(bondiIzquierda3)
//		game.addVisual(autoIzquierda4)
//		game.addVisual(bondiIzquierda5)
//		game.addVisual(autoIzquierda6)
//		game.addVisual(autoIzquierda7)
//		
		game.addVisual(vidas)
		game.addVisual(utn)
		game.addVisual(picante)
		game.addVisual(vidaExtra) 
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
	
		
	
	var property velocidadAuto = 1000
	var property velocidadBici = 600
	const bicis = []
	
	method generarBicis(fila, cantidad, direccion, separacion){
		
		var posicion = game.at(0, fila)
		const colorRandom = [1, 2, 3].anyOne().toString()
		const sprite = "bici" + colorRandom + direccion + ".png"
		cantidad.times({ _ =>
			bicis.add(new Vehiculo(imagen = sprite, position = posicion, sentido = direccion))
			posicion = posicion.right(separacion)
		})
		bicis.forEach({bici => 
			game.addVisual(bici)
			if (direccion == "r") game.onTick(velocidadBici, "bici moving", { => bici.avanzarDerecha()})
			if (direccion == "l") game.onTick(velocidadBici, "bici moving", { => bici.avanzarIzquierda()})			
			game.whenCollideDo(bici, {character => character.volverAlInicio()})
		})
	}

	method comenzar() {
		
		bicis.forEach({bici => 
			if (bici.sentido() == "r") game.onTick(velocidadBici, "bici moving", { => bici.avanzarDerecha()})
			if (bici.sentido() == "l") game.onTick(velocidadBici, "bici moving", { => bici.avanzarIzquierda()})			
			
		})
		
//		game.onTick(velocidadAuto, "car moving", { => autoDoble1.avanzarIzquierda()})
//		game.onTick(velocidadAuto, "car moving", { => autoDoble2.avanzarIzquierda()})
		
//		game.onTick(velocidadBici, "biciDerecha1 moving", { => biciDerecha1.avanzarDerecha()})
//		game.onTick(velocidadBici, "biciDerecha2 moving", { => biciDerecha2.avanzarDerecha()})
//		game.onTick(velocidadBici, "biciDerecha3 moving", { => biciDerecha3.avanzarDerecha()})
//		game.onTick(velocidadBici, "biciIzquierda1 moving", { => biciIzquierda1.avanzarIzquierda()})
//		game.onTick(velocidadBici, "biciIzquierda2 moving", { => biciIzquierda2.avanzarIzquierda()})
//		game.onTick(velocidadBici, "biciIzquierda3 moving", { => biciIzquierda3.avanzarIzquierda()})
//		
//		game.onTick(velocidadAuto, "autoDerecha1 moving", { => autoDerecha1.avanzarDerecha()})
//		game.onTick(velocidadAuto, "autoDerecha2 moving", { => autoDerecha2.avanzarDerecha()})
//		game.onTick(velocidadAuto, "autoDerecha3 moving", { => autoDerecha3.avanzarDerecha()})
//		game.onTick(velocidadAuto, "bondiDerecha4 moving", { => bondiDerecha4.avanzarDerecha()})
//		game.onTick(velocidadAuto, "bondiDerecha5 moving", { => bondiDerecha5.avanzarDerecha()})
//		game.onTick(velocidadAuto, "autoDerecha6 moving", { => autoDerecha6.avanzarDerecha()})
//		game.onTick(velocidadAuto, "autoDerecha7 moving", { => autoDerecha7.avanzarDerecha()})
//		
//		game.onTick(velocidadAuto, "autoIzquierda1 moving", { => autoIzquierda1.avanzarIzquierda()})
//		game.onTick(velocidadAuto, "autoIzquierda2 moving", { => autoIzquierda2.avanzarIzquierda()})
//		game.onTick(velocidadAuto, "bondiIzquierda3", { => bondiIzquierda3.avanzarIzquierda()})
//		game.onTick(velocidadAuto, "autoIzquierda4 moving", { => autoIzquierda4.avanzarIzquierda()})
//		game.onTick(velocidadAuto, "bondiIzquierda5 moving", { => bondiIzquierda5.avanzarIzquierda()})
//		game.onTick(velocidadAuto, "autoIzquierda6 moving", { => autoIzquierda6.avanzarIzquierda()})
//		game.onTick(velocidadAuto, "autoIzquierda7", { => autoIzquierda7.avanzarIzquierda()})
		
	
	}
	method aumentarVelocidad() {
		velocidadAuto = velocidadAuto - 220
		velocidadBici = velocidadBici - 220	
	}
	method aumentarVelocidadLento() {
		velocidadAuto = velocidadAuto - 225
		velocidadBici = velocidadBici - 225
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

		game.whenCollideDo(utn, { character => character.pasarDeNivel()})
		game.whenCollideDo(vidaExtra, { character => character.comerVida()})
//		game.whenCollideDo(biciDerecha1, { character => character.volverAlInicio()})
//		game.whenCollideDo(biciDerecha2, { character => character.volverAlInicio()})
//		game.whenCollideDo(biciDerecha3, { character => character.volverAlInicio()})
//		game.whenCollideDo(biciIzquierda1, { character => character.volverAlInicio()})
//		game.whenCollideDo(biciIzquierda2, { character => character.volverAlInicio()})
//		game.whenCollideDo(biciIzquierda3, { character => character.volverAlInicio()})
//		
//		game.whenCollideDo(autoDerecha1, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(autoDerecha2, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(autoDerecha3, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(bondiDerecha4, { character => character.chocadoPorBondi()})
//		game.whenCollideDo(bondiDerecha5, { character => character.chocadoPorBondi()})
//		game.whenCollideDo(autoDerecha6, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(autoDerecha7, { character => character.chocadoPorAuto()})
//		
//		game.whenCollideDo(autoIzquierda1, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(autoIzquierda2, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(bondiIzquierda3, { character => character.chocadoPorBondi()})
//		game.whenCollideDo(autoIzquierda4, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(bondiIzquierda5, { character => character.chocadoPorBondi()})
//		game.whenCollideDo(autoIzquierda6, { character => character.chocadoPorAuto()})
//		game.whenCollideDo(autoIzquierda7, { character => character.chocadoPorAuto()})
//		
//		
		
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

