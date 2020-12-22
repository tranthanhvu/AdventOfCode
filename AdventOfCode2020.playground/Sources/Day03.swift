import Foundation

public class Day03 {
    let data: [String]
    
    public init(text: String) {
        let lines = text.components(separatedBy: .newlines)
            .compactMap({ $0.isEmpty ? nil : $0 })
        self.data = lines
    }
    
    public func run01() {
        print("run01: \(processPart1(data: data))")
    }
    
    public func run02() {
        print("run02: \(processPart2(data: data))")
    }
    
    func process(lines: [String], ruleX: Int, ruleY: Int) -> Int {
        var count = 0
        
        let maxRow = lines.first?.count ?? 0
        let tree = Character("#")
        var currentX = 0
        var currentY = 0
        
        while currentY < lines.count {
            
            let line = lines[currentY]
            let char = line[line.index(line.startIndex, offsetBy: currentX)]
            
            if char == tree {
                count += 1
            }
            
            currentX = (currentX + ruleX) % maxRow
            currentY = currentY + ruleY
        }
        
        return count
    }
    
    func processPart1(data: [String]) -> Int {
        return process(lines: data, ruleX: 3, ruleY: 1)
    }
    
    func processPart2(data: [String]) -> Int {
        let slope1 = process(lines: data, ruleX: 1, ruleY: 1)
        let slope2 = process(lines: data, ruleX: 3, ruleY: 1)
        let slope3 = process(lines: data, ruleX: 5, ruleY: 1)
        let slope4 = process(lines: data, ruleX: 7, ruleY: 1)
        let slope5 = process(lines: data, ruleX: 1, ruleY: 2)
       
        return slope1 * slope2 * slope3 * slope4 * slope5
    }
}
