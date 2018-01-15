
//: [Previous](@previous)

import Foundation

let names = ["Tom",nil,"Fred"]

func doSomething(_ name:String) {
  print(name)
}

for name in names {
  
  if let name = name {doSomething(name)}
}

//flatMap跳过空值
for name in names.flatMap({$0}) {
  doSomething(name)
}

for case let name? in names {
  doSomething(name)
}

for case .some(let name) in names {
  doSomething(name)
}
//解包找到nil值
for case .none in names {
  print("Found nil")
}
//找到指定值
for case "Fred"? in names {
  print("Found Fred")
}

//使用 `where` with `case` 过滤
let scores = [1,5,8,3,10,nil,7]
for case let score? in scores where score > 6 {
  print(score)
}
for score in scores.flatMap({$0}).filter({$0>6}) {
  print(score)
}
