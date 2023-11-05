import Foundation

class APIManager {
    let urlString = "https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities.json"
    
    func getData() {
        guard let url = URL(string: urlString) else {
            print("ERR")
            return
        }
        
        let request = URLRequest(url: url)
        
        print("ENCLOSING")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("LOCAL")
        }
        
        task.resume()
    }
}
