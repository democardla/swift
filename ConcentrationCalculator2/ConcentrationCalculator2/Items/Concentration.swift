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
    public static var VolumeUnit = ["nM", "µM", "mM", "M", "X", "ng/L", "µg/L", "mg/L", "g/L"]
    static func resetVolumeUnit() {
        Concentration.VolumeUnit = ["nM", "µM", "mM", "M", "X", "ng/L", "µg/L", "mg/L", "g/L"]
    }
    func setVolumeUnit(){
        var ret: [String]
        if isUnitModule == .weight {
            Concentration.VolumeUnit = Concentration.WeightConcentrationUnits
        } else if isUnitModule == .mole {
            Concentration.VolumeUnit = Concentration.MoleConcentrationUnits
        } else if isUnitModule == .time {
            Concentration.VolumeUnit = [Concentration.TimeConcentration]
        }
    }
    //单位的等级
    public static let WeightConcentrationUnits = ["ng/L", "µg/L", "mg/L", "g/L"]
    public static let MoleConcentrationUnits = ["nM", "µM", "mM", "M"]
    public static let TimeConcentration = "X"
    var isSubmit: Submit?
    enum unitModule {
        case mole
        case weight
        case time
    }
    
    //当前单位模式
    var isUnitModule: unitModule {
        if Concentration.WeightConcentrationUnits.contains(unit!){
            return .weight
        } else if Concentration.MoleConcentrationUnits.contains(unit!){
            return .mole
        }
            return .time
    }
    
    //返回对象创建日志：可以用来作为viewcontroller中的展示窗口的数据来源
    func returnLog() -> String?{
        if(value != nil){
            var state: String?
            if isSubmit == .originally {
                state = "初始浓度是"
            } else {
                state = "最终浓度是"
            }
            var ret = state! + String(value!) + unit!
            return ret
        }
        return nil
    }
    
    func transToUnit(unit: String) -> HaveUnit {
        if self.unit! == unit {
            return self
        }
        if isUnitModule == .weight{
            let ounit = Concentration.WeightConcentrationUnits.firstIndex(of: self.unit!)!
            let funit = Concentration.WeightConcentrationUnits.firstIndex(of: unit)!
            //10的n次方幂
            let base = pow(Double(10), Double(3*(funit-ounit)))
            self.value = self.value!*Float(base)
            self.unit = unit
        }
        if isUnitModule == .mole{
            let ounit = Concentration.MoleConcentrationUnits.firstIndex(of: self.unit!)!
            let funit = Concentration.MoleConcentrationUnits.firstIndex(of: unit)!
            let base = pow(Double(10), Double(3*(funit-ounit)))
            self.value = self.value!*Float(base)
            self.unit = unit
        }
        return self
    }
    
}
