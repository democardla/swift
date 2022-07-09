//
//  calculateMethod.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/6/13.
//

import Foundation

class calculateMethod{
    /**
     计算体积的方法
     */
    public static func getVolume(OLT OLT:Int, FLT FLT:Int, FinalVolume finalVolume:Int) -> Int {
        let requiredVolume = (finalVolume*FLT)/OLT
        return requiredVolume
    }//倍比换算法
    
    public static func getVolume(OriginalLiquidConcentration OLC:Float, LaterLiquidConcentration LLC:Float, FinalVolume finalVolume:Float) -> Float {
        let requiredVolume = (finalVolume*LLC)/OLC
        return requiredVolume
    }
    
}


public func getVolume(OriginalLiquidConcentration OLC:Float, LaterLiquidConcentration LLC:Float, FinalVolume finalVolume:Float) -> Float {
    let requiredVolume = (finalVolume*LLC)/OLC
    return requiredVolume
}
