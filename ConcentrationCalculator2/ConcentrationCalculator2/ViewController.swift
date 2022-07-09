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
    private var isVolumeInputState = false
    var countOfUnits: Int{
        return isVolumeInputState ? unitOfVolume.count : unitsOfConcentration.count
    }
    var units: [String] {
        return isVolumeInputState ? unitOfVolume : unitsOfConcentration
    }
    let unitsOfConcentration = ["µM", "nM", "M", "X", "µg/L", "ng/L", "mg/L", "g/L"]
    let unitOfVolume = ["µL", "nL", "mL", "L"]
    
    @IBOutlet weak var inputRect: UITextField!
    @IBOutlet weak var unitPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let statuSelector = UITextField()
        statusSelector.delegate = self
        statusPicker.delegate = self
        statusPicker.dataSource = self
        statusSelector.inputView = statusPicker
        
        
        inputRect.delegate = self
        inputRect.clearButtonMode = UITextField.ViewMode.always
        
        unitPicker.delegate = self
        unitPicker.dataSource = self
    }
    
    
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        statusSelector.resignFirstResponder()
        return true
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statusPicker {
            return status.count
        }
        return countOfUnits
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statusPicker {
            return status[row]
        }
        return units[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.resignFirstResponder()
        if pickerView == statusPicker {
            if row == 1 || row == 3 {
                isVolumeInputState = true
            }
            statusSelector.text = status[row]
        }
    }
}
