import wollok.game.*
import extras.*
import niveles.*


object estudiante {
	
	var orientacion = arriba
	var property position = game.at(7,1)
	var property image = orientacion.imagenDelPersonaje()
	var property puntaje = 0
	const fraseRandom = ["Dale que llego tarde :(", "Corre forest correee", "Kachow", "Velocidad es mi segundo nombre", "Esaaaa"]
	const fraseChoque = ["F", "Una pierna rota, se cursa igual", "Aprende a manejar pibe", "No pasa na, me cubre el seguro"]
	
	method hablar(frase){
		game.say(self, frase.anyOne().toString())
	}

	method mover( posicion, unaOrientacion ) {
	 	orientacion = unaOrientacion
	 	self.actualizarImagen(unaOrientacion.imagenDelPersonaje()) 
	 	if( self.puedeMoverAl( unaOrientacion )) { 
      		position = posicion
  		  } 
  	}
	method puedeMoverAl( unaOrientacion ) {
  		return game.getObjectsIn( unaOrientacion.posicionEnEsaDireccion() ).all { unObj => unObj.esAtravesable() }
	}
	
	method actualizarImagen(unaOrientacion){
	image = unaOrientacion
	}


	method chocadoPorAuto() {
		if(vidas.cantidad()>1){
		self.hablar(fraseChoque)
		self.volverAlInicio()
		image = "personajeArriba.png"
		vidas.perderVidas(1)
		}else config.gameOver()
	}
	
	method chocadoPorBondi() {
		if(vidas.cantidad()>2){
		self.volverAlInicio()
		self.hablar(fraseChoque)
		vidas.perderVidas(2)
		}else config.gameOver()
	}
	
	method volverAlInicio(){
		position = game.at(7,1)
		image = "personajeArriba.png"
	}
	
	method estaEnLaFacu() {
		return position == utn.position()
	}
	
	method comerVida() {
		if (vidas.cantidad() < vidas.maximo()){
		vidas.ganarVidas(1)
		vidaExtra.desaparecer()
		}
	}
	
	method pasarDeNivel() {
		puntaje += 1
		self.hablar(fraseRandom)
		scoreIzq.mostrar(puntaje)
		scoreDer.mostrar(puntaje)
		self.volverAlInicio()
		niveles.pasarNivel()
	}
	
}

object arriba {
  	method imagenDelPersonaje() = "personajeArriba.png"
	method posicionEnEsaDireccion() = estudiante.position().up(1)
}

object abajo {
	method imagenDelPersonaje() = "personajeAbajo.png"
  	method posicionEnEsaDireccion() = estudiante.position().down(1)
}

object izquierda {
	method imagenDelPersonaje() = "personajeIzquierda.png"
 	method posicionEnEsaDireccion() = estudiante.position().left(1)
}

object derecha {
	method imagenDelPersonaje() = "personajeDerecha.png"
  	method posicionEnEsaDireccion() = estudiante.position().right(1)
}

