//
//  ContentView.swift
//  35.MultiplicationTraining
//
//  Created by Валентин on 02.06.2025.
//

import SwiftUI

struct Question {
    var firstMultiplier: Double
    var secondMultiplier: Double
    var answer: Double {
        return firstMultiplier * secondMultiplier
    }
    
    func getQuestion() -> String {
        return "Сколько будет \(firstMultiplier) * \(secondMultiplier)?"
    }
}

struct ContentView: View {
    @State private var firstMultiplier = 7.0             //1 множитель
    private var questionsCount = [5, 10, 20]            //количество вопросов
    @State private var selectedQuestionsCount = 5       //выбранное количество вопросов
    @State private var secondMultiplier = [Double]()    //2 множитель
    @State private var questions = [Question]()
    
    @State private var animationAmount = 0.0    //угол поворота кнопки (для анимации)
    @State private var gameStarted = false      //флаг "игра начата"
    
    var body: some View {
        VStack {
            Text("Тренировка таблицы умножения")
                .font(.title)
            Spacer()
            
            //Text("\(firstMuliplier.formatted())")
            //    .font(.headline)
            Stepper("Первый множитель:          \(firstMultiplier.formatted())", value: $firstMultiplier, in: 2...12)
            
            HStack {
                Text("Количество вопросов:")
                Spacer()
                Picker("Количество вопросов", selection: $selectedQuestionsCount) {
                    ForEach(questionsCount, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            .pickerStyle(.segmented)
            
            Spacer()
            
            Button("Начать") {
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmount += 360
                }
                generateQuestions()
            }
            .padding(50)
            .background(.indigo)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
        }
        .padding()
    }
    
    //генерируем новые вопросы:
    func generateQuestions() {
        
        if questions.isEmpty {
            for i in 0...19 {
                //secondMultiplier.append(Double(Int.random(in: 2...12)))
                questions.append(Question(firstMultiplier: firstMultiplier, secondMultiplier: Double(Int.random(in: 2...12)) ))
                print("secondMultiplier[\(i)] = \(questions[i].secondMultiplier)")
            }
        } else {
            questions.shuffle()
            print("secondMultiplier = \(questions)")
        }

        //запускаем таймер на 1 секунду
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
        }
    }
    
}

#Preview {
    ContentView()
}
