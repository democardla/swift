//
//  ViewController.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/6/13.
//

import UIKit

///主视图的设计界面
class ViewController: UIViewController{
    var stateString = ["浓度":["初始浓度","最终浓度"], "体积": ["初始体积","最终体积"]]

    var unitsOfConcentration = ["uM","nM","M"]
    var unitsOfVolume = ["uL","mL","L"]
    var pickerView = UIPickerView()

    @IBOutlet var stateOfCalculator: UITextField!
    //创建控件需要使用构造器
    var stateStringOfCalculator = UIPickerView()
    //初始浓度输入框
    @IBOutlet var originalConcentration: UITextField!
    //初始浓度的单位
    @IBOutlet var ConcentrationUnitsPicker: UIPickerView!
    //初始体积输入框

    //初始体积单位

    @IBOutlet var TextRect: UITextField!
    
    
    @IBOutlet var myCustomViewTest: myCustomView!
    
    @IBOutlet weak var pickerTest: picker!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        stateStringOfCalculator.delegate = self
        stateStringOfCalculator.dataSource = self
        stateOfCalculator.inputView = stateStringOfCalculator
        stateOfCalculator.textAlignment = .center

        //初始浓度文本框
        pickerView.dataSource = self
        pickerView.delegate = self
        originalConcentration.inputView = pickerView
        originalConcentration.textAlignment = .center//使出现的文本居中
        //初始浓度单位选择器
        ConcentrationUnitsPicker.dataSource = self
        ConcentrationUnitsPicker.delegate = self
                ConcentrationUnitsPicker.selectRow(0, inComponent: 0, animated: true)
    }
}

//关于UIPickerView的扩展设置
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView == stateStringOfCalculator){
            return 2
        }
        return 1
    }
    //选择列初始化的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        //
        if pickerView == stateStringOfCalculator {
            return stateString.values.count
        }
        return unitsOfConcentration.count
    }
    //选择

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitsOfConcentration[row]
    }
    //选择之后的操作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == stateStringOfCalculator {
            if row == 0 && component == 0 {
                pickerView.reloadComponent(component + 1)
                stateOfCalculator.resignFirstResponder()
            }
        }
        originalConcentration.resignFirstResponder()
    }
}

//关于UITextFieldDelegate的扩展设置
extension ViewController: UITextFieldDelegate {
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.resignFirstResponder()
//
//    }
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        <#code#>
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

