import SwiftUI

struct ValutePicker: View {
    
    var valutes = ["Валюта", "AUD", "BGN", "USD", "RUB", "EUR", "PLN", "CZK", "TJS", "TRY", "TMT", "UZS"]
    @Binding var selected: String
    
    func getSelected() -> String {
        return self.selected
    }
    
    var body: some View {
        VStack {
            Picker(selection: $selected, label: Text("валюта"), content: {
                ForEach(valutes, id: \.self) { valute in
                    Text(valute).tag(valute).foregroundColor(.black)
                }
            }).pickerStyle(MenuPickerStyle())
        }
    }
}
