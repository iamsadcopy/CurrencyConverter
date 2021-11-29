import SwiftUI

struct Converter: View {
    @State var money = ""
    @State var baseValue = "Валюта"
    @State var convertValue = "Валюта"
    @State var finalValue = "Итог"
    @State var valueCount = ""
    @State var data: CurrencyModel?
    
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                ValutePicker(selected: $baseValue).padding()
                ValutePicker(selected: $convertValue).padding()
            }
            
            ValuteTextInput(value: $valueCount)
            
            Button(action: { CurrencyApi().getCurrency { (currency) in
                self.data = currency
            }
                self.finalValue = getFinalValue(base: baseValue, convertTo: convertValue, count: valueCount)!
            }) {
                Text("конвертировать").padding().foregroundColor(.black)
            }
            
            Text(finalValue)
            Spacer()
        }.navigationBarTitle("Конвертор валют")
            .font(.custom("Helvetica Neue", size: 20))
            .onAppear() {
                CurrencyApi().getCurrency { (currency) in
                    self.data = currency
                }
            }
            }
        
        
        
    func getFinalValue(base first:String, convertTo second:String, count count: String) -> String? {
        var doubleCount = Double(count) ?? 0.0
        if doubleCount <= 0 || doubleCount == 0.0 {
            return "Введите правильно количество"
        }
        
        if first == "Валюта"{
                return "Выберите базовую валюту"
        } else if second == "Валюта"{
            return "Выберите валюту 2"
        }
        
        
        var multiply = 1.0
        var rubToSecond: Double
        var rubToFirst: Double
        if first == "RUB" {
            rubToSecond = data?.Valute[second]?.Value ?? 1
            multiply = 1 / rubToSecond
        } else if second == "RUB" {
            rubToFirst = data?.Valute[first]?.Value ?? 1
            multiply = rubToFirst
        } else {
            rubToFirst = data?.Valute[first]?.Value ?? 1
            rubToSecond = data?.Valute[second]?.Value ?? 1
            multiply = rubToSecond / rubToFirst
        }
        var result = doubleCount * multiply
        return count + " " + first + " = " + String(format: "%.2f", result) + " " +  second
    }
    
}
    

struct Converter_Previews: PreviewProvider {
    static var previews: some View {
        Converter()
    }
}
