import SwiftUI


struct Currency: View {
    @State var currency: CurrencyModel?
    @State var valutes: [String] = ["AUD","BGN", "USD", "EUR", "PLN", "CZK", "TJS", "TRY", "TMT", "UZS"]
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView {
            VStack(alignment: .center, spacing: 6) {
                Spacer()
                VStack {
                    Text("Курс валют")
                    Text("Базовая валюта: Рубль")
                }.font(.custom("Helvetica Neue", size: 30))
                Spacer()
                List {
                    
                    GeometryReader { g -> Text in
                        
                        let frame = g.frame(in: CoordinateSpace.global)
                        
                        if frame.origin.y > 250 {
                            CurrencyApi().getCurrency { curr in
                                self.currency = curr
                            }
                            return Text("Loading...")
                        } else {
                            return Text("")
                        }
                        
                    }
                
                ForEach(valutes, id: \.self) { valute in
                    HStack {
                        Text(currency?.Valute[valute]?.Name ?? "название валюты")
                        Spacer()
                        HStack {
                            Text(getValuteValue(valute: valute))
                            Text(getValuteDifference(valute: valute) + "%").foregroundColor(getValuteColor(valute: valute))
                        }
                    }.padding(.trailing)
                        .padding(.leading)
                }
                
                }
            Spacer()
            }.tabItem {
                Text("Курс валют")
            }.tag(1)
            
            Converter().tabItem {
                Text("Конвертер валют")
            }.tag(2)
        }
        .accentColor(.black)
        .onAppear() {
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
        if valueNow >= valueYesterday {
            return "+" + String(format: "%.3f", valueYesterday / valueNow)
        } else {
            return "-" + String(format: "%.3f", valueYesterday / valueNow)
        }
        
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

