import extras.*
import wollok.game.*
import estudiante.*

object parte1 {

	method iniciar() {
		game.addVisual(auto)
		game.onTick(500, "car moving", { => auto.avanzar()})
		game.onTick(1500, "bici moving", { => bici.avanzar()})
		game.addVisual(bici)
		game.addVisualCharacter(estudiante)
		game.say(estudiante, "ayudame a cruzar que llego tarde a pdep")
		}

}
