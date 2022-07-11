//
//  Workspace.swift
//  ConcentrationCalculator2
//
//  Created by DemoCardla on 2022/7/10.
//

import Foundation

class Workspace {
    public var dataCount: Int{
        return countOfArgumentsAreNotEmpty()
    }
    var OriginalConcentration: Concentration?
    var FinalConcentration: Concentration?
    var OriginalVolume: Volume?
    var FinalVolume: Volume?
    
    func countOfArgumentsAreNotEmpty() -> Int{
        //获得当前就绪的变量
        var countReady = 0
        if OriginalVolume != nil{
            countReady += 1
        }
        if FinalVolume != nil{
            countReady += 1
        }
        if OriginalConcentration != nil{
            countReady += 1
        }
        if FinalConcentration != nil{
            countReady += 1
        }
        return countReady
    }
    //输出变量
    
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
    
    init(){
        
    }
}


