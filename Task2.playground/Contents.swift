//Input: x = 121
//Output: true
//Explanation: 121 reads as 121

let x = 121

extension Int {
    func isPallindrom() -> Bool {
        var originalString: [Character] = []
        var reversedString: [Character] = []
        
        for letter in String(self) {
            originalString.append(letter)
        }
        
        for index in stride(from: originalString.count-1, through: 0, by: -1) {
            reversedString.append(originalString[index])
        }
        
        return reversedString == originalString ?  true :  false
    }
}

let result = x.isPallindrom() //true

let y = -121
y.isPallindrom() //false

let w = 10
w.isPallindrom() //false
