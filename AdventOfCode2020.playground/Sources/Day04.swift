import Foundation

struct Passport {
    var byr: String? = nil
    var iyr: String? = nil
    var eyr: String? = nil
    var hgt: String? = nil
    var hcl: String? = nil
    var ecl: String? = nil
    var pid: String? = nil
    var cid: String? = nil
    
    var isInvalid: Bool {
        return byr?.isEmpty ?? true ||
            iyr?.isEmpty ?? true ||
            eyr?.isEmpty ?? true ||
            hgt?.isEmpty ?? true ||
            hcl?.isEmpty ?? true ||
            ecl?.isEmpty ?? true ||
            pid?.isEmpty ?? true
    }
    
    init(data: String) {
        let elements = data.components(separatedBy: .whitespaces)
        for e in elements {
            let key = e.prefix(3)
            let value = String(e.suffix(from: e.index(e.startIndex, offsetBy: 4)))
            switch key {
            case "byr": self.byr = value
            case "iyr": self.iyr = value
            case "eyr": self.eyr = value
            case "hgt": self.hgt = value
            case "hcl": self.hcl = value
            case "ecl": self.ecl = value
            case "pid": self.pid = value
            case "cid": self.cid = value
            default: break
            }
        }
    }
    
    func description() -> String {
        let list = [self.byr, self.iyr, self.eyr, self.hgt, self.hcl, self.ecl, self.pid, self.cid].compactMap({ $0 })
        return list.joined(separator: " ")
    }
}

public class Day04 {
    let data: [String]
    
    public init(text: String) {
        let lines = text.components(separatedBy: .newlines)
        let passports = lines.split(separator: "")
            .map { (data) -> String in
                return data.joined(separator: " ")
            }
            
        
        self.data = passports
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
        let passwords = data.map({ Passport(data: $0) })
            .compactMap({ $0.isInvalid ? nil : $0 })
        
        return passwords.count
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
