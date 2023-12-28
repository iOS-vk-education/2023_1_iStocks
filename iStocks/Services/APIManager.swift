import UIKit
import Foundation

class APIManager {
    
    let urlString = "https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities.json"
    
    static let shared = APIManager()
    
    init() {}
    
    func getData() {
        
        guard let url = URL(string: urlString) else {
            return 
        }
    
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data {
                let decodedData = try? JSONDecoder().decode(JSON.self, from: data)
                if let decodedValue = decodedData?.value as? [String: Any] {
                    if let decodedDataM = decodedValue["marketdata"] as? [String: Any] {
                        if let decodedDataMM = decodedDataM["data"] as? [[Any]] {
                            for data in decodedDataMM {
                                if "\(type(of: data[9]))" == "Optional<Any>" {
                                    continue
                                }
                                
                                stocks.append(Stock(name: "", ticker: data[0] as! String, currentPrice: Float(data[12] as! Double), openPrice: Float(data[9] as! Double), isFavorite: false, haveNote: false, note: "", image: UIImage(systemName: "tropicalstorm.circle")!, highPrice: Float(data[11] as! Double), lowPrice: Float(data[10] as! Double)))
                            }
                        }
                    }
                    
                    if let decodedDataM = decodedValue["securities"] as? [String: Any] {
                        if let decodedDataMM = decodedDataM["data"] as? [[Any]] {
                            for data in decodedDataMM {
                                if "\(type(of: data[9]))" == "Optional<Any>" {
                                    continue
                                }
                                
                                let ticker = data[0] as! String
                                
                                for stock in stocks {
                                    if ticker == stock.ticker {
                                        stock.name = data[2] as! String
                                        break
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        task.resume()
    }
}

func decode(fromObject container: KeyedDecodingContainer<JSONCodingKeys>) -> [String: Any] {
  var result: [String: Any] = [:]

  for key in container.allKeys {
    if let val = try? container.decode(Int.self, forKey: key) {
        result[key.stringValue] = Double(val)
    } else if let val = try? container.decode(Double.self, forKey: key) {
      result[key.stringValue] = val
    } else if let val = try? container.decode(String.self, forKey: key) {
      result[key.stringValue] = val
    } else if let val = try? container.decode(Bool.self, forKey: key) {
      result[key.stringValue] = val
    } else if let nestedContainer = try? container.nestedContainer(
      keyedBy: JSONCodingKeys.self, forKey: key)
    {
      result[key.stringValue] = decode(fromObject: nestedContainer)
    } else if var nestedArray = try? container.nestedUnkeyedContainer(forKey: key) {
      result[key.stringValue] = decode(fromArray: &nestedArray)
    } else if (try? container.decodeNil(forKey: key)) == true {
      result.updateValue(Any?(nil) as Any, forKey: key.stringValue)
    }
  }

  return result
}

func decode(fromArray container: inout UnkeyedDecodingContainer) -> [Any] {
  var result: [Any] = []

  while !container.isAtEnd {
    if let value = try? container.decode(String.self) {
      result.append(value)
    } else if let value = try? container.decode(Int.self) {
      result.append(Double(value))
    } else if let value = try? container.decode(Double.self) {
      result.append(value)
    } else if let value = try? container.decode(Bool.self) {
      result.append(value)
    } else if let nestedContainer = try? container.nestedContainer(keyedBy: JSONCodingKeys.self) {
      result.append(decode(fromObject: nestedContainer))
    } else if var nestedArray = try? container.nestedUnkeyedContainer() {
      result.append(decode(fromArray: &nestedArray))
    } else if (try? container.decodeNil()) == true {
      result.append(Any?(nil) as Any)
    }
  }

  return result
}

func encodeValue(
  fromObjectContainer container: inout KeyedEncodingContainer<JSONCodingKeys>, map: [String: Any]
) throws {
  for k in map.keys {
    let value = map[k]
    let encodingKey = JSONCodingKeys(stringValue: k)

    if let value = value as? String {
      try container.encode(value, forKey: encodingKey)
    } else if let value = value as? Int {
      try container.encode(value, forKey: encodingKey)
    } else if let value = value as? Double {
      try container.encode(value, forKey: encodingKey)
    } else if let value = value as? Bool {
      try container.encode(value, forKey: encodingKey)
    } else if let value = value as? [String: Any] {
      var keyedContainer = container.nestedContainer(
        keyedBy: JSONCodingKeys.self, forKey: encodingKey)
      try encodeValue(fromObjectContainer: &keyedContainer, map: value)
    } else if let value = value as? [Any] {
      var unkeyedContainer = container.nestedUnkeyedContainer(forKey: encodingKey)
      try encodeValue(fromArrayContainer: &unkeyedContainer, arr: value)
    } else {
      try container.encodeNil(forKey: encodingKey)
    }
  }
}

func encodeValue(fromArrayContainer container: inout UnkeyedEncodingContainer, arr: [Any]) throws {
  for value in arr {
    if let value = value as? String {
      try container.encode(value)
    } else if let value = value as? Int {
      try container.encode(value)
    } else if let value = value as? Double {
      try container.encode(value)
    } else if let value = value as? Bool {
      try container.encode(value)
    } else if let value = value as? [String: Any] {
      var keyedContainer = container.nestedContainer(keyedBy: JSONCodingKeys.self)
      try encodeValue(fromObjectContainer: &keyedContainer, map: value)
    } else if let value = value as? [Any] {
      var unkeyedContainer = container.nestedUnkeyedContainer()
      try encodeValue(fromArrayContainer: &unkeyedContainer, arr: value)
    } else {
      try container.encodeNil()
    }
  }
}

struct JSONCodingKeys: CodingKey {
  var stringValue: String
    
  init(stringValue: String) {
    self.stringValue = stringValue
  }
    
  var intValue: Int?
    
  init?(intValue: Int) {
    self.init(stringValue: "\(intValue)")
    self.intValue = intValue
  }
}

struct JSON: Codable {
  var value: Any?

  init(value: Any?) {
    self.value = value
  }
  init(from decoder: Decoder) throws {
    if let container = try? decoder.container(keyedBy: JSONCodingKeys.self) {
      self.value = decode(fromObject: container)
    } else if var array = try? decoder.unkeyedContainer() {
      self.value = decode(fromArray: &array)
    } else if let value = try? decoder.singleValueContainer() {
      if value.decodeNil() {
        self.value = nil
      } else {
        if let result = try? value.decode(Int.self) { self.value = result }
        if let result = try? value.decode(Double.self) { self.value = result }
        if let result = try? value.decode(String.self) { self.value = result }
        if let result = try? value.decode(Bool.self) { self.value = result }
      }
    }
  }

  func encode(to encoder: Encoder) throws {
    if let map = self.value as? [String: Any] {
      var container = encoder.container(keyedBy: JSONCodingKeys.self)
      try encodeValue(fromObjectContainer: &container, map: map)
    } else if let arr = self.value as? [Any] {
      var container = encoder.unkeyedContainer()
      try encodeValue(fromArrayContainer: &container, arr: arr)
    } else {
      var container = encoder.singleValueContainer()

      if let value = self.value as? String {
        try! container.encode(value)
      } else if let value = self.value as? Int {
        try! container.encode(value)
      } else if let value = self.value as? Double {
        try! container.encode(value)
      } else if let value = self.value as? Bool {
        try! container.encode(value)
      } else {
        try! container.encodeNil()
      }
    }
  }
}
