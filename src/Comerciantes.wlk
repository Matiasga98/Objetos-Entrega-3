class Comerciante {
	var property artefactos = []
	var property tipoComerciante
	var property comision
	
	constructor (unosArtefactos, unTipo,unaComision){
		artefactos = unosArtefactos
		tipoComerciante = unTipo
		comision = unaComision
	}
	
	method impuesto(unPrecio){
		return tipoComerciante.recargo(unPrecio,comision)
	}
	method recategorizacionCompulsiva(){
		comision *= tipoComerciante.comisionNueva()
		tipoComerciante = tipoComerciante.recategorizacion(comision)
	}
}


object independiente{
	var property comisionNueva = 2
	
	method recategorizacion(comision){
		if (comision>0.21){
			return registrado
		}
		else {
			return self
		}
	}
	
	method recargo(unPrecio,comision) {
		return unPrecio*comision
	}
	
}

object registrado{
	var property comisionNueva = 1
	
	method recargo(unPrecio,comision){
		return unPrecio*0.21
	}
	
	method recategorizacion(comision){
	 	return  ganancias
	 }
}

object ganancias{
	var property comisionNueva = 1
	
	var property minimoNoImponible
	
	method recargo(unPrecio,comision){
		if (unPrecio < minimoNoImponible){
			return 0
		}
		else{
			return (unPrecio-minimoNoImponible)*0.35
		}
	}
	
	method recategorizacion(comision){
	 	return self
	 }
}


