//
//  Concentration.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/6/14.
//

import Foundation




public class Concentration: Hashable,HaveUnit{

    
    //初始化器
    init(concentration:Float, unit:String){
        self.value = concentration
        self.unit = unit
    }
    
    //浓度
    var value: Float?
    //创建单位变量用来记录计量单位
    var unit: String?
    //单位的等级
    var unitsGrade: Dictionary<String, Int> = ["uM":0 ,"nM":1, "mM":2, "M":3]

    
    
    var calcuTimes:Int?
    
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
    
    
    /**
     返回化学计量单位的等级单位的等级
     好像可以使用unitGrade.removeValue(forKey:)方法
     */
    
    func returnUnitGrade(input: String) -> Int? {
        return unitsGrade.removeValue(forKey: input)
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
    
    var isSubmit: Submit?
}

extension Hashable{
    
}


