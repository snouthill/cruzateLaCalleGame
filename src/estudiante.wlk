import wollok.game.*
import extras.*
import niveles.*


object estudiante {
	
	var property position = game.at(7,1)
	var property imagen = "personajeArriba.png"
	
	method image() = imagen

	 method mover( posicion, unaOrientacion ) { 
    if( self.puedeMoverAl( unaOrientacion )) { 
      position = posicion
    } 
  }
	method puedeMoverAl( unaOrientacion ) {
  return 
    game.getObjectsIn( unaOrientacion.posicionEnEsaDireccion() ).all { unObj => unObj.esAtravesable() }
}


	method chocadoPorAuto() {
		game.say(self, "aaaaaa")	
		self.volverAlInicio()
		imagen = "personajeArriba.png"
		vidas.perderVidas(1)
	}
	
	method chocadoPorBondi() {
		self.volverAlInicio()
		vidas.perderVidas(2)
	}
	
	method volverAlInicio(){
		position = game.at(7,1)
		imagen = "personajeArriba.png"
	}
	
	method estaEnLaFacu() {
		return position == utn.position()
	}
	
	method comerVida() {
		vidas.ganarVidas(1)
		game.removeVisual(vidaExtra)
	}
	
	method pasarDeNivel() {
		self.volverAlInicio()
		niveles.pasarNivel()
	}
	
}

object arriba {
  method posicionEnEsaDireccion() = estudiante.position().up(1)
}

object abajo {
  method posicionEnEsaDireccion() = estudiante.position().down(1)
}

object izquierda {
  method posicionEnEsaDireccion() = estudiante.position().left(1)
}

object derecha {
  method posicionEnEsaDireccion() = estudiante.position().right(1)
}
