import SwiftUI


struct Currency: View {
    @State var currency: CurrencyModel?
    @State var valutes: [String] = ["AUD","BGN", "USD", "EUR", "PLN", "CZK", "TJS", "TRY", "TMT", "UZS"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 6) {
                Spacer()
                Text("Базовая валюта: Рубль").font(.custom("Helvetica Neue", size: 40))
                Spacer()
                ForEach(valutes, id: \.self) { valute in
                    HStack {
                        Text(currency?.Valute[valute]?.Name ?? "название валюты")
                        HStack {
                            Text(getValuteValue(valute: valute))
                            Text(getValuteDifference(valute: valute) + "%")
                        }.foregroundColor(getValuteColor(valute: valute))
                    }
                }
            Spacer()
            NavigationLink(destination: Converter()) {
                Text("Открыть конвертацию валют")
                }.navigationBarTitle("Курс валют")
                .padding(.bottom)
            Spacer()
            }
        }.onAppear() {
            CurrencyApi().getCurrency { (currency) in
                self.currency = currency
            }
        }
    }
    
    func getValuteValue(valute: String) -> String {
        let value = self.currency?.Valute[valute]?.Value ?? 1.0
        return String(format: "%.2f", value)
    }
    
    func getValuteDifference(valute: String) -> String {
        let valueNow = self.currency?.Valute[valute]?.Value ?? 1.0
        let valueYesterday = self.currency?.Valute[valute]?.Previous ?? 1.0
        return String(format: "%.2f", valueYesterday / valueNow)
    }
    
    func getValuteColor(valute: String) -> Color {
        let valueNow = self.currency?.Valute[valute]?.Value ?? 1.0
        let valueYesterday = self.currency?.Valute[valute]?.Previous ?? 1.0
        if valueNow >= valueYesterday {
            return Color.green
        } else {
            return Color.red
        }
    }
}

struct Currency_Previews: PreviewProvider {
    static var previews: some View {
        Currency()
    }
}

