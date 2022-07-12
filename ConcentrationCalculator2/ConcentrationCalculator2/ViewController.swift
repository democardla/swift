//
//  ViewController.swift
//  ConcentrationCalculator2
//
//  Created by DemoCardla on 2022/7/9.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusSelector: UITextField!
    
    var status = ["初始浓度", "初始体积", "最终浓度", "最终体积"]
    var state: String?
    var statusPicker: UIPickerView!
    var unitLocker = ["", ""]
    //是否是体积输入状态
    private var isVolumeInputState = false {
        didSet{
            unitPicker.reloadComponent(0)//重置unitPicker的展示属性
        }
    }
    
    //按照需求返回用于单位选择器展示的数组
    var units: [String] {
        return isVolumeInputState ? unitOfVolume : unitsOfConcentration
    }
    //储存当前的单位
    var unit: String?
    
    
    //单位：以后再放进plist文件里吧
    let unitsOfConcentration = ["nM", "µM", "mM", "M", "X", "ng/L", "µg/L", "mg/L", "g/L"]
    let unitOfVolume = ["nL", "µL", "mL", "L"]
    
    //创建View实例
    @IBOutlet weak var inputRect: UITextField!
    @IBOutlet weak var unitPicker: UIPickerView!
    
    //创建Workspace用来接收前台产生的数据
    lazy var myWorkspace = Workspace()
    
    //提交数据到Workspace
    @IBAction func submitData(_ sender: UIButton) {

        
        //TODO: 统一初始单位与最终单位类型一致，不可以出现mole浓度对应重量浓度的情况
        
        if inputRect.text!.isValidNumber()  {
            let input = Float(inputRect.text!)! ?? nil
            if !isVolumeInputState {
                if state == "初始浓度"{
                    var concentration = Concentration(value: input!, unit: unit!, isSubmit: .originally)
                    myWorkspace.updateArguments(concentration)
                    concentration.returnLog()
                } else {
                    var concentration = Concentration(value: input!, unit: unit!, isSubmit: .finally)
                    myWorkspace.updateArguments(concentration)
                    concentration.returnLog()
                }
                if unitLocker[0] == "" {
                    unitLocker[0] = unit!
                }
            } else {
                if state == "初始体积"{
                    var volume = Volume(value: input!, unit: unit!, isSubmit: .originally)
                    volume.isSubmit = .originally
                    myWorkspace.updateArguments(volume)
                    volume.returnLog()
                    
                } else {
                    var volume = Volume(value: input!, unit: unit!, isSubmit: .finally)
                    volume.isSubmit = Submit.originally
                    myWorkspace.updateArguments(volume)
                    volume.returnLog()
                }
                if unitLocker[1] == ""{
                    unitLocker[1] = unit!
                }
            }
        } else {
            //TODO: 弹出输入不符合格式警告
            if inputRect.text! == "" {
                print("input please!")
                
            } else {
                print("It is invalid!")
            }
        }
        //改变按钮展示的文字
        if myWorkspace.dataCount < 3 {
            sender.setTitle("submit", for: UIControl.State.normal)
        } else {
            sender.setTitle("start", for: UIControl.State.normal)
        }
        if sender.title(for: UIControl.State.normal)! == "start" {
            print("\(myWorkspace.getOutcomes().returnLog())")
        }
    }
    
    
    
    
    //创建一个视图用来展示已经提交的数据
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //状态选择框的设置
        statusSelector.delegate = self
        statusSelector.tintColor = UIColor.clear//设置tintColor（光标颜色）为clear隐藏光标
        
        //状态选择框的下拉菜单
        var statusPicker = UIPickerView()
        statusPicker.delegate = self
        statusPicker.dataSource = self
        statusSelector.inputView = statusPicker
        //输入框
        inputRect.delegate = self
        inputRect.clearButtonMode = UITextField.ViewMode.always
        inputRect.textAlignment = .center
        //单位选择器
        unitPicker.delegate = self
        unitPicker.dataSource = self
        
        self.statusPicker = statusPicker
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    //设置单位选择器的行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statusPicker {
            return status.count
        }
        return units.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statusPicker {
            unit = status[row]
            self.state = unit
        } else {
            unit = units[row]
        }
        return unit
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.resignFirstResponder()
        if pickerView == statusPicker {
            if row == 1 || row == 3 {
                isVolumeInputState = true
            } else {
                isVolumeInputState = false
            }
            statusSelector.text = status[row]
            statusSelector.textAlignment = .center
            statusSelector.resignFirstResponder()
        }
    }
}

//在String中填写正则表达式的格式，并定义对象是符合标准的
extension String {
    func isValidNumber() -> Bool{
        var inputRegex: String = "[0-9]+\\.[0-9]+|[0-9]+"
        do {
            let regex = try NSRegularExpression(pattern: inputRegex, options: .caseInsensitive)
            let arrOfRegex = regex.matches(in: self, range: NSMakeRange(0, self.count))
            if arrOfRegex.count != 1 {
                return false
            }
        } catch {
            
        }
        return true
    }
}
