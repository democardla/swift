//
//  Concentration.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/6/14.
//

import Foundation

public class Concentration: Hashable,HaveUnit{
    //初始化器
    init(value:Float, unit:String, isSubmit: Submit){
        self.value = value
        self.unit = unit
        self.isSubmit = isSubmit
    }
    init(value:Float, unit:String){
        self.value = value
        self.unit = unit
    }
    //可哈希操作
    public static func == (lhs:Concentration, rhs:Concentration) -> Bool{
        if lhs.unit != rhs.unit {
            return false
        }
        if(lhs.value != rhs.value){
            return false
        }
        return true
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    
    
    //浓度
    var value: Float?
    //创建单位变量用来记录计量单位
    var unit: String?
    //单位的等级
    public let WeightConcentrationUnitGrade = ["ng/L", "µg/L", "mg/L", "g/L"]
    public let MoleConcentrationUnitsGrade = ["nM", "µM", "mM", "M"]
    var isSubmit: Submit?
    enum unitModule {
        case mole
        case weight
    }
    
    //当前单位模式
    var isUnitModule: unitModule {
        if WeightConcentrationUnitGrade.contains(unit!) {
            return .weight
        }
        return .mole
    }
    
    //返回对象创建日志：可以用来作为viewcontroller中的展示窗口的数据来源
    func returnLog() {
        if(value != nil){
            var state: String?
            if isSubmit == .originally {
                state = "初始浓度是"
            } else {
                state = "最终浓度是"
            }
            print("\(state! + String(value!) + unit!)")
        }
    }
    
    func transToUnit(unit: String) -> HaveUnit {
        if self.unit! == unit {
            return self
        }
        if isUnitModule == .weight{
            let ounit = WeightConcentrationUnitGrade.firstIndex(of: self.unit!)!
            let funit = WeightConcentrationUnitGrade.firstIndex(of: unit)!
            //10的n次方幂
            let base = pow(Double(10), Double(3*(funit-ounit)))
            self.value = self.value!*Float(base)
            self.unit = unit
        }
        if isUnitModule == .mole{
            let ounit = MoleConcentrationUnitsGrade.firstIndex(of: self.unit!)!
            let funit = MoleConcentrationUnitsGrade.firstIndex(of: unit)!
            let base = pow(Double(10), Double(3*(funit-ounit)))
            self.value = self.value!*Float(base)
            self.unit = unit
        }
        return self
    }
    
}
