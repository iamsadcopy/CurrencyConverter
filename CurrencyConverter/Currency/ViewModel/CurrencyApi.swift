import SwiftUI

struct CurrencyApi {
    func getCurrency(completion: @escaping (CurrencyModel) -> () ) {
        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let currency = try! JSONDecoder().decode(CurrencyModel.self, from: data!)
            DispatchQueue.main.async {
                completion(currency)
            }
        }
        .resume()
    }
    
}
