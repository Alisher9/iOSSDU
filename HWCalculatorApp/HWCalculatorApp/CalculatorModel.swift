//
//  CalculatorModel.swift
//  HWCalculatorApp
//
//  Created by Alisher on 9/15/19.
//  Copyright © 2018 Alisher. All rights reserved.
//


import Foundation

func factorial(op1: Double) -> Double {
    if (op1 <= 1) {
        return 1
    }
    return op1 * factorial(op1: op1 - 1.0)
}


enum Operation{
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double,Double)->Double)
    case equals
}

struct CalculatorModel{
    private var global_operation: Double?
    
    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "AC": Operation.constant(0),
        "e": Operation.constant(M_E),
        "²√x": Operation.unaryOperation(sqrt),
        "×": Operation.binaryOperation({ $0*$1 }),
        "÷": Operation.binaryOperation({$0/$1}),
        "+": Operation.binaryOperation({$0+$1}),
        "−": Operation.binaryOperation({$0-$1}),
        "ʸ√x": Operation.binaryOperation({pow(sqrt($1), $0)}),
        "%": Operation.unaryOperation({ $0/100 }),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "⁺∕-": Operation.unaryOperation { -$0 },
        "x²": Operation.unaryOperation({pow($0, 2)}),
        "xʸ": Operation.binaryOperation({pow($0, $1)}),
        "x³": Operation.unaryOperation({pow($0, 3)}),
        "eˣ": Operation.unaryOperation({pow(M_E, $0)}),
        "10ˣ": Operation.unaryOperation({pow(10, $0)}),
        "¹∕x": Operation.unaryOperation({1/$0}),
        "³√x": Operation.unaryOperation({pow($0, 1/3)}),
        "ln": Operation.unaryOperation(log),
        "EE": Operation.binaryOperation({$0*pow(10, $1)}),
        "abs": Operation.unaryOperation(abs),
        "log₁₀" : Operation.constant(M_LN10),
        "sinh": Operation.unaryOperation(sinh),
        "cosh": Operation.unaryOperation(cosh),
        "tanh": Operation.unaryOperation(tanh),
        "x!": Operation.unaryOperation({factorial(op1: $0)}),
        "=": Operation.equals
    ]
    mutating func performOperation(_ operation: String){
        let symbol = operations[operation]!
        switch symbol {
        case .constant(let value):
            global_operation = value
        case .unaryOperation(let function):
            if global_operation != nil{
                global_operation = function(global_operation!)
            }
        case .binaryOperation(let function):
            if global_operation != nil{
                saving = SavingFirstOperandAndFunction(firstOperand: global_operation!, function: function)
            }
            break
        case .equals:
            if global_operation != nil{
                global_operation = saving?.performOperationWith(global_operation!)
            }
            break
        }
    }
    private var saving: SavingFirstOperandAndFunction?
    private struct SavingFirstOperandAndFunction{
        let firstOperand: Double
        let function: (Double,Double)->Double
        
        func performOperationWith(_ secondOperand: Double)-> Double{
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func clear() {
        global_operation = 0
        
    }
    
    mutating func setOperand(_ operand: Double){
        global_operation = operand
    }
    var result: Double? {
        get{
            return global_operation
        }
    }
}
