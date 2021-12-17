//
//  ContentView.swift
//  DiceGame
//
//  Created by Rai Gomes on 2021-12-14.
//

import SwiftUI

/******************
*
*   Skapa ett tärningsspel där man slår 2 tärningar. Efter valftritt antal
*   slag kan omgången avslutas och sparas hittilis uppnådda poäng.
*   Om poängen för en omgång överskired 21 blir istället pängen för den omgången 0
*
*   Målet är att uppnå 100p på så få omgångar som möjligt
*
**********************/

struct ContentView: View {
   @State var diceNumber1 = 3
   @State var diceNumber2 = 5
   @State var sum = 0
   @State var showingBustSheet = false
    
    var body: some View {
        ZStack {
            Color(red: 71 / 256, green: 110 / 256, blue: 99 / 256)
                .ignoresSafeArea()
        
        VStack {
        Text("\(sum)")
            .font(.title)
            .foregroundColor(.white)
            .fontWeight(.bold)
        Spacer()
        HStack {
            DiceView(n : diceNumber1)
            DiceView(n : diceNumber2)
        }
        .onAppear(perform: {newDiceValue()})
        Spacer()
        Button(action: {
              roll()
        }) {
            Text("Roll")
            .font(.largeTitle)
            .foregroundColor(Color.white)
            .padding(.horizontal)
        }
        .background(Color.red)
        .cornerRadius(15.0)
        Spacer()
    }
            
   }
        .sheet(isPresented: $showingBustSheet, onDismiss: {sum = 0} ) {
            BustSheet(sum : sum)
            
        }
        
  }
    
    func roll() {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
        
        sum += diceNumber1 + diceNumber2
        if sum > 21 {
            // Visa ny skärm
            showingBustSheet = true
            
        }
    
    }
    
    func newDiceValue () {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
    }
    
}
struct BustSheet : View {
    
    let sum : Int
    
    var body : some View {
        ZStack {
            Color(red: 71 / 256, green: 110 / 256, blue: 99 / 256)
                .ignoresSafeArea()
            VStack{
        Text("Bust")
            .foregroundColor(.white)
            .font(.title)
            .padding()
        Text("\(sum)")
            .foregroundColor(.red)
            .font(.title)
            .padding()
            }
            
            
        }
        
    }
    
}


struct DiceView : View {
    let n: Int
    
    var body : some View {
        
        Image("dice\(n)")
            .resizable()
            .scaledToFit()
            .padding()
            .frame(width: 120, height: 120)
            .fixedSize()
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BustSheet(sum: 35)
    }
}
