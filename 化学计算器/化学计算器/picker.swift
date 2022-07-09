//
//  Picker.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/7/5.
//

///自定义类中在ViewController中的使用：
///1.创建自定义View类文件：由该文件创造的实例是主视图实例
///2.在自定义类文件中重写init方法：用于通过代码调用
///3.添加required init？方法：用于关联view
///4.声明自定义View类文件中所用到的组件，弱引用或强引用创造容器
///5.声明自定义View类文件加载成员的方法：里面包括创建子视图的实例，并将实例添加到主视图的子类中去
///6.将方法中创建的子实例放到自己创建的容器中（第4步），防止过期被释放
///7.为控件设置在主视图中的位置，大小，格式以免无法显示出来

import UIKit
import CoreGraphics

//在stroyboard中渲染声明：当你在ViewController中创建该类的实例时，与ViewController连接的stroyboard就会渲染出类实例
//@IBDesignable


class picker: UIView {
    
    var unitsOfConcentration = ["uM","nM","M"]
    
    //声明文件中用到的组件：声明的实例在没有被调用的情况下是缺省状态
    private weak var myPickerview: UIPickerView!
    private weak var myTextField: UITextField!
    private weak var myImage: UIImageView!
    
    private func setUp(){
        //创建实例
        let myPickerview = UIPickerView()
        let TextRect = CGRect(x: 19, y: 10, width: 30, height: 20)
        let myTextField = UITextField()
//        myTextField.borderStyle = UITextField.BorderStyle.roundedRect
//        myTextField.backgroundColor = UIColor.blue
//        myTextField.clearButtonMode = UITextField.ViewMode.always//输入框是否需要打开清除模式，
        
        let myUIImage = UIImageView()
        
        //是否自适应
        myUIImage.translatesAutoresizingMaskIntoConstraints = false
        myPickerview.translatesAutoresizingMaskIntoConstraints = false
        myTextField .translatesAutoresizingMaskIntoConstraints = false
        
        //将实例放到类实例的下面充当子实例
        addSubview(myUIImage)
        addSubview(myPickerview)
        addSubview(myTextField)
        
        //设置实例的位置大小等参数
        myUIImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive
        myUIImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive
        myUIImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive
        myUIImage.topAnchor.constraint(equalTo: topAnchor).isActive
        myUIImage.image = UIImage(systemName: "checkmark.square.fill")
        
            //PickerView设置
        myPickerview.dataSource = self
        myPickerview.delegate = self
        
            //TextField设置
        myTextField.delegate = self
        
        //为自己创建好的容器赋值，避免方法产生的实例被清除
//        self.myPickerview = myPickerview
//        self.myTextField = myTextField
//        self.myImage = myUIImage
        
    }
    /**
     当我们要使用代码来创建对象时，将会调用此</br>
     调用时可以使用
     <code></code>
     <var XXX: picker = picker()>
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    //当我们在storyboard中添加了一个控件，并且将他的class设置为picker类，storyboard会调用这一个初始化器
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}


//关于UIPickerView的扩展设置
extension picker: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //选择列初始化的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitsOfConcentration.count
    }
    //选择

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitsOfConcentration[row]
    }
    //选择之后的操作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

    //

}

//关于UITextFieldDelegate的扩展设置
extension picker: UITextFieldDelegate {

//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.resignFirstResponder()
//
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
        return true
    }
}

