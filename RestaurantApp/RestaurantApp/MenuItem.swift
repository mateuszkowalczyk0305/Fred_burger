//
//  MenuItem.swift
//  RestaurantApp
//
//  Created by Mateusz Kowalczyk on 28/01/2024.
//

import Foundation

protocol MenuItem {
    var id: UUID { get }
    var cena: Double { get }
    var nazwa: String { get }
    var kategoria: MenuKategoria { get }
    var zamowienia: Int{ get set }
    var skladniki: [Skladniki] { get set }
}
