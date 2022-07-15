//
//  Workspace.swift
//  ConcentrationCalculator2
//
//  Created by DemoCardla on 2022/7/10.
//

import Foundation

class Workspace {
    //数据
    var OC: Concentration?
    var FC: Concentration?
    var OV: Volume?
    var FV: Volume?
    //TODO: 这里应该改成用户要求的单位
    var CustomUnit: String? 
    //输出就绪的变量
    
    public var dataCount: Int{
            return countOfVolumesAreNotEmpty()+countOfConcentrationsAreNotEmpty()
    }
    func countOfVolumesAreNotEmpty() -> Int{
        //获得当前就绪的变量
        var countReady = 0
        if OV != nil{
            countReady += 1
        }
        if FV != nil{
            countReady += 1
        }
        return countReady
    }
    func countOfConcentrationsAreNotEmpty() -> Int{
        var countReady = 0
        if OC != nil{
            countReady += 1
        }
        if FC != nil{
            countReady += 1
        }
        return countReady
    }
    func log() -> [String] {
        var arr: [String] = []
        arr.append(OC?.returnLog() ?? "null")
        arr.append(OV?.returnLog() ?? "null")
        arr.append(FC?.returnLog() ?? "null")
        arr.append(FV?.returnLog() ?? "null")
        //print(arr)
        return arr
    }
    
    //更新变量状态：重载了两个函数
    public func updateArguments(_ argument: Concentration){
        if argument.isSubmit == Submit.originally {
            self.OC = argument
        } else {
            self.FC = argument
        }
        argument.setVolumeUnit()
    }
    public func updateArguments(_ argument: Volume){
        if argument.isSubmit == Submit.originally {
            self.OV = argument
        } else {
            self.FV = argument
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
        let getUnit = returnLowerUnit(OC: OC!, FC: FC!)
        OC!.transToUnit(unit: getUnit)
        FC!.transToUnit(unit: getUnit)
        OV!.transToUnit(unit: CustomUnit!)
        //计算
        value = (OC!.value!/FC!.value!)*OV!.value!
        return Volume(value: value, unit: CustomUnit!, isSubmit: isSubmit)
    }
    func getFinalConcentration() -> Concentration {
        var value: Float
        var isSubmit: Submit = .finally
        let getUnit = returnLowerUnit(OV: OV!, FV: FV!)
        OV!.transToUnit(unit: getUnit)
        FV!.transToUnit(unit: getUnit)
        OC!.transToUnit(unit: CustomUnit!)
        value = (OV!.value!/FV!.value!)*OC!.value!
        return Concentration(value: value, unit: CustomUnit!, isSubmit: isSubmit)
    }
        //TODO: 定义统一单位的方法
    func returnLowerUnit(OV: Volume, FV: Volume) -> String {
        let ovIndex = Volume.VolumeUnit.firstIndex(of: OV.unit!)!
        let fvIndex = Volume.VolumeUnit.firstIndex(of: FV.unit!)!
        if Int(ovIndex) <= Int(fvIndex) {
            return OV.unit!
        }
        return FV.unit!
    }
    
    func returnLowerUnit(OC: Concentration, FC: Concentration) -> String {
        if OC.isUnitModule == .mole {
            if Int(Concentration.MoleConcentrationUnits.firstIndex(of: OC.unit!)!) <= Int(Concentration.MoleConcentrationUnits.firstIndex(of: FC.unit!)!) {
                return OC.unit!
            }
            return FC.unit!
        }
        if OC.isUnitModule == .weight {
            if Int(Concentration.WeightConcentrationUnits.firstIndex(of: OC.unit!)!) <= Int(Concentration.WeightConcentrationUnits.firstIndex(of: FC.unit!)!) {
                return OC.unit!
            }
            return FC.unit!
        }
        return "X"
    }
    init(){
        
    }
}


