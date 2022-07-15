//
//  ViewController.swift
//  ConcentrationCalculator2
//
//  Created by DemoCardla on 2022/7/9.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusSelector: UITextField!
    @IBOutlet weak var outcomeField: UITextField!
    
    var status = ["初始浓度", "初始体积", "最终浓度", "最终体积"]
    var state = "初始浓度"
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
        return isVolumeInputState ? Volume.VolumeUnit : unitsOfConcentration
    }
    //储存当前的单位
    var unit: String?
    
    //单位：以后再放进plist文件里吧
    let unitsOfConcentration = ["nM", "µM", "mM", "M", "X", "ng/L", "µg/L", "mg/L", "g/L"]
    //    let VolumeUnit = ["nL", "µL", "mL", "L"]
    
    //创建View实例
    @IBOutlet weak var inputRect: UITextField!
    @IBOutlet weak var unitPicker: UIPickerView!
    
    //创建Workspace用来接收前台产生的数据
    lazy var myWorkspace = Workspace()
    
    //提交数据到Workspace
    @IBAction func submitData(_ sender: UIButton) {
        if sender.title(for: UIControl.State.normal) == "RESET" {
            myWorkspace = Workspace()
            resetFormat(sender)
        } else {
        //TODO: 统一初始单位与最终单位类型一致，不可以出现mole浓度对应重量浓度的情况
        createObject()
        TextRectDisplay()
        if sender.title(for: UIControl.State.normal) == "Start"{
            getAnswer(sender)
        }
        buttonDisplay(sender)
        if sender.title(for: UIControl.State.normal) == "Start" && outcomeField.text != ""{
            sender.setTitle("RESET", for: UIControl.State.normal)
        }
            
        }
    }
    
    //TODO: 改变按钮展示的文字
    //!!!: 提交与开始计算按钮的展示文字信息切换有问题:注意是因为buttonDisplay()与开始计算两步操作之间没有延迟，以至于按钮没能改变他的title
    func buttonDisplay(_ sender: UIButton) {
        if myWorkspace.CustomUnit == nil {
            if myWorkspace.dataCount < 3 {
                sender.setTitle("Submit", for: UIControl.State.normal)
            } else if myWorkspace.dataCount == 3 {
                sender.setTitle("Set", for: UIControl.State.normal)
                var whichEmpty = myWorkspace.log().firstIndex(of: "null")
                statusSelector.text = status[whichEmpty!]
                if whichEmpty == 0 || whichEmpty == 2 {
                    isVolumeInputState = false
                } else {
                    isVolumeInputState = true
                }
            }
            
        }
        if myWorkspace.CustomUnit != nil{
            sender.setTitle("Start", for: UIControl.State.normal)
        }
    }
    
    func TextRectDisplay() {
        if myWorkspace.dataCount == 3 {
            inputRect.text = "设置结果单位"
            inputRect.textAlignment = .center
            inputRect.clearButtonMode = UITextField.ViewMode.never
            inputRect.isEnabled = false
        }
    }
    
    func createObject() {
        if inputRect.isEnabled == false {
            myWorkspace.CustomUnit = unit!
        } else {
            if inputRect.text!.isValidNumber() {
                let input = Float(inputRect.text!)!
                if !isVolumeInputState {
                    if statusSelector.text == "初始浓度"{
                        var concentration = Concentration(value: input, unit: unit!, isSubmit: .originally)
                        myWorkspace.updateArguments(concentration)
                    } else {
                        var concentration = Concentration(value: input, unit: unit!, isSubmit: .finally)
                        myWorkspace.updateArguments(concentration)
                    }
                    if unitLocker[0] == "" {
                        unitLocker[0] = unit!
                    }
                } else {
                    if statusSelector.text == "初始体积"{
                        var volume = Volume(value: input, unit: unit!, isSubmit: .originally)
                        myWorkspace.updateArguments(volume)
                    }
                    if statusSelector.text == "最终体积"{
                        var volume = Volume(value: input, unit: unit!, isSubmit: .finally)
                        myWorkspace.updateArguments(volume)
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
        }
    }
    
    func getAnswer(_ sender: UIButton){
        
            outcomeField.text = myWorkspace.getOutcomes().returnLog()
            outcomeField.textAlignment = .center
    }
    
    func resetFormat(_ sender: UIButton) {
        sender.setTitle("Submit", for: UIControl.State.normal)
        outcomeField.text = ""
        loadInputRect()
        loadStatusSelector()
    }
    
    //创建一个视图用来展示已经提交的数据
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //状态选择框的设置
        loadStatusSelector()
        //状态选择框的下拉菜单
        var statusPicker = UIPickerView()
        statusPicker.delegate = self
        statusPicker.dataSource = self
        statusSelector.inputView = statusPicker
        //输入框
        loadInputRect()
        //单位选择器
        unitPicker.delegate = self
        unitPicker.dataSource = self
        
        self.statusPicker = statusPicker
    }
    
    func loadInputRect() {
        //输入框
        inputRect.delegate = self
        inputRect.clearButtonMode = UITextField.ViewMode.always
        inputRect.textAlignment = .center
        inputRect.clearsOnBeginEditing = true
        inputRect.text = ""
        inputRect.isEnabled = true
    }
    func loadStatusSelector() {
        //状态选择框的设置
        statusSelector.delegate = self
        statusSelector.tintColor = UIColor.clear//设置tintColor（光标颜色）为clear隐藏光标
        statusSelector.text = "初始浓度"
        statusSelector.textAlignment = .center
        isVolumeInputState = false
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
            self.state = status[row]
            return self.state
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
