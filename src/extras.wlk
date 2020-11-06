import wollok.game.*

object auto {

	var property position = game.at(0, 0)

	method image() = "auto.png"
	
}

object bici {

	method image() = "bici.png"

	method position() = game.at(3, 3)
}
