//: 'RxSwiftPlayground'
/*: 
If Xcode doesn’t notice the RxSwift import, click on the target and back to the Playground 🤪 
*/

import UIKit
import RxSwift
import RxCocoa

import PlaygroundSupport

// Tell playground to keep on running until we click the stop button
PlaygroundPage.current.needsIndefiniteExecution = true


///
struct Cat {
    var weight: BehaviorSubject<Int>
}

enum MyError: Error {
    case anError
}
let bag = DisposeBag()

let glu = Cat(weight: BehaviorSubject(value: 10))
let lup = Cat(weight: BehaviorSubject(value: 14))

let cat = BehaviorSubject(value: glu)

///
///
let catWeight = cat.flatMap {
    $0.weight.materialize()
}

catWeight
    .filter {
        $0.error == nil
    }
    .dematerialize()
    .subscribe(onNext: { print("Cat weight is \($0)") } )
    .disposed(by: bag)

glu.weight.onNext(11)
glu.weight.onError(MyError.anError)
glu.weight.onNext(12)

cat.onNext(lup)
