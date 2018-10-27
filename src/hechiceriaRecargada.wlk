import Artefactos.*



class Personaje {
	
	
	const property valorBaseHechiceria = 3
	var property hechizoPreferido 
	var property valorBaseLucha = 1 // 
	var property artefactos = []
	var property monedas = 100
	const property capacidadCarga
		
	constructor(unHechizoPreferido, unosArtefactos,unaCapacidad){
		hechizoPreferido  = unHechizoPreferido
		artefactos = unosArtefactos
		capacidadCarga = unaCapacidad
	}	
		
		
	method nivelDeHechiceria(){
		return valorBaseHechiceria*hechizoPreferido.poder()+fuerzaOscura.valor()
	}
	
	method seCreePoderoso() = hechizoPreferido.poderoso()
	
	method agregarArtefacto(unArtefacto){
		artefactos.add(unArtefacto)
	}
	
	method removerArtefacto(unArtefacto){
		artefactos.remove(unArtefacto)
	}
	
	method valorDeLucha(){
		return valorBaseLucha + self.aporteDeArtefactos()
	}
	
	method aporteDeArtefactos(){
		return artefactos.map({artefacto => artefacto.aporte()}).sum()
	}
	
	method mayorLuchaQueHechiceria() = self.valorDeLucha() > self.nivelDeHechiceria()
	
	method tieneSoloEspejos() = self.removerEspejos().isEmpty()
	
	method removerEspejos(){
			return artefactos.filter({artefacto => artefacto.className() !="luchaYhechiceriaPlus.Espejo"})
	}
	
	method maximoAporte(){
		return self.removerEspejos().map({artefacto => artefacto.aporte()}).max()
	}
	
	method estaCargado() = artefactos.size() >= 5
	
	method canjearHechizo(hechizoAComprar){
		if (monedas + hechizoPreferido.costo()/2 < hechizoAComprar.costo()){
			self.error("no alcanzan las monedas")		
		}
		monedas -= (hechizoAComprar.costo()-hechizoPreferido.costo()/2).max(0) 
		hechizoPreferido = hechizoAComprar
	}
	
	method pesoTotalArtefactos(){
		return artefactos.sum({artefacto => artefacto.pesoTotal()})
	}
	
	method comprarArtefacto (artefactoAComprar, unComerciante){
		if (!unComerciante.artefactos().contains(artefactoAComprar)){
			self.error("el comerciante no tiene el artefacto")
		}
		if (monedas < artefactoAComprar.costo() + unComerciante.impuesto(artefactoAComprar.costo())){
			self.error("no alcanzan las monedas")
		}
		if (self.pesoTotalArtefactos()+artefactoAComprar.pesoTotal()>capacidadCarga){
			self.error("no puede cargar con ese objeto")
		}
		monedas -= (artefactoAComprar.costo() + unComerciante.impuesto(artefactoAComprar.costo())) 
		self.agregarArtefacto(artefactoAComprar)
				
	}
	
	method cumplirObjetivo (){
		monedas +=10
	}
	
}

class Logos {
	
	var property nombre
	var property poderDeHechiceria
	
	constructor(unNombre, unPoder){
		nombre = unNombre
		poderDeHechiceria = unPoder
	}
	
	method poder(){
		return poderDeHechiceria*nombre.size()
	}
	
	method poderoso() = self.poder()>15
	method costo(){
		return self.poder()
	}
}



object hechizoIneficiente{
	method poder(){
		return 0
	}
	method poderoso() = false
}
object hechizoBasico{
	
	method poder(){  
		return 10    
	}
	
	method poderoso() = false
	method costo (){
		return 10
	}
	

	
}

object fuerzaOscura{
	var property valor = 5
	
	method duplicarValor(){
		valor = valor*2
	}
}

object eclipse{
	method eclipsar(){
		fuerzaOscura.duplicarValor()
	}
}

//parte 3 a partir de aca

class LibroDeHechizos {
	var property hechizos
	
	constructor (unosHechizos) {
		hechizos = unosHechizos
	}
	
	method poder(){
		return self.aporteTotalHechizosPoderosos()
	}
	
	method aporteTotalHechizosPoderosos(){
		return self.hechizosPoderosos().map({hechizo => hechizo.poder()}).sum()
	}
	
	method hechizosPoderosos(){
		return hechizos.filter({hechizo => hechizo.poderoso()})
	}
	method costo (){
		return 10*hechizos.size()+self.aporteTotalHechizosPoderosos()
	}
}




class HechizoComercial {
	
	var property nombre
	var property porcentaje
	var property multiplicador
	
	constructor(unNombre, unPorcentaje, unMultiplicador){
		nombre = unNombre
		porcentaje = unPorcentaje
		multiplicador = unMultiplicador
	}
	
	method poder(){
		return porcentaje/100*nombre.size()*multiplicador
	}
	
	method poderoso() = self.poder()>15
	method costo(){
		return self.poder()
	}
}




