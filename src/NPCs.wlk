import hechiceriaRecargada.*


class NPC inherits Personaje {
	var property nivel
	constructor (unHechizoPreferido, unosArtefactos,unaCapacidad,unNivel) = super (unHechizoPreferido, unosArtefactos,unaCapacidad){
		nivel = unNivel
	}
	
	override method valorDeLucha(){
		return super() * nivel.multiplicadorNivel()
	}
}

object facil{
	const property multiplicadorNivel=1
}

object moderado{
	const property multiplicadorNivel=2
}
object dificil{
	const property multiplicadorNivel=4
}