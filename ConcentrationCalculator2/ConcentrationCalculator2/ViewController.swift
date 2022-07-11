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
    var statusPicker: UIPickerView!
    
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
    let unitsOfConcentration = ["µM", "nM", "M", "X", "µg/L", "ng/L", "mg/L", "g/L"]
    let unitOfVolume = ["µL", "nL", "mL", "L"]
    
    //创建View实例
    @IBOutlet weak var inputRect: UITextField!
    @IBOutlet weak var unitPicker: UIPickerView!
    
    //创建Workspace用来接收前台产生的数据
    lazy var myWorkspace = Workspace()
    //提交数据到Workspace
    @IBAction func submitData(_ sender: UIButton) {
        if myWorkspace.countOfArgumentsAreNotEmpty() < 3 {
            sender.setTitle("submit", for: UIControl.State.normal)
        } else {
            sender.setTitle("start", for: UIControl.State.normal)
        }
        if inputRect.text != "" {
            //TODO: 弹出输入不符合格式警告
            var inputRegex = ""
            do {
                let regex = try NSRegularExpression(pattern: inputRegex, options: .caseInsensitive)
                return regex.matches(in: <#T##String#>, range: <#T##NSRange#>)
            } catch {
                
            }
            let input = Float(inputRect.text!)! ?? nil
            if !isVolumeInputState {
                var concentration = Concentration(concentration: input!, unit: unit!)
                concentration.isSubmit = Submit.originally
                myWorkspace.updateArguments(concentration)
                concentration.returnLog()
            } else {
                var volume = Volume(value: input!, unit: unit!)
                volume.isSubmit = Submit.originally
                myWorkspace.updateArguments(volume)
                volume.returnLog()
            }
            
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


////如何修改UIPickerView的框架大小
//class XX{
//    //在storyboard中创建一个PickerView并将它与代码关联
//    @IBOutlet weak var unitPicker: UIPickerView!
//
//    //在viewDidLoad()方法中加载实例的样式
//    override func viewDidLoad(){
//        super.viewDidLoad()
//        unitPicker.delegate = self
//        unitPicker.dataSource = self
//
//        //用来更改UIPickerView实例大小的方法，更改它的Layer
//        var unitPickerLayer = unitPicker.layer
//        unitPickerLayer.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
//    }
//}
