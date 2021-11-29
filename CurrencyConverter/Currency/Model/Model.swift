import Foundation

struct CurrencyModel: Decodable {
    var Date: String
    var PreviousDate: String
    var PreviousURL: String
    var Timestamp: String
    var Valute: [String: ValuteInfo]
    

}

struct ValuteInfo: Decodable {
    var ID: String
    var NumCode: String
    var CharCode: String
    var Nominal: Int
    var Name: String
    var Value: Double
    var Previous: Double
}
