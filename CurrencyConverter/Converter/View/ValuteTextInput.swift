import SwiftUI

struct ValuteTextInput: View {
    
    @Binding var value: String
    
    
    var body: some View {
        TextField("Введите количество валюты", text: $value)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 200, height: 100)
    }
    
}

