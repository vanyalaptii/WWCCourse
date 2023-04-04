//Input: nums = [2,7,11,15], target = 9
//Output: [0,1]
//Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

//MARK: сложность алгоритма O(N)


let nums: [Int] = [3,2,4]
let target = 6

extension Array where Element == Int {
    
    func sumIndexesReturner(_ target: Int) -> [Int] {
        
        var result: [Int] = []
        
        for index in nums.indices {
            let difference = target - nums[index]
            
            guard index < nums.count - 1 else { break }
            
            if let secondNumberIndex = nums[ index + 1 ... nums.count - 1 ].firstIndex(of: difference) {
                result.append(index)
                result.append(secondNumberIndex)
                break
            }
        }
        return result.isEmpty ? [-1] : result
    }
}

let result = nums.sumIndexesReturner(target)
