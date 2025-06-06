//
//  ContentView.swift
//  35.MultiplicationTraining
//
//  Created by Валентин on 02.06.2025.
//

import SwiftUI

// Question.swift
struct Question {
    var firstMultiplier: Int
    var secondMultiplier: Int
    var answer: Int {
        return firstMultiplier * secondMultiplier
    }
    
    func getQuestion() -> String {
        return "Сколько будет \(firstMultiplier) * \(secondMultiplier)?"
    }
}

// SettingsView.swift
struct SettingsView: View {
    @Binding var firstMultiplier: Int
    @Binding var selectedQuestionsCount: Int
    var startGame: (Int, Int) -> Void
    
    var body: some View {
        VStack {
            Text("Тренировка умножения")
                .font(.title2)
            
            Spacer()
            Text("Как вы хотите играть?")
            Stepper("Первый множитель: \(firstMultiplier)", value: $firstMultiplier, in: 2...12)
            
            HStack {
                Text("Количество вопросов:")
                Spacer()
                Picker("Количество вопросов", selection: $selectedQuestionsCount) {
                    ForEach([5, 10, 20], id: \.self) { count in
                        Text("\(count)")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Button("Начать") {
                startGame(firstMultiplier, selectedQuestionsCount)
            }
            .padding(50)
            .background(.indigo)
            .foregroundStyle(.white)
            .clipShape(.circle)
        }
        .padding()
    }
}

// GameView.swift
struct GameView: View {
    @State private var currentQuestionIndex = 0
    @State private var correctAnswers = 0
    @State private var showAlert = false
    @State private var userAnswer: String = ""
    @State private var isGameOver = false
    @FocusState private var isTextFieldFocused: Bool  // Добавляем @FocusState
        
    var questions: [Question]
    var startOver: () -> Void
    
    var body: some View {
        VStack {
            if !isGameOver {
                Text("Тренировка таблицы умножения")
                    .font(.title2)
                Text(questions[currentQuestionIndex].getQuestion())
                    .font(.largeTitle)
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                
                TextField("Ответ", text: $userAnswer)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 60)
                    .padding()
                    .onChange(of: userAnswer) {
                        // Фильтруем ввод, оставляем только цифры
                        userAnswer = userAnswer.filter { "0123456789".contains($0) }
                    }
                    .onSubmit {
                        checkAnswer()
                    }
                    .focused($isTextFieldFocused)  // Добавляем фокус
                
                Button("Проверить") {
                    checkAnswer()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            } else {
                Text("Игра окончена!")
                    .font(.largeTitle)
            }
            
            Button("Заново") {
                startOver()
            }
            .padding()
            .background(.orange)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .onAppear{
            isTextFieldFocused = true
        }
        .alert("Результаты", isPresented: $showAlert) {
        } message: {
            Text("Вы ответили правильно на \(correctAnswers) из \(questions.count) вопросов")
        }
    }
    
    func checkAnswer() {
        guard let userAnswerInt = Int(userAnswer) else { return }
        let correct = userAnswerInt == questions[currentQuestionIndex].answer
        if correct {
            correctAnswers += 1
        }
        currentQuestionIndex += 1
        userAnswer = ""
        isTextFieldFocused = true  // Возвращаем фокус после проверки
                
        if currentQuestionIndex >= questions.count {
            isGameOver = true
            showAlert = true
        }
    }
}

// ContentView.swift
struct ContentView: View {
    @State private var firstMultiplier = 7
    @State private var selectedQuestionsCount = 5
    @State private var isGameActive = false
    @State private var gameQuestions: [Question] = []
    
    var body: some View {
        VStack {
            if isGameActive {
                GameView(questions: gameQuestions, startOver: {
                    isGameActive = false
                })
            } else {
                SettingsView(firstMultiplier: $firstMultiplier,
                            selectedQuestionsCount: $selectedQuestionsCount) { first, count in
                    isGameActive = true
                    gameQuestions = generateQuestions(firstMultiplier: first, count: count)
                 }
             }
         }
     }
                 
     func generateQuestions(firstMultiplier: Int, count: Int) -> [Question] {
         return (0..<count).map { _ in
             Question(firstMultiplier: firstMultiplier, secondMultiplier: Int.random(in: 2...12))
         }
     }
}

#Preview {
 ContentView()
}
