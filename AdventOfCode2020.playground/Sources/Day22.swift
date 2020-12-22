import Foundation

public class Day22 {
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
    
    func process(player1: [Int], player2: [Int]) -> Int {
        var list1 = player1
        var list2 = player2
        while list1.count > 0 && list2.count > 2 {
            let card1 = list1.removeFirst()
            let card2 = list2.removeFirst()
            
            if card1 > card2 {
                list1.append(contentsOf: [card1, card2])
            } else if card2 > card1 {
                list2.append(contentsOf: [card2, card1])
            } else {
                list1.append(card1)
                list2.append(card2)
            }
        }
        
        let list = list1.count == 0 ? list2 : list1
        
        var score = 0
        for i in 0..<list.count {
            score += list[i] * (list.count - i)
        }
        
        return score
    }
    
    func processRecursion(player1: [Int], player2: [Int]) -> Int {
        let round = recursion(index: 0, player1: player1, player2: player2)
        let list = round.player1.count > 0 ? round.player1 : round.player2
        
        var score = 0
        for i in 0..<list.count {
            score += list[i] * (list.count - i)
        }
        
        return score
    }
    
    func recursion(index: Int, player1: [Int], player2: [Int]) -> (player1: [Int], player2: [Int]) {
        var list1 = player1
        var list2 = player2
        
        var historyList1 = [Int:[[Int]]]()
        var historyList2 = [Int:[[Int]]]()
        
        while list1.count > 0 && list2.count > 0 {
            let card1 = list1.removeFirst()
            let card2 = list2.removeFirst()
            
            if card1 > list1.count || card2 > list2.count {
                if card1 > card2 {
                    list1.append(contentsOf: [card1, card2])
                } else if card2 > card1 {
                    list2.append(contentsOf: [card2, card1])
                } else {
                    list1.append(card1)
                    list2.append(card2)
                }
            } else {
                let newList1 = Array(list1.prefix(card1))
                let newList2 = Array(list2.prefix(card2))
                
                let newRound = recursion(index: index + 1,player1: newList1, player2: newList2)
                if newRound.player1.count > 0 {
                    list1.append(contentsOf: [card1, card2])
                } else {
                    list2.append(contentsOf: [card2, card1])
                }
            }
            
            if historyList1.keys.contains(list1.count) == false {
                historyList1[list1.count] = [[Int]]()
            }
            
            if historyList2.keys.contains(list2.count) == false {
                historyList2[list2.count] = [[Int]]()
            }
            
            if historyList1[list1.count]?.contains(list1) == true || historyList2[list2.count]?.contains(list2) == true {
                list2 = []
                break
            }
            
            historyList1[list1.count]?.append(list1)
            historyList2[list2.count]?.append(list2)
        }
        
        return (player1: list1, player2: list2)
    }
    
    func processPart1(data: [String]) -> Int {
        let newData = data.suffix(from: 1).map({ Int($0) })
        
        let player1 = newData.prefix(while: { $0 != nil }).compactMap({ $0 })
        let player2 = newData.suffix(from: player1.count).compactMap({ $0 })
        
        return process(player1: player1, player2: player2)
    }
    
    func processPart2(data: [String]) -> Int {
        
        let newData = data.suffix(from: 1).map({ Int($0) })
        
        let player1 = newData.prefix(while: { $0 != nil }).compactMap({ $0 })
        let player2 = newData.suffix(from: player1.count).compactMap({ $0 })
       
        return processRecursion(player1: player1, player2: player2)
    }
}
