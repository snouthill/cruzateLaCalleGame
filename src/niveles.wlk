import extras.*
import wollok.game.*
import estudiante.*

object objetosPrincipales {

	method mostrar() {
		
		objetosMovimiento.generarAutos(2,0,2,"r",5)
		objetosMovimiento.generarAutos(3,8,1,"l",5)
		objetosMovimiento.generarAutos(4,4,1,"r",5)
		objetosMovimiento.generarAutos(5,4,1,"l",9)
		objetosMovimiento.generarAutos(6,7,1,"r",9)
		objetosMovimiento.generarAutos(7,11,2,"l",9)
		
		objetosMovimiento.generarBicis(9,0,2,"r",3)
		objetosMovimiento.generarBicis(10,3,2,"l",5)

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

	var property listaNiveles = [ nivelInicial, nivelIntermedio, nivelIntermedio, nivelIntermedio, nivelFinal ]

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
	keyboard.space().onPressDo{nivelInicial.iniciar()}
		}
	}

object objetosMovimiento {
	
	var property velocidadAuto = 1000
	var property velocidadBici = 800
	const bicis = []
	const autos = []
	
	method generarBicis(fila, columna, cantidad, direccion, separacion){
		const nuevasBicis = []
		var posicion = game.at(columna, fila)
		const colorRandom = [1, 2, 3].anyOne().toString()
		const sprite = "bici" + colorRandom + direccion + ".png"
		cantidad.times({ _ =>
			nuevasBicis.add(new Vehiculo(imagen = sprite, position = posicion, sentido = direccion))
			posicion = posicion.right(separacion)
		})
		nuevasBicis.forEach({bici => 
			game.addVisual(bici)
			if (direccion == "r") game.onTick(velocidadBici, "bici moving", { => bici.avanzarDerecha()})
			if (direccion == "l") game.onTick(velocidadBici, "bici moving", { => bici.avanzarIzquierda()})			
			game.whenCollideDo(bici, {character => character.volverAlInicio()})
			bicis.add(bici)
		})
	}
	
		method generarAutos(fila, columna, cantidad, direccion, separacion){
		const nuevosAutos = []
		var posicion = game.at(columna, fila)
		const colorRandom = [1, 2, 3, 4, 5].anyOne().toString()
		const sprite = "auto" + colorRandom + direccion + ".png"
		cantidad.times({ _ =>
			nuevosAutos.add(new Vehiculo(imagen = sprite, position = posicion, sentido = direccion))
			posicion = posicion.right(separacion)
		})
		nuevosAutos.forEach({auto => 
			game.addVisual(auto)
			if (direccion == "r") game.onTick(velocidadAuto, "auto moving", { => auto.avanzarDerecha()})
			if (direccion == "l") game.onTick(velocidadAuto, "auto moving", { => auto.avanzarIzquierda()})			
			game.whenCollideDo(auto, { character => character.chocadoPorAuto()})
			autos.add(auto)
		})
	}
	

	method comenzar() {
		
		bicis.forEach({bici => 
			if (bici.sentido() == "r") game.onTick(velocidadBici, "bici moving", { => bici.avanzarDerecha()})
			if (bici.sentido() == "l") game.onTick(velocidadBici, "bici moving", { => bici.avanzarIzquierda()})			
		})
		
		autos.forEach({auto => 
			if (auto.sentido() == "r") game.onTick(velocidadAuto, "auto moving", { => auto.avanzarDerecha()})
			if (auto.sentido() == "l") game.onTick(velocidadAuto, "auto moving", { => auto.avanzarIzquierda()})	
		})
	}
	method aumentarVelocidad() {
		velocidadAuto = velocidadAuto - 20
		velocidadBici = velocidadBici - 20	
	}
	method aumentarVelocidadLento() {
		velocidadAuto = velocidadAuto - 5
		velocidadBici = velocidadBici - 5
	}
}

object nivelInicial {

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

object nivelIntermedio {

	method iniciar() {
		objetosMovimiento.aumentarVelocidad()
		objetosMovimiento.comenzar()		
	}
}

object nivelFinal {
	
	method iniciar() {
		objetosMovimiento.aumentarVelocidadLento()
		objetosMovimiento.comenzar()
	}
	
}

object config {

	method configurarColisiones() {

		game.whenCollideDo(utn, { character => character.pasarDeNivel()})
		game.whenCollideDo(vidaExtra, { character => character.comerVida()})
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

