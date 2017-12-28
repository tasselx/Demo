struct Person {
  var name:String
}
struct Book {
  var title:String
  var authors:[Person]
  var primaryAuthor:Person {
    return authors.first!
  }
}

let jobs = Person(name: "Steve Jobs")
let gates = Person(name: "Bill Gates")
let book = Book(title: "Swift 入门到放弃", authors: [jobs,gates])
// 使用 \ 访问key path 也适用于计算属性
book[keyPath: \Book.title]
book[keyPath: \Book.primaryAuthor.name]

let authorKeyPath = \Book.primaryAuthor
type(of: authorKeyPath)

//如果编译器可以推断它，你可以省略类型名
let  nameKeyPath = authorKeyPath.appending(path: \.name)
book[keyPath: nameKeyPath]
//也可以通过下标访问
book[keyPath: \Book.authors[0].name]


import Foundation

class Child: NSObject {

  let name:String
  //设置KVO 必须用 @objc dynamic 修饰
  @objc dynamic var age: Int
  
  init(name: String,age: Int) {
    
    self.name = name
    self.age = age
    super.init()
  }
  
  func celebrateBirthday() {
    age += 1
  }

}

let mia = Child(name: "mia", age: 5)
//设置KVO
let observation = mia.observe(\.age, options: [.initial,.old]) { (child, change) in
  
  if let oldValue = change.oldValue {
    
    print("\(child.name)'s age is from \(oldValue) to \(child.age)")
  }else {
    
    print("\(child.name)'s age is now \(child.age)")
  }
  
}

mia.celebrateBirthday()
//deinit掉监听
observation.invalidate()
//这里不会触发KVO 
mia.celebrateBirthday()








