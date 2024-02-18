//
//  ContentView.swift
//  RestaurantApp
//
//  Created by Mateusz Kowalczyk on 28/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var wybraneDania: [String : Bool] = [:]
    @State private var zamowieniaBurgery: Int = 0
    @State private var zamowieniaVegeZone: Int = 0
    @State private var zamowieniaPrzekaski: Int = 0
    @State private var zamowieniaNapoje: Int = 0
    var body: some View {
        TabView{ // ten dolny pasek to jest
            MenuView(
                wybraneDania: $wybraneDania,
                zamowieniaBurgery: $zamowieniaBurgery,
                zamowieniaVegeZone: $zamowieniaVegeZone,
                zamowieniaPrzekaski: $zamowieniaPrzekaski,
                zamowieniaNapoje: $zamowieniaNapoje
            )
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Menu")
                }
            KategorieView()
                .tabItem{
                    Image(systemName: "info.circle")
                    Text("O nas")
                }
            TwojaRestView(
                wybraneDania: $wybraneDania,
                zamowieniaBurgery: $zamowieniaBurgery,
                zamowieniaVegeZone: $zamowieniaVegeZone,
                zamowieniaPrzekaski: $zamowieniaPrzekaski,
                zamowieniaNapoje: $zamowieniaNapoje
            )
                .tabItem{
                    Image(systemName: "chart.bar")
                    Text("Twoja Restauracja")
                }
        }
    }
}

struct MenuView: View {
    @Binding var wybraneDania: [String: Bool]
    @Binding var zamowieniaBurgery: Int
    @Binding var zamowieniaVegeZone: Int
    @Binding var zamowieniaPrzekaski: Int
    @Binding var zamowieniaNapoje: Int
    
    func policzKosztCalkowity() -> Double? {
        let selectedElements = menuElements.filter { wybraneDania[$0.nazwa] ?? false }
        return selectedElements.reduce(0) { $0 + $1.cena } //zwraca sume cen  wybranych dań
    }
    
    // funkcja do aktualizacji zamówień (statystyki) [dodałem tu, a nie w osobnym pliku bo były błędy  z brakiem możliwości znalezienia zmiennej wybraneDania]
    func updateZamowienia(
        zamowieniaBurgery: inout Int,
        zamowieniaVegeZone: inout Int,
        zamowieniaPrzekaski: inout Int,
        zamowieniaNapoje: inout Int
    ){
        for selectedElement in menuElements {
            if wybraneDania[selectedElement.nazwa] ?? false { // sprawdza czy danie jest wybrane jesli nie to daje mu false
                switch selectedElement.kategoria {
                case .burgery:
                    zamowieniaBurgery += 1
                case .vegeZone:
                    zamowieniaVegeZone += 1
                case .przekąski:
                    zamowieniaPrzekaski += 1
                case .napoje:
                    zamowieniaNapoje += 1
                }
            }
        }
        wybraneDania = [:] // do przechowania info o ilości zamówianych dań w kategoriach poszczególnych
    }

    var body: some View {
        VStack {
        Image("logo.fred.burger")
            .resizable(resizingMode:.stretch)
            .frame(width: 250, height: 125)
            .padding(.top, 5)
        Text("Menu")
            .font(.headline)
            .fontWeight(.bold)
            .padding(.top, 5)
            List {
                ForEach(menuElements, id: \.id) { element in
                    HStack{
                        Image(element.obrazek)
                            .resizable()
                            .frame(width: 75, height: 75)
                        VStack(alignment: .leading){
                        Text(element.nazwa)
                            .font(.subheadline)
                            .lineLimit(1) // tekst tylko w jednej linii.
                            .truncationMode(.tail) // dodaje na końcu "..." jak się nie mieści.
                            
                            Text(String(format: "Cena: %.2f zł", element.cena))
                                .font(.caption)
                                .foregroundColor(.gray)
                    }
                        Spacer()
                        Toggle("", isOn: Binding(
                               get: {wybraneDania[element.nazwa] ?? false },
                               set: {wybraneDania[element.nazwa] = $0}
                               ))
                        .padding(.trailing, 10)
                    }
                    Text("Składniki: \(element.skladniki.map { $0.rawValue }.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
                }
            Section(header: Text("Podsumowanie")) {
                ForEach(Array(menuElements.filter { wybraneDania[$0.nazwa] ?? false }), id: \.id) { selectedElement in
                    HStack {
                        Text(selectedElement.nazwa)
                        Spacer()
                        Text(String(format: "%.2f zł", selectedElement.cena))
                    }
                }
                if let kosztCalkowity = policzKosztCalkowity(){
                    HStack{
                        Text("Suma: ")
                            .font(.headline)
                            .fontWeight(.bold)
                            
                        Spacer()
                        Text(String(format: "%.2f zł", kosztCalkowity))
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    Button("Zamów") {
                        updateZamowienia(
                            zamowieniaBurgery: &zamowieniaBurgery, // tu już nie $ bo przekazujemy referencje a nie jej wartośc
                            zamowieniaVegeZone: &zamowieniaVegeZone,
                            zamowieniaPrzekaski: &zamowieniaPrzekaski,
                            zamowieniaNapoje: &zamowieniaNapoje
                        )
                        wybraneDania = [:]
                    }
                    .padding(8)
                    .background(Color(red: 0, green: 0.45, blue: 0.5))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 5)
                    
                }
            }
            }
            .padding(.top, 10)
        }

    }

struct KategorieView: View{
    var body: some View{
        VStack{
        Image("logo.fred.burger")
            .resizable(resizingMode:.stretch)
            .frame(width: 250, height: 125)
            .padding(.top, 5)
        Spacer()
        Text("O nas")
            .font(.largeTitle)
            .foregroundColor(Color(red: 0, green: 0.45, blue: 0.5))
            .padding(.top, 5)
        Spacer()
            Text("Burgerownia Fred Burger to niepowtarzalne miejsce, gdzie smaki spotykają się z kreatywnością. Nasza pasja do przygotowywania wyjątkowych burgerów łączy się z troską o najwyższą jakość składników. Dajemy Ci niezapomniane doznania kulinarne, serwując kompozycje smakowe, które podkreślają unikalny charakter naszych dań. Odkryj niezwykłe kombinacje i delektuj się wyjątkowym klimatem Fred Burger!")
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }/// mi się wydaję, że najlepiej będzie tutaj dać ewnetualne jakieś kategorie oraz opis restauracji. Ewentualnie dodać tutaj testy jednostkowe.
    }
        
}

struct TwojaRestView: View{
    @Binding var wybraneDania: [String: Bool]
    @Binding var zamowieniaBurgery: Int
    @Binding var zamowieniaVegeZone: Int
    @Binding var zamowieniaPrzekaski: Int
    @Binding var zamowieniaNapoje: Int
    
    var body: some View{
        VStack{
            Section (header: Text("Statystyki").font(.largeTitle).foregroundColor(Color(red: 0, green: 0.45, blue: 0.5))){
            
            HStack {
                Text("Zamowione Burgery: ")
                Spacer()
                Text("\(zamowieniaBurgery)")
            }
            HStack {
                Text("Zamowione Vege: ")
                Spacer()
                Text("\(zamowieniaVegeZone)")
            }
            HStack {
                Text("Zamowione Przekąski: ")
                Spacer()
                Text("\(zamowieniaPrzekaski)")
            }
            HStack {
                Text("Zamowione Napoje: ")
                Spacer()
                Text("\(zamowieniaNapoje)")
            }
        
        }
        }.padding(.top, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



