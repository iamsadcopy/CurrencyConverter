//
//  CurrencyMain.swift
//  CurrencyConverter
//
//  Created by Pavel Moskvichev on 29.11.2021.
//

import SwiftUI

struct CurrencyMain: View {
    @Binding var valutes: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Spacer()
            Text("Базовая валюта: Рубль").font(.custom("Helvetica Neue", size: 40))
            Spacer()
            ForEach($valutes, id: \.self) { valute in
                HStack {
                    Text(currency?.Valute[valute]?.Name ?? "название валюты")
                    Spacer()
                    HStack {
                        Text(getValuteValue(valute: valute))
                        Text(getValuteDifference(valute: valute) + "%")
                    }.foregroundColor(getValuteColor(valute: valute))
                }.padding(.trailing)
                    .padding(.leading)
            }
        Spacer()
        }
    }
}

struct CurrencyMain_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyMain()
    }
}
