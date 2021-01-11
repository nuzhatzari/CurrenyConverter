import UIKit

func arthimeticOperators() {
    print(3+(1/3)+9)
}
arthimeticOperators()


func isAnagrams(str1: String, str2: String) -> Bool {
    
    let aStr1 = Set(str1.lowercased().replacingOccurrences(of: " ", with: ""))
    let aStr2 = Set(str2.lowercased().replacingOccurrences(of: " ", with: ""))

    return aStr1.sorted() == aStr2.sorted()
}
 
print(isAnagrams(str1: "debit card", str2: "bad credit"))
print(isAnagrams(str1: "punishments", str2: "nine thumps"))


func fibRecursive(_ n: Int) -> Int {
    guard n > 1 else { return n }
    return fibRecursive(n-1) + fibRecursive(n-2)
}

print(fibRecursive(9))


func fibIterative(_ n: Int) -> Int {
    guard n > 1 else {
        return n
    }
    var fibs: [Int] = [1, 1]
    (2...n-1).forEach { i in
        fibs.append(fibs[i - 1] + fibs[i - 2])
    }
    return fibs.last!
}

print(fibIterative(9))
