//
//  MenuElement.swift
//  RestaurantApp
//
//  Created by Mateusz Kowalczyk on 28/01/2024.
//

import Foundation

class MenuElement: MenuItem {
    var id: UUID
    var cena: Double
    var nazwa: String
    var kategoria: MenuKategoria
    var zamowienia: Int
    var skladniki: [Skladniki]
    var obrazek: String
    
    init(id: UUID, cena: Double, nazwa: String, kategoria: MenuKategoria, zamowienia: Int, skladniki: [Skladniki], obrazek: String){
        self.id = id
        self.cena = cena
        self.nazwa = nazwa
        self.kategoria = kategoria
        self.zamowienia = zamowienia
        self.skladniki = skladniki
        self.obrazek = obrazek
    }
}

// Burgery:

let BurgerFreda = MenuElement(
    id: UUID(),
    cena: 25.99,
    nazwa: "Burger Freda",
    kategoria: .burgery,
    zamowienia: 0,
    skladniki:[.buła, .ser, .mięcho, .sosik, .pomidor, .pikle, .cebula, .sałata],
    obrazek: "fred_burger"
)
let SerBurger = MenuElement(
    id: UUID(),
    cena: 21.99,
    nazwa: "SerBurger",
    kategoria: .burgery,
    zamowienia: 0,
    skladniki:[.buła, .podwójny_ser, .mięcho, .sosik, .pomidor, .sałata],
    obrazek: "ser_burger"
    )
let BurgerDrwala = MenuElement(
    id: UUID(),
    cena: 23.99,
    nazwa: "MięsBurger",
    kategoria: .burgery,
    zamowienia: 0,
    skladniki:[.buła, .ser, .podwójne_mięcho, .sosik, .pomidor, .sałata],
    obrazek: "burger"
)

// VegZone:
let VegeBurger = MenuElement(
    id: UUID(),
    cena: 22.99,
    nazwa: "VegeBurger",
    kategoria: .vegeZone,
    zamowienia: 0,
    skladniki:[.buła, .ser, .falafel, .sosik, .pomidor, .sałata],
    obrazek: "vegeburger"
)
let Sałatka = MenuElement(
    id: UUID(),
    cena: 15.99,
    nazwa: "Sałatka",
    kategoria: .vegeZone,
    zamowienia: 0,
    skladniki:[.ser, .sosik, .pomidor, .sałata, .pikle, .cebula, .grzanki],
    obrazek: "salatka"
)

// Przekąski

let Frytki = MenuElement(
    id: UUID(),
    cena: 9.99,
    nazwa: "Frytki z ziemniaków",
    kategoria: .przekąski,
    zamowienia: 0,
    skladniki:[.ziemniak, .sól, .ketchup],
    obrazek: "frytki"
)

let Bataty = MenuElement(
    id: UUID(),
    cena: 12.99,
    nazwa: "Frytki z batatów",
    kategoria: .przekąski,
    zamowienia: 0,
    skladniki:[.batat, .sól, .ketchup],
    obrazek: "frytki_batat"
)

// Napoje

let Cola = MenuElement(
    id: UUID(),
    cena: 5.99,
    nazwa: "Coca Cola",
    kategoria: .napoje,
    zamowienia: 0,
    skladniki:[.cola],
    obrazek: "cola"
)

let Woda = MenuElement(
    id: UUID(),
    cena: 3.99,
    nazwa: "Woda",
    kategoria: .napoje,
    zamowienia: 0,
    skladniki:[.woda],
    obrazek: "woda"
)

let Tonic = MenuElement(
    id: UUID(),
    cena: 5.99,
    nazwa: "Tonic",
    kategoria: .napoje,
    zamowienia: 0,
    skladniki:[.tonic],
    obrazek: "tonic"
)

let Piwko = MenuElement(
    id: UUID(),
    cena: 7.99,
    nazwa: "Piwko",
    kategoria: .napoje,
    zamowienia: 0,
    skladniki:[.piwko],
    obrazek: "piwko"
)

// Lista menu

let menuElements: [MenuElement] = [BurgerFreda, BurgerDrwala, VegeBurger, SerBurger, Sałatka, Frytki, Bataty, Cola, Woda, Tonic, Piwko]

    


