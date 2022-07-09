//
//  myCustomView.swift
//  化学计算器
//
//  Created by DemoCardla on 2022/7/8.
//

import UIKit
///如果把myCustomView.xib文件中的手机外框视图与同名的swift文件关联，那么xib文件就相当于一个storyboard文件，我们可以将里面的控件通过control+拖移在swift文件中进行控件变量的连接



@IBDesignable//可以在storyboard中直接看到创建的对象
class myCustomView: UIControl {
    
    private weak var imageView: UIImageView!
    private var displayImage: UIImage {
         return checked ? UIImage(systemName: "checkmark.circle.fill")! : UIImage(systemName: "circle")!
    }
    
    @IBInspectable//在属性前使用它时，该属性便可以在属性观察器中出现了
    public var checked: Bool = false {
        didSet{
            imageView.image = displayImage
        }
    }

    private func setUp(){
        let ImageRect = CGRect(x: 10, y: 10, width: 50, height: 50)
        //如果控件太小，我们是无法在调试的时候用肉眼看见它的，这需要我们为其设置大小与尺寸:其中width，height是调整控件大小的；x，y是调整控件在View中的位置的，以控件左上的锚点为参照系
        let imageView = UIImageView(frame: ImageRect)
        
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = false
        
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive
        imageView.image = UIImage(systemName: "circle")
        
        imageView.contentMode = .scaleAspectFit

        self.imageView = imageView
        
        //为组件添加响应行为
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        //addRarget("添加一个响应对象","他将要执行的行为是","与哪个UIControl.Event相对应")
        
    }
    
    //@objc func 创建实例方法
    @objc func touchUpInside(){
        checked = !checked
        sendActions(for: .valueChanged)
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

