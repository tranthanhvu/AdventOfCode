import Foundation

public class Utility {
    static public func readFile(name: String) -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: nil, inDirectory: nil),
              let text = try? String(contentsOfFile: path) else {
            return ""
        }
        
        return text
    }
    
    static public func evaluate(block: () -> Void) {
        let start = DispatchTime.now()
        block()
        let end = DispatchTime.now()
        
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluete: \(timeInterval) seconds")
    }
}
