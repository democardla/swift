//
//  UnitExtension.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/6/14.
//

import Foundation

protocol HaveUnit {
    var value:Float? { get }
    var unit: String? { get }
    
    func transToUnit(unit: String) -> HaveUnit
    /**
     返回当前对象的状态日志
     */
    func returnLog() -> String?
    
}

