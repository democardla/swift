//
//  Volume.swift
//  ConcentrationCalculator2
//
//  Created by DemoCardla on 2022/7/11.
//

import Foundation

public class Volume: Hashable, HaveUnit{
    init(value: Float, unit: String, isSubmit: Submit){
        self.value = value
        self.unit = unit
        self.isSubmit = isSubmit
    }
    init(value: Float, unit: String){
        self.value = value
        self.unit = unit
    }
    
    var value: Float?
    var unit: String? = "mL"
    var isSubmit: Submit?
    
    public static let VolumeUnit = ["nL", "µL", "mL", "L"]
    
    //可哈希操作
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
    
    
    func transToUnit(unit: String) -> HaveUnit {
        if self.unit! == unit {
            return self
        }
        let ounit = Volume.VolumeUnit.firstIndex(of: self.unit!)!
        let funit = Volume.VolumeUnit.firstIndex(of: unit)!
        let base = pow(Double(10), 3*Double((funit-ounit)))
        self.value = self.value!*Float(base)
        self.unit = unit
        return self
    }
    
    func returnLog() -> String? {
        if(value != nil){
            var state: String?
            if isSubmit == .originally {
                state = "初始体积是"
            } else {
                state = "最终体积是"
            }
            var ret = state! + String(value!) + unit!
            return ret
        }
        return nil
    }
}
