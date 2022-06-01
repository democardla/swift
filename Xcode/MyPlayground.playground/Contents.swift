import Darwin
import Security

var textString = "asdfghj"
let theFirstIndex = textString.startIndex
var randomNumber = Int(arc4random_uniform(UInt32(textString.count)))
var randomIndex = textString.index(textString.startIndex, offsetBy: randomNumber)//格式： String.Index
var triger = textString.reversed()
print(String(triger))

class myClass {
    static var a = 12
    static let b = 10
    static func add() ->Int{
         return 0
     }
}
struct myStruct {
    static var anInt = 0
    
}
