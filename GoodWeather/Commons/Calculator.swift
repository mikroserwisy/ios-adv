import Foundation
 
class Calculator {
    
    let queue = DispatchQueue.main

    func add(leftHandSide: Int, rightHandSide: Int) -> Int {
        leftHandSide + rightHandSide
    }
    
    func divide(leftHandSide: Int, rightHandSide: Int) throws -> Int {
        if (rightHandSide == 0) {
            throw CalculatorError.illegalArgument
        }
        return leftHandSide / rightHandSide
    }
    
    func getRandomPrime(callback: @escaping (Int) -> Void) {
        queue.async {
            callback(5)
        }
    }
    
}

enum CalculatorError: Error {
    
    case illegalArgument
    
}
