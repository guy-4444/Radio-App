/*
 import Cocoa

 
 
 
 // https://docs.swift.org/swift-book/LanguageGuide/Closures.html
 func add(number1: Int, number2: Int) -> Int {
     return number1 + number2
 }

 func sub(number1: Int, number2: Int) -> Int {
     return number1 - number2
 }

 func mlt(number1: Int, number2: Int) -> Int {
     return number1 * number2
 }

 func pow2(number1: Int) -> Int {
     return number1 * number1
 }

 add(number1: 6, number2: 2)
 sub(number1: 6, number2: 2)
 mlt(number1: 6, number2: 2)

 func calcStr(number1: Int, number2: Int, myFunc: (Int, Int) -> Int) -> String {
     var result: Int = myFunc(number1, number2)
     return "Result= \(result)"
 }

 calcStr(number1: 6, number2: 2, myFunc: add)
 calcStr(number1: 6, number2: 2, myFunc: sub)
 calcStr(number1: 6, number2: 2, myFunc: mlt)


 func calc(number1: Int, number2: Int, myFunc: (Int, Int) -> Int) -> Int {
     return myFunc(number1, number2)
 }

 calc(number1: 6, number2: 2, myFunc: add)
 calc(number1: 6, number2: 2, myFunc: sub)
 calc(number1: 6, number2: 2, myFunc: mlt)


 func lielClac(number1: Int, number2: Int, func1: (Int, Int) -> Int, func2: (Int, Int) -> Int) -> String {
     var result: Int = func1(number1, number2)
     result = func2(result, result)
     return "Lior Result= \(result)"
 }

 lielClac(number1: 2, number2: 5, func1: mlt, func2: add)


 // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

 /*
 Closure:
  
 func add(number1: Int, number2: Int) -> Int {
     return number1 + number2
 }

  to:
  
 {(number1: Int, number2: Int) -> Int in
     return number1 + number2
 }
 */

 calc(number1: 6, number2: 2, myFunc:
     {(number1: Int, number2: Int) -> Int in
         return number1 + number2
     }
 )

 // Swift knows the type of variables you send to
 calc(number1: 6, number2: 2, myFunc:
     {(number1, number2) -> Int in
         return number1 + number2
     }
 )

 // Swift knows the type of variable he is supposed to return
 calc(number1: 6, number2: 2, myFunc:
     {(number1, number2) in
         return number1 + number2
     }
 )

 // Swift knows he has to return something
 calc(number1: 6, number2: 2, myFunc:
     {(number1, number2) in
         number1 + number2
     }
 )

 // Same in one line
 calc(number1: 6, number2: 2, myFunc:{(number1, number2) in number1 + number2})

 // A dollar sign ($) with a running index is what the function gets
 calc(number1: 6, number2: 2, myFunc:{$0 + $1})

 // If the last parameter is a closure you can trail the closure (closure trailing)
 calc(number1: 6, number2: 2) {$0 + $1}


 // Assign to parameter
 let result = calc(number1: 2, number2: 6) {$0 + $1}


 // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //


 var fibonacci = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

 for i in 2..<fibonacci.count {
     fibonacci[i] = fibonacci[i-2] + fibonacci[i-1]
 }



 // - - - - - - - - - - - - - - - - - - - - - VAT calculation - - - - - - - - - - - - - - - - - - - - - - //

 // Code
 var prices: [Double] = [100, 200, 300, 400, 500]
 for i in 0..<prices.count {
     prices[i] = prices[i] * 1.17
 }

 print("A: \(prices)")



 // Function
 func vatForArray(arr: [Double]) -> [Double] {
     var newArr = [Double](repeating: 0, count: arr.count)

     for i in 0..<arr.count {
         newArr[i] = arr[i] * 1.17
     }
     return newArr
 }

 prices = [100, 200, 300, 400, 500]
 print("B: \(vatForArray(arr: prices))")


 // One by one
 prices = [100, 200, 300, 400, 500]
 func vat(price: Double) -> Double {
     return price * 1.17
 }

 for i in 0..<prices.count {
     prices[i] = vat(price: prices[i])
 }

 print("C: \(prices)")


 // By using Map
 prices = [100, 200, 300, 400, 500]
 print("D: \(prices.map(vat))")




 func tax(d: Double) -> Double {
     return d * 0.8
 }
 prices = [100, 200, 300, 400, 500]
 var newArr1 = prices.map(tax)
 print("E: \(newArr1)")



 var newArr2 = prices.map(
     {(price: Double) -> Double in
         return price * 0.8
     }
 )

 print("F: \(newArr2)")


 var grades = [95, 90, 92, 70, 93, 67]
 var newGrades = grades.map { (x:Int) -> Int in
     return x + 5
 }
 print("G: \(newGrades)")


 var newPercent1: [Double] = grades.map { (x:Int) -> Double in
     Double(x) / 5.2
 }
 print("H: \(newPercent1)")

 var newPercent2: [Double] = grades.map() { Double($0) / 5.2 }
 var newPercent3: [Double] = grades.map { Double($0) / 5.2 }
 var newPercent4 = grades.map { Double($0) / 5.2 }

 print("I: \(newPercent2)")

 */
