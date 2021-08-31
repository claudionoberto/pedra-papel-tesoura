//
//  ContentView.swift
//  PPT
//
//  Created by Claudio Noberto  on 30/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["Pedra","Papel","Tesoura"].shuffled()
    var emojis = ["✊","🖐","✌️"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var winOrlose = Bool.random()
    @State private var round = 1
    @State private var win = 0
    @State private var lose = 0
    @State private var triggerAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.clear,.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){
                Text("Rodada \(round)")
                Spacer()
                Text(moves[appChoice])
                    .font(.largeTitle)
                
                if winOrlose {
                    Text("TENTE GANHAR")
                        .font(.footnote)
                } else {
                    Text("TENTE PERDER")
                        .font(.footnote)
                }
                Spacer()
                ForEach(0..<3) { number in
                    Button(action:{
                        action(number)
                    } ) {
                        Text(emojis[number])
                            .font(.system(size: 60))
                           
                        

                    }
                }
                  
                Spacer()
                    .alert(isPresented: $triggerAlert) {
                        Alert(title: Text("Fim de jogo!"),
                              message: Text("""
                              Acertos: \(win)
                              Erros: \(lose)
                              """), dismissButton: .default(Text("Nova Partida")) {
                                 reset()
                            })
                        
                    }
                
            }
        }
    }
    
    
    func action(_ number: Int){
        if winOrlose {
            switch emojis[number] {
            case emojis[0]:
                points("Tesoura")
            case emojis[1]:
                points("Pedra")
            default:
                points("Papel")
            }
          
            
        } else {
            switch emojis[number] {
            case emojis[0]:
                points("Papel")
            case emojis[1]:
                points("Tesoura")
            default:
                points("Pedra")
            }
            
        }
        moves.shuffle()
        appChoice = Int.random(in: 0...2)
        winOrlose = Bool.random()
        round += 1
        
        if round > 10 {
            round = 1
            triggerAlert = true
        }
            
    }
    
    func points(_ b: String){
        if (moves [appChoice] == b){
            win += 1
        } else {
            lose += 1
        }
        
    }
    
    func reset(){
        win = 0
        lose = 0
    }
}


    
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

