import Foundation

public class Day05 {
    
    let data: [String]
    
    public init(text: String) {
        let lines = text.components(separatedBy: .newlines)
        
        self.data = lines
    }
    
    public func run01() {
        print("run01: \(processPart1(data: data))")
    }
    
    public func run02() {
        print("run02: \(processPart2(data: data))")
    }
    
    func processPart1(data: [String]) -> Int {
        let max = data.map({ findSeatID(code: $0) })
            .max() ?? 0
        
        return max
    }
    
    func processPart2(data: [String]) -> Int {
        let sortedList = data.map({ findSeatID(code: $0) })
            .sorted()
        
        for i in 1..<sortedList.count-2 {
            if sortedList[i+1] - sortedList[i] != 1 {
                return sortedList[i] + 1
            }
        }
        
        return 0
    }
    
    func findSeatID(code: String) -> Int {
        if code.count != 10 {
            return 0
        }
        
        var lowerRow: Int = 0
        var upperRow: Int = 127
        var lowerCol: Int = 0
        var upperCol: Int = 7
        for i in 0..<7 {
            let char = code[code.index(code.startIndex, offsetBy: i)]
            let midRange = (upperRow - lowerRow + 1) / 2
            if char == "F" {
                upperRow = lowerRow + midRange - 1
            } else {
                lowerRow = lowerRow + midRange
            }
        }
        
        for i in 7..<10 {
            let char = code[code.index(code.startIndex, offsetBy: i)]
            let midRange = (upperCol - lowerCol + 1) / 2
            if char == "L" {
                upperCol = lowerCol + midRange - 1
            } else {
                lowerCol = lowerCol + midRange
            }
        }
        
        let number = lowerRow * 8 + lowerCol
//        print("\(code): row \(lowerRow), column \(lowerCol), seat ID: \(number)")
        
        return number
    }
}
