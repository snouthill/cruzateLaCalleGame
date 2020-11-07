import extras.*
import wollok.game.*
import estudiante.*

object parte1 {

	method iniciar() {
		game.addVisual(auto)
		game.addVisual(bici)
		game.addVisual(vidas)
		game.addVisual(bondi)
		game.addVisual(utn)
		game.addVisualCharacter(estudiante)
		game.onTick(500, "car moving", { => auto.avanzarIzquierda()})
		game.onTick(1500, "bici moving", { => bici.avanzarIzquierda()})
		game.onTick(300, "bondi moving", { => bondi.avanzarDerecha()})
		
		config.configurarColisiones()
		game.say(estudiante, "ayudame a cruzar que llego tarde a pdep")
		
		}

}

object config {
	
	method configurarColisiones(){
		game.whenCollideDo(auto, { character => character.chocadoPorAuto() })
		game.whenCollideDo(bondi, { character => character.chocadoPorBondi() })	
	}
	
	method configurarTeclado(){
		keyboard.left().onPressDo{estudiante.imagen("personajeIzquierda.png")}
		keyboard.right().onPressDo{estudiante.imagen("personajeDerecha.png")}
		keyboard.up().onPressDo{estudiante.imagen("personajeArriba.png")}
		keyboard.down().onPressDo{estudiante.imagen("personajeAbajo.png")}
	}
}
