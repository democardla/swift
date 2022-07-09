//
//  UnitExtension.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/6/14.
//

import Foundation

protocol haveUnit {
    var value:Float? { get }
    /**
     返回化学计量单位的等级单位的等级
     */
    func returnUnitGrade(input:String) -> Int?
    /**
     选择较小的计量单位
     */
    func turnToSmallerUnit(OriginalUnit OU:String, FinalUnit FU:String) -> String?
    func turnToBiggerUnit(OriginalUnit OU:String, FinalUnit FU:String) -> String?
    /**
     返回当前对象的状态日志
     */
    func returnLog() -> String?
}
