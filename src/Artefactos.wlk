import hechiceriaRecargada.*

object fecha{
	var property fechaActual = new Date()
}

class Artefacto {
	var fechaDeCompra = new Date()
	var property peso
	
	constructor (unaFecha, unPeso) {
		fechaDeCompra = unaFecha
		peso = unPeso
	}
	
	method pesoBasico(){
		return  peso - 1.min((fecha.fechaActual() - fechaDeCompra)/1000)
	}
	
	method aporte()
	method pesoTotal() {
		return self.pesoBasico()
	}
}


class ArmaDelDestino inherits Artefacto{
	constructor(unaFecha, unPeso) = super (unaFecha,unPeso){}
	override method aporte(){
		return 3
	}
	
	method costo (){
		return 5*self.pesoTotal()
	}
}

class CollarDivino inherits Artefacto {
	
	var property perlas = 5
	
	constructor(unaFecha, unPeso) = super (unaFecha,unPeso){}
	
	override method aporte(){
		return perlas
	}
	
	method costo (){
		return 2*perlas
	}
	
	override method pesoTotal(){
		return self.pesoBasico() + perlas * 0.5
	}
}

class Mascara inherits Artefacto{
	var property indiceDeOscuridad
	var property minimo = 4
	
	constructor(unaFecha,unPeso,unIndiceDeOscuridad) = super(unaFecha,unPeso){
		indiceDeOscuridad = unIndiceDeOscuridad
	}
	
	override method aporte(){
		if(fuerzaOscura.valor()/2*indiceDeOscuridad>=minimo){
			return fuerzaOscura.valor()/2
		}
		else{
			return minimo
		}
	}
	
	override method pesoTotal(){
		return self.pesoBasico()+ 0.max(self.aporte()-3)
	}
	method costo() {
		return 10*indiceDeOscuridad
	}
	
}


class Armadura inherits Artefacto{
	var property duenio 
	var property refuerzo 
	var property base

	
	constructor (unRefuerzo, unaBase, unDuenio,unaFecha, unPeso) = super (unaFecha,unPeso) {
		refuerzo = unRefuerzo
		base = unaBase
		duenio = unDuenio
	}
	
	override method aporte(){
		return base + refuerzo.valor(duenio)
	}
	
	method costo (){
		return refuerzo.costo()
	}
	
	override method pesoTotal (){
		return self.pesoBasico() + refuerzo.pesoRefuerzo(duenio)
	}
}


class CotaDeMalla{
	var property unidadDeLucha
	constructor (unValor){
		unidadDeLucha = unValor
	}
	
	method valor(duenio) {
		return unidadDeLucha
	}
	method costo (){
		return unidadDeLucha/2
	}
	
	method pesoRefuerzo(duenio) {
		return 1
	}
}

object bendicion{
	var property perteneceA 
	method valor(duenio){
		return duenio.nivelDeHechiceria()
	}
	
	method costo (){
		return perteneceA.base()
	}
	
	method pesoRefuerzo(duenio) {
		return 0
	}
}


class Hechizo{			//creimos conveniente ponerlo como clase
	var property tipoDeHechizo
	var property perteneceA
	
	constructor (unHechizo){
		tipoDeHechizo = unHechizo
	}
	
	method valor(duenio){
		return tipoDeHechizo.poder()
	}	
	method costo (){
		return perteneceA.base()+tipoDeHechizo.costo()
	}
	
	method pesoRefuerzo(duenio) {
		if (self.valor(duenio).even()){
			return 2
		}
		else{
			return 1
		}
	}
	
}

object ninguno{
	method valor(duenio){
		return 0
	}
	method costo (){
		return 2
	}
	method pesoRefuerzo(duenio) {
		return 0
	}
}



class Espejo inherits Artefacto{
	var property duenio
	
	
	constructor (unDuenio, unaFecha, unPeso)= super (unaFecha,unPeso){
		duenio = unDuenio
	}
	
	override method aporte(){
		if(duenio.tieneSoloEspejos()){
			return 0
		}
		else{
			return duenio.maximoAporte()
		}
	}
	method costo (){
		return 90
	}
	
	override method pesoTotal() {
		return 0
	}
}
