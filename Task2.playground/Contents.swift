//Input: x = 121
//Output: true
//Explanation: 121 reads as 121

let x = 121

extension Int {
    func isPallindrom() -> Bool {
        String(self) == String(String(self).reversed())
    }
}

let result = x.isPallindrom() //true

let y = -121
y.isPallindrom() //false

let w = 10
w.isPallindrom() //false
