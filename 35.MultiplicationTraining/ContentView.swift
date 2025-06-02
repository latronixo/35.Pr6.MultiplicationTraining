//
//  ContentView.swift
//  35.MultiplicationTraining
//
//  Created by Валентин on 02.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var firstMuliplier = 2.0     //1 множитель
    private var questionsCount = [5, 10, 20]    //количество вопросов
    @State private var selectedQuestionsCount = 5   //выбранное количество вопросов
    @State private var secondMultiplier = [Double]()    //
    
    @State private var animationAmount = 0.0    //угол поворота кнопки (для анимации)

    var body: some View {
        VStack {
            Text("Тренировка таблицы умножения")
                .font(.title)
            Spacer()
            
            Text("\(firstMuliplier.formatted())")
                .font(.headline)
            Stepper("Выберите первый множитель", value: $firstMuliplier, in: 2...13)
            
            HStack {
                Text("Количество вопросов:")
                Spacer()
                Picker("Количество вопросов", selection: $selectedQuestionsCount) {
                    ForEach(questionsCount, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
            .pickerStyle(.menu)
            
            Spacer()

            Button("Начать") {
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
        }
        .padding()
    }
    
    func generateQuestions() {
        //запускаем алерт на 2 секунды
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
        
            
            
        }
    }
}

#Preview {
    ContentView()
}
