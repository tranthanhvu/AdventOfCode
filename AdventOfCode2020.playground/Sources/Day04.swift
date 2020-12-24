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
    
    init(validationData data: String) {
        let elements = data.components(separatedBy: .whitespaces)
        for e in elements {
            let key = e.prefix(3)
            let value = String(e.suffix(from: e.index(e.startIndex, offsetBy: 4)))
            switch key {
            case "byr":
                let v = Int(value) ?? 0
                if v >= 1920 && v <= 2002 {
                    self.byr = value
                }
                
            case "iyr":
                let v = Int(value) ?? 0
                if v >= 2010 && v <= 2020 {
                    self.iyr = value
                }
                
            case "eyr":
                let v = Int(value) ?? 0
                if v >= 2020 && v <= 2030 {
                    self.eyr = value
                }
            case "hgt":
                if value.hasSuffix("cm") {
                    let v = Int(value.prefix(upTo: value.index(value.endIndex, offsetBy: -2))) ?? 0
                    if v >= 150 && v <= 193 {
                        self.hgt = value
                    }
                } else if value.hasSuffix("in") {
                    let v = Int(value.prefix(upTo: value.index(value.endIndex, offsetBy: -2))) ?? 0
                    if v >= 59 && v <= 76 {
                        self.hgt = value
                    }
                }
                
            case "hcl":
                if value.count == 7 {
                    let regex = try! NSRegularExpression(pattern: "^#[a-z0-9]{6}")
                    let range = NSRange(location: 0, length: 7)
                    if regex.firstMatch(in: value, options: [], range: range) != nil {
                        self.hcl = value
                    }
                }
                
            case "ecl":
                let list = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
                
                if value.count == 3 && list.contains(value) {
                    self.ecl = value
                }
                
            case "pid":
                if value.count == 9 {
                    let regex = try! NSRegularExpression(pattern: "[0-9]{9}")
                    let range = NSRange(location: 0, length: 9)
                    if regex.firstMatch(in: value, options: [], range: range) != nil {
                        self.pid = value
                    }
                }
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
    
    func processPart1(data: [String]) -> Int {
        let passwords = data.map({ Passport(data: $0) })
            .compactMap({ $0.isInvalid ? nil : $0 })
        
        return passwords.count
    }
    
    func processPart2(data: [String]) -> Int {
        let passwords = data.map({ Passport(validationData: $0) })
            .compactMap({ $0.isInvalid ? nil : $0 })
        
        return passwords.count
    }
}
