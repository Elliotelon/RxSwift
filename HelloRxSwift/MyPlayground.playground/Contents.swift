import UIKit
import RxSwift
import RxCocoa

let observable = Observable.just(1)

let observable2 = Observable.of(1,2,3)

let observable3 = Observable.of([1,2,3])

let observable4 = Observable.from([1,2,3,4,5])

observable4.subscribe{ event in
    
    if let element = event.element {
        print(element)
    }
}

observable3.subscribe{ event in
    if let element = event.element {
        print(element)
    }
}

let subscription4 = observable4.subscribe(onNext: { element in
    print(element)
})

subscription4.dispose()

let disposeBag = DisposeBag()

Observable.of("A", "B", "C")
    .subscribe{
        print($0)
    }.disposed(by: disposeBag)

Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()
}.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("completed")}, onDisposed: {print("disposed")})
    .disposed(by: disposeBag)

let publishSubject = PublishSubject<String>()

publishSubject.onNext("Issue 1")

publishSubject.subscribe{ event in
    print(event)
}

publishSubject.onNext("Issue 2")
publishSubject.onNext("Issue 3")

//publishSubject.dispose()

publishSubject.onCompleted()

publishSubject.onNext("Issue 4")

let behaviorSubject = BehaviorSubject(value: "Initial value")

behaviorSubject.onNext("last Issue")

behaviorSubject.subscribe{ event in
    print(event)
}

behaviorSubject.onNext("Issue 1")

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("Issue 1")
replaySubject.onNext("Issue 2")
replaySubject.onNext("Issue 3")
replaySubject.subscribe{
    print($0)
}

replaySubject.onNext("Issue 4")
replaySubject.onNext("Issue 5")
replaySubject.onNext("Issue 6")

print("[Subscription 2]")
replaySubject.subscribe{
    print($0)
}

let relay = BehaviorRelay(value: ["Item 1"])

var value = relay.value
value.append("Item 2")
value.append("Item 3")
relay.accept(value)
//relay.accept(relay.value + ["Item 2"])

relay.asObservable()
    .subscribe{
        print($0)
    }



