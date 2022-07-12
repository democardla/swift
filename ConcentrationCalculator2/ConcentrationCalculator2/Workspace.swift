//
//  Workspace.swift
//  ConcentrationCalculator2
//
//  Created by DemoCardla on 2022/7/10.
//

import Foundation

class Workspace {
    //数据
    var OriginalConcentration: Concentration?
    var FinalConcentration: Concentration?
    var OriginalVolume: Volume?
    var FinalVolume: Volume?
    //TODO: 这里应该改成用户要求的单位
    var CustomUnit: String? = "nM"
    //输出就绪的变量
    public var dataCount: Int{
        return countOfVolumesAreNotEmpty()+countOfConcentrationsAreNotEmpty()
    }
    func countOfVolumesAreNotEmpty() -> Int{
        //获得当前就绪的变量
        var countReady = 0
        if OriginalVolume != nil{
            countReady += 1
        }
        if FinalVolume != nil{
            countReady += 1
        }
        
        return countReady
    }
    func countOfConcentrationsAreNotEmpty() -> Int{
        var countReady = 0
        if OriginalConcentration != nil{
            countReady += 1
        }
        if FinalConcentration != nil{
            countReady += 1
        }
        return countReady
    }
    
    //更新变量状态：重载了两个函数
    public func updateArguments(_ argument: Concentration){
        if argument.isSubmit == Submit.originally {
            self.OriginalConcentration = argument
        } else {
            self.FinalConcentration = argument
        }
    }
    public func updateArguments(_ argument: Volume){
        if argument.isSubmit == Submit.originally {
            self.OriginalVolume = argument
        } else {
            self.FinalVolume = argument
        }
    }
    
    //定义运算方法和：获取结果
    func getOutcomes() -> HaveUnit {
        if countOfVolumesAreNotEmpty() < 2 {
            return getFinalVolume()
        }
        return getFinalConcentration()
    }
    func getFinalVolume() -> Volume {
        var value: Float
        var isSubmit: Submit = .finally
        //统一单位
        let getUnit = returnLowerUnit(OC: OriginalConcentration!, FC: FinalConcentration!)
        OriginalConcentration!.transToUnit(unit: getUnit)
        FinalConcentration!.transToUnit(unit: getUnit)
        OriginalVolume!.transToUnit(unit: CustomUnit!)
        //计算
        value = (OriginalConcentration!.value!/FinalConcentration!.value!)*OriginalVolume!.value!
        return Volume(value: value, unit: CustomUnit!, isSubmit: isSubmit)
    }
    func getFinalConcentration() -> Concentration {
        var value: Float
        var isSubmit: Submit = .finally
        let getUnit = returnLowerUnit(OV: OriginalVolume!, FV: FinalVolume!)
        OriginalVolume!.transToUnit(unit: getUnit)
        FinalVolume!.transToUnit(unit: getUnit)
        OriginalConcentration!.transToUnit(unit: CustomUnit!)
        value = (OriginalVolume!.value!/FinalVolume!.value!)*OriginalConcentration!.value!
        return Concentration(value: value, unit: CustomUnit!, isSubmit: isSubmit)
    }
        //TODO: 定义统一单位的方法
    func returnLowerUnit(OV: Volume, FV: Volume) -> String {
        let ovIndex = OV.VolumeUnitGrade.firstIndex(of: OV.unit!)!
        let fvIndex = FV.VolumeUnitGrade.firstIndex(of: FV.unit!)!
        if Int(ovIndex) <= Int(fvIndex) {
            return OV.unit!
        }
        return FV.unit!
    }
    func returnLowerUnit(OC: Concentration, FC: Concentration) -> String {
        if OC.unit == "X" {
            return "X"
        }
        if OC.isUnitModule == .mole {
            if Int(OC.MoleConcentrationUnitsGrade.firstIndex(of: OC.unit!)!) <= Int(FC.MoleConcentrationUnitsGrade.firstIndex(of: FC.unit!)!) {
                return OC.unit!
            }
            return FC.unit!
        }
        if Int(FC.WeightConcentrationUnitGrade.firstIndex(of: OC.unit!)!) <= Int(FC.WeightConcentrationUnitGrade.firstIndex(of: FC.unit!)!) {
            return OC.unit!
        }
        return FC.unit!
    }
    init(){
        
    }
}


