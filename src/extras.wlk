import wollok.game.*
import estudiante.*

object auto {
	
	var property position = game.at(5, 2)

	method image() = "auto.png"
	
	method avanzar() {
		if(position.x() == 0){
			position = game.at(9, position.y())
		} else {
		position = position.left(1)
		}
	} 
}

object bici {
	
	var property position = game.at(9, 4)

	method image() = "bici.png"
	
	method avanzar() {
		if(position.x() == 0){
			position = game.at(9, position.y())
		} else {
		position = position.left(1)
		}
	} 
}


