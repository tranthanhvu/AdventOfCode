import Foundation

public class Day01 {
    let data: [Int]
    public init(text: String) {
        let lines = text.components(separatedBy: .newlines)
        let list = lines.map({ Int($0) }).compactMap({ $0 })
        self.data = list
    }
    
    public func run01() {
        print("run01: \(processPart1(list: data))")
    }
    
    public func run02() {
        print("run02: \(processPart2(list: data))")
    }
    
    func process(sortedList: [Int], target: Int) -> Int {
        var max = 0
        var startIndex = 0
        var endIndex = sortedList.count - 1

        while startIndex < endIndex {
            let first = sortedList[startIndex]
            let second = sortedList[endIndex]
            
            let sum = first + second
            if sum == target {
                let multiplying = first * second
                if multiplying > max {
                    max = multiplying
                }
                
                startIndex += 1
                endIndex -= 1
            }
            else if sum < target {
                startIndex += 1
            }
            else {
                endIndex -= 1
            }
        }
        
        return max
    }
    
    func processPart1(list: [Int]) -> Int {
        let sortedList = list.sorted()

        return process(sortedList: sortedList, target: 2020)
    }
    
    func processPart2(list: [Int]) -> Int {
        let sortedList = list.sorted()

        var max = 0
        for i in 0..<sortedList.count - 2 {
            let number = sortedList[i]
            let begin = sortedList[i+1]
            let end = sortedList[sortedList.count - 1]
            
            let target = 2020 - number
            
            if begin + end >= target && begin < target {
                let sub = [Int](sortedList.suffix(from: i+1))
                
                let result = process(sortedList: sub, target: target)
                
                let multiplying = number * result
                if multiplying > max {
                    max = multiplying
                }
            }
        }
       
        return max
    }
}
