import wollok.game.*
import extras.*
import niveles.*


object estudiante {
	
	var orientacion = arriba
	var property position = game.at(7,1)
	var property image = orientacion.imagenDelPersonaje()
	var property puntaje = 0
	
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
		game.say(self, "aaaaaa")	
		self.volverAlInicio()
		image = "personajeArriba.png"
		vidas.perderVidas(1)
	}
	
	method chocadoPorBondi() {
		self.volverAlInicio()
		vidas.perderVidas(2)
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
		game.removeVisual(vidaExtra)
		}
	}
	
	method pasarDeNivel() {
		puntaje += 1
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
