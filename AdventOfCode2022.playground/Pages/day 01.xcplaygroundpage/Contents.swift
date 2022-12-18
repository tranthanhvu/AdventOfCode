import Foundation
import XCTest

/// Ref: https://adventofcode.com/2022/day/1
func arrayManipulation(n: Int, queries: [[Int]]) -> Int {
    var list = [Int].init(repeating: 0, count: n)
    var max = 0
    
    /// O(n)
    for query in queries {
        let start = query[0] - 1
        let end = query[1]
        let k = query[2]
        list[start] += k
        if end < n {
            list[end] -= k
        }
    }
    
    // O(n)
    var currentSum = 0
    for num in list {
        currentSum += num
        if max < currentSum {
            max = currentSum
        }
    }

    return max
}


class UserManagerTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test1() {
        XCTAssertTrue(arrayManipulation(n: 5, queries: [
            [1, 2, 100],
            [2, 5, 100],
            [3, 4, 100]
        ]) == 200)
    }
    
    func test2() {
        XCTAssertTrue(arrayManipulation(n: 10, queries: [
            [1, 5, 3],
            [4, 8, 7],
            [6, 9, 1]
        ]) == 10)
    }
    
    func test3() {
        XCTAssertTrue(arrayManipulation(n: 10, queries: [
            [2, 6, 8],
            [3, 5, 7],
            [1, 8, 1],
            [5, 9, 15]
        ]) == 31)
    }
}

UserManagerTests.defaultTestSuite.run()
