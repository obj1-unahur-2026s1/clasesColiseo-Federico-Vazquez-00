class ArmaDeFilo{
  const filo
  const longitud

  method ataque(){
    return filo * longitud
  }
}

class ArmaContundente{
  const peso

  method ataque(){
    return peso
  }
}

object casco{
  method defensa(gladiador) = 10
}

object escudo{
  method defensa(gladiador){
    return 5 + (gladiador.destreza() * 0.1)
  }
}

class Gladiador{
  var vida = 100
  method vida() = vida
  method destreza()
  method defensa()
  method poderAtaque()
  method crearGrupoCon(unGladiador)

  method atacar(unGladiador){
    const daño = self.poderAtaque() - unGladiador.defensa()
    unGladiador.perderVida()
  }

  method perderVida(cantidad){
    vida -= cantidad
  }

  method pelearCon(unGladiador){
    self.atacar(unGladiador)
    unGladiador.atacar(self)
  }

  method curar(){
    vida = 100
  }
}

class Mirmillon inherits Gladiador{
  var arma
  var armadura
  var property fuerza
  
  override method destreza() = 15

  method cambiarArma(unArma){
    arma = unArma
  }

  method cambiarArmadura(unaArmadura){
    armadura = unaArmadura
  }

  override method defensa(){
    return armadura.defensa(self) + self.destreza()
  }

  override method poderAtaque(){
    return fuerza + arma.ataque()
  }

  // override method crearGrupoCon(otroGladiador){
  //  const nuevoGrupo = new Grupo(nombre = "Mirmillolandia")
  //  nuevoGrupo.agregar(self)
  //  nuevoGrupo.agregar(otroGladiador)
  //  return nuevoGrupo
  //}

  override method crearGrupoCon(otroGladiador){
    return new Grupo(
      nombre = "Mirmillolandia", 
      miembros = #(self, otroGladiador))
  }
}

class Dimachaerus inherits Gladiador{
  const armas = []
  method fuerza() = 10
  var destreza

  method agregar(unArma){
    armas.add(unArma)
  }

  method quitar(unArma){
    armas.remove(unArma)
  }

  override method defensa(){
    destreza / 2
  }

  override method poderAtaque(){
    self.fuerza() + armas.ataque()
  }

  override method atacar(unGladiador){
    super(unGladiador)
    destreza += 1
  }

  override method crearGrupoCon(otroGladiador){
    return new Grupo(
      nombre = "D-" + (self.poderAtaque() + otroGladiador.poderAtaque()).toString(), 
      miembros = #(self, otroGladiador))
  }
}

class Grupo{
  const nombre
  const miembros = #{}
  var cantPeleas = 0

  method agregar(unGladiador){
    miembros.add(unGladiador)
  }

  method quitar(unGladiador){
    miembros.remove(unGladiador)
  }

  method puedeCombatir(){
    return miembros.filter({g => g.vida() > 0})
  }

  method campeon(){
    return self.puedeCombatir().max()({g => g.poderAtaque()})
  }

  method combatirCon(otroGrupo){
    self.campeon().pelearCon(otroGrupo.campeon())
    self.campeon().pelearCon(otroGrupo.campeon())
    self.campeon().pelearCon(otroGrupo.campeon())
    cantPeleas += 3
  }
}

object coliseo{
  method combatirGrupos(grupo1, grupo2){
    grupo1.combatirCon(grupo2)
  }

  method combatirContraCampeon(grupo1, unCampeon){
    grupo1.miembros().forEach({g => g.pelearCon(unCampeon)})
  }

  method curarGrupo(unGrupo){
    unGrupo.miembros().forEach({g => g.curar()})
  }

  method curarGladiador(unGladiador){
    unGladiador.curar()
  }
}