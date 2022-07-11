//
//  Volume.swift
//  ConcentrationCalculator2
//
//  Created by DemoCardla on 2022/7/11.
//

import Foundation

public class Volume: Hashable, HaveUnit{
    
    init(value: Float, unit: String){
        self.value = value
        self.unit = unit
    }
    
    var value: Float?
    var unit: String?
    var isSubmit: Submit?
    var unitsGrade: Dictionary<String, Int> = ["µL":0, "nL":1, "mL":2, "L":3]
    
    public static func == (lhs: Volume, rhs: Volume) -> Bool {
        if lhs.unit != rhs.unit {
            return false
        }
        if lhs.value != rhs.value {
            return false
        }
        return true
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }


    func returnUnitGrade(input: String) -> Int? {
        return unitsGrade.removeValue(forKey: input)
    }

    func turnToSmallerUnit(OriginalUnit OU: String, FinalUnit FU: String) -> String? {
        return ""
    }

    func turnToBiggerUnit(OriginalUnit OU: String, FinalUnit FU: String) -> String? {
        return ""
    }

    func returnLog() {
        if(value != nil){
            var state: String?
            if isSubmit == .originally {
                state = "初始体积是"
            } else {
                state = "最终体积是"
            }
           print("\(state! + String(value!) + unit!)")
        }
    }
}


