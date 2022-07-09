//
//  Concentration.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/6/14.
//

import Foundation




public class Concentration:Hashable,haveUnit{
    //初始化器
    init(concentration:Float, unit:String){
        self.value = concentration
        self.unit = unit
        unitGrade = returnUnitGrade(input: unit)
    }
    //浓度
    var value: Float? = nil
    //创建单位变量用来记录计量单位
    private var unit:String
    //单位的等级
    var unitGrades = ["uM":0 ,"nM":1, "mM":2, "M":3]

    
    private var unitGrade: Int?
    
    var calcuTimes:Int?
    func returnLog() -> String? {
        if(value != nil){
            return "\(String(value!) + unit)"
        }
        return nil
    }
    
    
    /**
     返回化学计量单位的等级单位的等级
     */
    func returnUnitGrade(input: String) -> Int? {
        for key in unitGrades {
            if(unit == key.key){
                return key.value
            }
        }
        return nil
    }
    
    
    public func turnToSmallerUnit(OriginalUnit OU: String, FinalUnit FU: String) -> String? {
        let oluValue = returnUnitGrade(input: OU), flcValue = returnUnitGrade(input: FU)
        if(oluValue! >= flcValue!){
            
            return FU
        }else if(oluValue! < flcValue!){
            return OU
        }
        return nil
    }
    
    func turnToBiggerUnit(OriginalUnit OU: String, FinalUnit FU: String) -> String? {
        let oluValue = returnUnitGrade(input: OU), flcValue = returnUnitGrade(input: FU)
        if(oluValue! >= flcValue!){
            return OU
        }else if(oluValue! < flcValue!){
            return FU
        }
        return nil
    }
    
    //类的读写操作
    //    public func setConcentration(Input input:Int){
    //        self.concentration = input
    //    }
    //    public func getConcentration() -> Int{
    //        return concentration
    //    }
    //    public func getXXX() -> Int{
    //        return concentration
    //    }
    //    func getUnit() -> String {
    //        return unit
    //    }
    
    //可哈希操作
    public static func == (lhs:Concentration, rhs:Concentration) -> Bool{
        if(lhs.value == rhs.value){
            return true
        }
        return false
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    
    
    
}


