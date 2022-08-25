import SwiftUI

struct ContentView: View {

    @State private var checkAmount = 0.0
    @FocusState private var amountIsFocused: Bool
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = Array(0..<101)
    let format = FloatingPointFormatStyle<Double>.Currency.currency(code: Locale.current.currencyCode ?? "EUR")
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: format)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("Tip percentage:")
                }
                Section {
                    Text(totalPerPerson, format: format)
                } header: {
                    Text("Ammount per person:")
                }
                Section {
                    Text(checkAmount + (checkAmount * (Double(tipPercentage) / 100)), format: format)
                } header: {
                    Text("Check and tips total:")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
