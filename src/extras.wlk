import wollok.game.*

object auto {

	var property position = game.at(0, 0)

	method image() = "auto.jpg"
}

object bici {

	method image() = "bici.jpg"

	method position() = game.at(3, 3)
}
