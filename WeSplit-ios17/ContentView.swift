//
//  ContentView.swift
//  WeSplit
//
//  Created by Alin RADU on 21.01.2024.
//

// First, import SwiftUI tells Swift that we want to use all the functionality given to us by the SwiftUI framework. Apple provides us with many frameworks for things like machine learning, audio playback, image processing, and more, so rather than assume our program wants to use everything ever we instead say which parts we want to use so they can be loaded.

// Second, struct ContentView: View creates a new struct called ContentView, saying that it conforms to the View protocol. View comes from SwiftUI, and is the basic protocol that must be adopted by anything you want to draw on the screen – all text, buttons, images, and more are all views, including your own layouts that combine other views.

// Third, var body: some View defines a new computed property called body, which has an interesting type: some View. This means it will return something that conforms to the View protocol, which is our layout. Behind the scenes this will actually result in a very complicated data type being returned based on all the things in our layout, but some View means we don’t need to worry about that.

// The View protocol has only one requirement, which is that you have a computed property called body that returns some View. You can (and will) add more properties and methods to your view structs, but body is the only thing that’s required.

// Fourth, VStack and the code inside it shows a globe image with the text "Hello, world!" below it. That globe image comes from Apple's SF Symbols icon set, and there are thousands of these icons built right into iOS. Text views are simple pieces of static text that get drawn onto the screen, and will automatically wrap across multiple lines as needed.

// Fifth, imageScale(), foregroundStyle(), and padding() are methods being called on the image and VStack. This is what SwiftUI calls a modifier, which are regular methods with one small difference: they always return a new view that contains both your original data, plus the extra modification you asked for. In our case that means the globe image will be shown larger and in blue, and the whole body property will return a padded text view, not just a regular text view.

// Below the ContentView struct you’ll see #Preview with ContentView() inside. This is a special piece of code that won’t actually form part of your final app that goes to the App Store, but is instead specifically for Xcode to use so it can show a preview of your UI design alongside your code.

// @State allows us to work around the limitation of structs: we know we can’t change their properties because structs are fixed, but @State allows that value to be stored separately by SwiftUI in a place that can be modified.

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 20, 25, 0]
    
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal  / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code:
                        Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<99){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code:
                                                            Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

