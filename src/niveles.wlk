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
		game.addVisualCharacter(estudiante)
	}
}

object nivel1 {

	method iniciar() {
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

object avanzar {
	method pasarNivel() {
		nivel2.iniciar() //por ahora solo pasa al nivel dos habria que pensar otra manera
		picante.subirNivelPicante()
	}
}

object config {
	
	method configurarColisiones(){
		game.whenCollideDo(auto, { character => character.chocadoPorAuto() })
		game.whenCollideDo(bondi, { character => character.chocadoPorBondi() })	
		game.whenCollideDo(utn, { character => character.pasarDeNivel() })
	}
	
	method configurarTeclado(){
		keyboard.left().onPressDo{estudiante.imagen("personajeIzquierda.png")}
		keyboard.right().onPressDo{estudiante.imagen("personajeDerecha.png")}
		keyboard.up().onPressDo{estudiante.imagen("personajeArriba.png")}
		keyboard.down().onPressDo{estudiante.imagen("personajeAbajo.png")}
	}
}
