//
//  ContentView.swift
//  guessing_game
//
//  Created by shalinth adithyan on 21/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Spain","Ukraine","United Kingdom","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var scoreMessage = ""
    @State private var questionsCount = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var showingFinalScore = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [.init(color: .blue,location :0.3),
                                   .init(color: .black,location :0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        
                    }
                  
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score : \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
        }
        
            .alert(scoreTitle,isPresented: $showingScore){
                Button("Continue",action: askQuestion)
            }message:{
                Text("Your score is \(scoreMessage) ")
            }
            .alert("Game over ", isPresented: $showingFinalScore){
                Button("Restart ", action:resetGame)
            }message: {
                Text("Your final score is \(score)/8")
            }
        }
        func flagTapped(_ number:Int){
            questionsCount = questionsCount + 1
            if number == correctAnswer{
                scoreTitle = "Correct , "
                score = score + 1
                scoreMessage = "Thats the flag of \(countries[number])"
            }else{
                scoreTitle = "Wrong "
                scoreMessage = "Wrong! , Thats the color of \(countries[number])"
            }
            if questionsCount == 8{
                showingFinalScore = true
            }else {
                showingScore = true
            }
        }
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        func resetGame() {
        score = 0
        questionsCount = 0
        showingFinalScore = false
        askQuestion()
    }
    
        
    }
    


#Preview {
    ContentView()
}

