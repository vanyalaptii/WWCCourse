//Input: nums = [2,7,11,15], target = 9
//Output: [0,1]
//Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].


let nums = [2,7,11,15]
let target = 9

extension Array where Element == Int {
    
    func sumIndexesReturner(_ target: Int) -> [Int] {
        
        var result: [Int] = []
        
        for firstNumber in nums {
            let difference = target - firstNumber
            let secondNumber = nums.firstIndex(of: difference)
            if secondNumber != nil {
                result.append(nums.firstIndex(of: firstNumber)!)
                result.append(secondNumber!)
                break
            }
        }
        return result.isEmpty ? [-1] : result
    }
}

let result = nums.sumIndexesReturner(target) //[0, 1]
