# Swift学习

## 1、柯里化(Currying)

Swift 里可以将方法进行柯里化 (Currying)，也就是把接受多个参数的方法变换成接受第一个参数的方法，并且返回接受余下的参数并且返回结果的新方法

```
func add(_ v1:Int,_ v2:Int) -> Int {
    return v1 + v2
}
print(add(1, 2))


//柯里化(Currying)
func add(_ v:Int) -> (Int) -> Int {
    return {$0 + v}
}
print(add(1)(2))

```
 
## 2、mutating
Swift 的 `protocol` 不仅可以被 `class `类型实现，也适用于 `struct 和 enum`。

Swift 的 `mutating` 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量，所以如果你没在协议方法里写 ``mutating 的话，别人如果用 struct 或者 enum 来实现这个协议的话，就不能在方法里改变自己的变量了
 
在使用 class 来实现带有 `mutating`的方法的协议时，具体实现的前面是不需要加 `mutating`修饰的，因为 class 可以随意更改自己的成员变量。所以说在协议里用 `mutating`修饰方法，对于 class 的实现是完全透明，可以当作不存在的
 
 ```
 protocol Vehicle {
    var numberOfWheels:Int{get}
    mutating func changeNumberOfWheels()
}

struct MyCar:Vehicle {
    var numberOfWheels: Int = 4
    
    mutating func changeNumberOfWheels() {
        numberOfWheels = 4
    }
}

class Cars: Vehicle {
    var numberOfWheels: Int = 0
    func changeNumberOfWheels() {
        numberOfWheels = 2
    }
}
 ```
 
 ## 3、Sequence
 
 `Sequence` 是一系列相同类型的值的集合，并且提供对这些值的迭代能力。
 
 迭代一个`Sequence`最常见的方式就是 for-in 循环
 ```
 let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]
for animal in animals {
    print(animal)
}
 ```
 
 **Sequence 协议的定义**
 
 ```
 protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    func makeIterator() -> Iterator
}
 ```
 
`Sequence` 协议只有一个必须实现的方法 `makeIterator()`

`makeIterator()` 需要返回一个 `Iterator`，它是一个 `IteratorProtocol` 类型。

也就是说只要提供一个`Iterator` 就能实现一个 `Sequence`，那么 `Iterator` 又是什么呢？
 
 **Iterator**
 Iterator 在 Swift 3.1 标准库中即为 IteratorProtocol，它用来为 Sequence 提供迭代能力。对于 Sequence，我们可以用 for-in 来迭代其中的元素，其实 for-in 的背后是 IteratorProtocol 在起作用
 
 IteratorProtocol 的定义如下：
 ```
 public protocol IteratorProtocol {
    associatedtype Element
    public mutating func next() -> Self.Element?
}
 ```
 
 对于这个`for...in`循环
 ```
  let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]
for animal in animals {
    print(animal)
}
 ```
 
实际上编译器会把以上代码转换成下面的代码
```
var animalIterator = animals.makeIterator()
while let animal = animalIterator.next() {
    print(animal)
}
```
- 1、获取到 animals 数组的 Iterator
- 2、在一个 while 循环中，通过 Iterator 不断获取下一个元素，并对元素进行操作
- 3、当 next() 返回 nil 时，退出循环
 
 **实现一个逆序**
 ```
 //我们先实现一个IteratorProtocol协议类型
class ReverseIterator<T>: IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0

    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    func next() -> Element? {
        if currentIndex < 0{
            return nil
        }
        else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

// 然后我们来定义 Sequence
struct ReverseSequence<T>:Sequence {
    var array:[T]
    init (array: [T]) {
        self.array = array
    }
    typealias Iterator = ReverseIterator<T>
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}

for item in ReverseSequence(array: animals){
    print(item)
}

``` 


 
 [参考：Swift 中的 Sequence（一）](https://www.dazhuanlan.com/2019/10/16/5da640c19e2bc/)
 
 
 ## 4、元组(Tuple)
 
 元组是swift编程语言中唯一的一种复合类型，他可以将指定有限个数的任何类型一次整理为一个对象，元组中的每一种类型都可以是任何的结构体、枚举或类类型，甚至也可以是一个元组以及空元组。
 
比如交换输入，普通程序员亘古以来可能都是这么写的 
```
func swapMel1<T>(a:inout T, b:inout T) {
    let temp = a
    a = b
    b = temp
}
```
 
 但是要是使用多元组的话，我们可以不使用额外空间就完成交换，一下子就达到了文艺程序员的写法
 
 ```
 func swapMel2<T>(a:inout T, b:inout T) {
    (a,b) = (b,a)
}
 ```
 
 
 ## 5、自动闭包(`@autoclosure`)
 
 自动闭包是一种自动创建的用来把作为实际参数传递给函数的表达式打包的闭包。`它不接受任何实际参数`，并且当它被调用时，它会返回内部打包的表达式的值

这个语法的好处在于`通过写普通表达式代替显式闭包而使你省略包围函数形式参数的括号`。
 
```
func getFirstPositive1(_ v1:Int, _ v2:Int) -> Int {
    return v1 > 0 ? v1 : v2
}
getFirstPositive1(1, 2)


func getFirstPositive2(_ v1:Int, _ v2:() -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive2(1, 2) //这个报错
getFirstPositive2(1, {2})

func getFirstPositive3(_ v1:Int, _ v2:@autoclosure () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive3(1, 2)
```

- `@autoclosure`会自动的将2封装为`{2}`

- `@autoclosure`只支持`() -> T`的格式参数

**??**

在 Swift 中，有一个非常有用的操作符，可以用来快速地对 nil 进行条件判断，那就是 `??`。这个操作符可以判断输入并在当左侧的值是非 nil 的 Optional 值时返回其 value，当左侧是 nil 时返回右侧的值  

`??`就是一个`@autoclosure`
```
public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T) rethrows -> T
```
 
我们来猜测一下`??`的实现
 
 ```
 func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    switch optional {
        case .Some(let value):
            return value
        case .None:
            return defaultValue()
        }
}
 ```
 
 可能你会有疑问，为什么这里要使用`autoclosure`，直接接受`T` 作为参数并返回不行么，为何要用 `() -> T` 这样的形式包装一遍，岂不是画蛇添足？其实这正是 `autoclosure` 的一个最值得称赞的地方。如果我们直接使用` T`，那么就意味着在 `??` 操作符真正取值之前，我们就必须准备好一个默认值传入到这个方法中，一般来说这不会有很大问题，但是如果这个默认值是通过一系列复杂计算得到的话，可能会成为浪费 -- 因为其实如果`optional` 不是 `nil` 的话，我们实际上是完全没有用到这个默认值，而会直接返回` optional` 解包后的值的。这样的开销是完全可以避免的，方法就是将默认值的计算推迟到 `optional` 判定为 `nil` 之后 
 
 
 在 Swift 中，其实 `&&` 和 `||` 这两个操作符里也用到了 `@autoclosure` 
 ```
 public static func && (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool
 
 public static func || (lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool
 ```
 
 ## 6、逃逸闭包(@escaping )与非逃逸闭包(@noescaping)
 
 **逃逸闭包(@escaping )**

当闭包作为一个实际参数传递给一个函数的时候，我们就说这个闭包逃逸了，因为它是在函数返回之后调用的。当你声明一个接受闭包作为形式参数的函数时，你可以在形式参数前写 `@escaping` 来明确闭包是允许逃逸的。

闭包可以逃逸的一种方法是`被储存在定义于函数外的变量里`。比如说，很多函数接收闭包实际参数来作为启动异步任务的回调。函数在启动任务后返回，但是闭包要直到任务完成——闭包需要逃逸，以便于稍后调用



例如：当网络请求结束后调用的闭包。发起请求后过了一段时间后这个闭包才执行，并不一定是在函数作用域内执行的


```
override func viewDidLoad() {
        super.viewDidLoad()
         
        getData { (data) in
            print("闭包返回结果：\(data)")
        }
    }

    func getData(closure:@escaping (Any) -> Void) {
        print("函数开始执行--\(Thread.current)")
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                print("执行了闭包---\(Thread.current)")
                closure("345")
            })
        }
        print("函数执行结束---\(Thread.current)")
    }
```


![](https://user-gold-cdn.xitu.io/2020/3/25/1710fd44ffb9bf98?w=593&h=85&f=png&s=7578)

从结果可以看出，逃逸闭包的生命周期是长于函数的。

逃逸闭包的生命周期：
- 1、闭包作为参数传递给函数；
- 2、退出函数；
- 3、闭包被调用，闭包生命周期结束

即逃逸闭包的生命周期长于函数，函数退出的时候，逃逸闭包的引用仍被其他对象持有，不会在函数结束时释放。


**非逃逸闭包(@noescaping)**

一个接受闭包作为参数的函数， 闭包是在这个函数结束前内被调用。

```
    override func viewDidLoad() {
        super.viewDidLoad()
         
        handleData { (data) in
            print("闭包返回结果:\(data)")
        }
    }

    func handleData(closure:(Any) -> Void) {
        print("函数开始执行--\(Thread.current)")
        print("执行了闭包---\(Thread.current)")
        closure("123")
        print("函数执行结束---\(Thread.current)")
    }
```

![](https://user-gold-cdn.xitu.io/2020/3/25/1710fd450002438f?w=596&h=93&f=png&s=8124)



**为什么要分逃逸闭包和非逃逸闭包**

为了管理内存，闭包会强引用它捕获的所有对象，比如你在闭包中访问了当前控制器的属性、函数，编译器会要求你在闭包中显示 self 的引用，这样闭包会持有当前对象，容易导致循环引用。

非逃逸闭包不会产生循环引用，它会在函数作用域内释放，编译器可以保证在函数结束时闭包会释放它捕获的所有对象；使用非逃逸闭包的另一个好处是编译器可以应用更多强有力的性能优化，例如，当明确了一个闭包的生命周期的话，就可以省去一些保留（retain）和释放（release）的调用；此外非逃逸闭包它的上下文的内存可以保存在栈上而不是堆上。

 

 
 ## 7、操作符
 

 与 Objective-C 不同，Swift 支持重载操作符这样的特性，最常见的使用方式可能就是定义一些简便的计算了 
 
 ### 系统操作符
 
 比如我们需要一个表示二维向量的数据结构 
 
 ```
 struct Vector2D {
    var x:CGFloat = 0
    var y:CGFloat = 0
}
 ```
 
 
 一个很简单的需求是两个 Vector2D 相加 
 ```
let v1 = Vector2D(x: 2.0, y: 3.0)
let v2 = Vector2D(x: 1.0, y: 4.0)
let v3 = Vector2D(x: v1.x + v2.x, y: v1.y + v2.y)  
 ```
 
 如果只做一次的话似乎还好，但是一般情况我们会进行很多这种操作。这样的话，我们可能更愿意定义一个 Vector2D 相加的操作，来让代码简化清晰 
 
 ```
 func +(left:Vector2D,right:Vector2D) -> Vector2D {
    Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let v3 = v1 + v2
 ```
 
 
 ### 8、自定义操作符
 
 在Swift语言中,常见的操作符有+、-、*、/、>、<、==、&&、||等等，如果不喜欢，你也可以定义自己喜欢的操作符。
 
 - `precedencegroup`：定义操作符的优先级
 - `associativity`：操作符的结合律
 - `higherThan`、`lowerThan`：运算符的优先级
 - `prefix、infix、postfix`：前缀、中缀、后缀运算符
 
 
 **中缀**
 
```
/// 定义优先级组
precedencegroup MyPrecedence {
    // higherThan: AdditionPrecedence   // 优先级,比加法运算高
    lowerThan: AdditionPrecedence       // 优先级, 比加法运算低
    associativity: none                 // 结合方向:left, right or none
    assignment: false                   // true=赋值运算符,false=非赋值运算符
}

infix operator +++: MyPrecedence        // 继承 MyPrecedence 优先级组
// infix operator +++: AdditionPrecedence // 也可以直接继承加法优先级组(AdditionPrecedence)或其他优先级组
func +++(left: Int, right: Int) -> Int {
    return left+right*2
}
 
print(2+++3) // 8
```
 
 
 **前缀**
 
 ```
 prefix operator ==+
prefix func ==+(left: Int) -> Int {
    
    return left*2
}
print(==+2) // 4
 ```
 
 **后缀**
 ```
 postfix operator +==
postfix func +==(right: Int) -> Int {
    
    return right*3
}
print(2+==) // 6
 ```
 
 
 ## 9、`inout`:输入输出参数
 
 
 可变形式参数只能在函数的内部做改变。如果你想函数能够修改一个形式参数的值，而且你想这些改变在函数结束之后依然生效，那么就需要将形式参数定义为输入输出形式参数。

在形式参数定义开始的时候在前边添加一个 `inout`关键字可以定义一个输入输出形式参数。输入输出形式参数有一个能输入给函数的值，函数能对其进行修改，还能输出到函数外边替换原来的值。

你只能把变量作为输入输出形式参数的实际参数。你不能用常量或者字面量作为实际参数，因为常量和字面量不能修改。在将变量作为实际参数传递给输入输出形式参数的时候，直接在它前边添加一个和符号 (` &`) 来明确可以被函数修改。
 
 ```
 var b = 10
func test(a:inout Int) {
    a = 20
}
test(a: &b)
print(b) //20
 ```
 
 
 可以用inout定义一个输入输出参数：可以在函数内部修改外部实参的值

- 1、不可变参数不能标记为`inout`
- 2、`inout`参数不能有默认值
- 3、`inout`参数只能传入可以被多次赋值的
- 4、`inout`参数的本质就是地址传递
 
 
 
 ## 10、下标
 
 下标相信大家都很熟悉了，在绝大多数语言中使用下标来读写类似数组或者是字典这样的数据结构的做法，似乎已经是业界标准。在 Swift 中，Array 和 Dictionary 当然也实现了下标读写 

```
var arr = [1,2,3]
arr[2]            // 3
arr[2] = 4        // arr = [1,2,4]

var dic = ["cat":"meow", "goat":"mie"]
dic["cat"]          // {Some "meow"}
dic["cat"] = "miao" // dic = ["cat":"miao", "goat":"mie"]  
```
 
作为一门代表了先进生产力的语言，Swift 是允许我们自定义下标的,我们找到`Array`已经支持的下标类型
```
subscript (index: Int) -> T
subscript (subRange: Range<Int>) -> Slice<T>
```
 
 我们发现如果我们想要取出`0、2、4`下标值，我们需要循环枚举。
 
 其实这里有一个更好的做法，比如可以实现一个接受数组作为下标输入的读取方法
 
 ```
 extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index,i) in input.enumerated() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var arr = ["a","b","c","d","z"]
print(arr[[0,3]]) //["a", "d"]
 ```
 
## 11、嵌套函数 
 
我们可以把函数当成参数或者变量来使用，函数内部嵌套函数
```
func forward(_ forward:Bool) -> (Int) -> Int {
    
    func next(_ input:Int) -> Int {
        input + 1
    }

    func previous(_ input:Int) -> Int {
        input - 1
    }
    
    return forward ? next : previous
}
```

 ## 12、命名空间
 
 Objective-C 一个一直以来令人诟病的地方就是没有命名空间，在应用开发时，所有的代码和引用的静态库最终都会被编译到同一个域和二进制中。这样的后果是一旦我们有重复的类名的话，就会导致编译时的冲突和失败。为了避免这种事情的发生，Objective-C 的类型一般都会加上两到三个字母的前缀，比如 Apple 保留的 NS 和 UI 前缀，各个系统框架的前缀 SK (StoreKit)，CG (CoreGraphic) 等。Objective-C 社区的大部分开发者也遵守了这个约定，一般都会将自己名字缩写作为前缀，把类库命名为 AFNetworking 或者 MBProgressHUD 这样。这种做法可以解决部分问题，至少我们在直接引用不同人的库时冲突的概率大大降低了，但是前缀并不意味着不会冲突，有时候我们确实还是会遇到即使使用前缀也仍然相同的情况。另外一种情况是可能你想使用的两个不同的库，分别在它们里面引用了另一个相同的很流行的第三方库，而又没有更改名字。在你分别使用“这两个库中的一个时是没有问题的，但是一旦你将这两个库同时加到你的项目中的话，这个大家共用的第三方库就会和自己发生冲突了。

在 Swift 中，由于可以使用命名空间了，即使是名字相同的类型，只要是来自不同的命名空间的话，都是可以和平共处的。和 C# 这样的显式在文件中指定命名空间的做法不同，Swift 的命名空间是基于 module 而不是在代码中显式地指明，每个 module 代表了 Swift 中的一个命名空间。也就是说，同一个 target 里的类型名称还是不能相同的。在我们进行 app 开发时，默认添加到 app 的主 target 的内容都是处于同一个命名空间中的，我们可以通过创建 Cocoa (Touch) Framework 的 target 的方法来新建一个 module，这样我们就可以在两个不同的 target 中添加同样名字的类型了 
 
 
 ## 13、typealias别名
 
 我们可以给一个复杂的难以理解的类型起一个别名，方便我们使用和理解
 
 按照swift标准库的定义`Void`就是一个空元组
 ```
 public typealias Void = ()
 ```
 我们知道swift中没有`byte、short、Long`类型，如果我们想要这样的类型，就可以用`typealias`实现
 
 ```
typealias Byte = Int8
typealias Short = Int16
typealias Long = Int64
 ```
 
 我们还可以给函数起一个别名
 
 ```
 typealias IntFn = (Int,Int) -> Int
func difference(v1:Int,v2:Int) -> Int {
    v1 - v2
}
let fn:IntFn = difference
print(fn(2,1))  //1
 ```
 
 我们还可以给元组起别名
 ```
 typealias Date = (year:Int,month:Int,day:Int)
func test(_ date:Date) {
    print(date.year)
}
test((2019,10,30))
 ```
 
 ## 14、associatedtype
 
 我们在 Swift 协议中可以定义属性和方法，并要求满足这个协议的类型实现它们： 
 ```
protocol Food { }

protocol Animal {
    func eat(_ food: Food)
}

struct Meat: Food { }
struct Grass: Food { }
 ```
 
 
 ```
 struct Tiger: Animal {
    func eat(_ food: Food) {

    }
}
 ```
 
 因为老虎并不吃素，所以在 Tiger 的 eat 中，我们很可能需要进行一些转换工作才能使用 meat 
 
 
 `associatedtype` 声明中可以使用冒号来指定类型满足某个协议 
 
 ```
 protocol Animal {
    associatedtype F: Food
    func eat(_ food: F)
}

struct Tiger: Animal {
    func eat(_ food: Meat) {
        print("eat \(meat)")
    }
}

struct Sheep: Animal {
    func eat(_ food: Grass) {
        print("eat \(food)")
    }
} 
 ```
 
 
 
 不过在添加`associatedtype` 后，`Animal` 协议就不能被当作独立的类型使用了。试想我们有一个函数来判断某个动物是否危险： 
 ```
 func isDangerous(animal: Animal) -> Bool {
    if animal is Tiger {
        return true
    } else {
        return false
    }
}
 ```
 
 会报错
 
 > Protocol 'Animal' can only be used as a generic constraint because it has Self or associated type requirements
 
 
 这是因为 Swift 需要在编译时确定所有类型，这里因为 `Animal` 包含了一个不确定的类型，所以随着 `Animal` 本身类型的变化，其中的` F` 将无法确定 (试想一下如果在这个函数内部调用 `eat `的情形，你将无法指定 eat 参数的类型)。在一个协议加入了像是 `associatedtype` 或者 `Self` 的约束后，它将只能被用为泛型约束，而不能作为独立类型的占位使用，也失去了动态派发的特性。也就是说，这种情况下，我们需要将函数改写为泛型  
 
 ```
func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Tiger {
        return true
    } else {
        return false
    }
}

isDangerous(animal: Tiger()) // true
 ```
 
 ## 15、可变参数
 
 一个可变形式参数可以接受零或者多个`特定类型的值`,可变参数必须是同一类型的。当调用函数的时候你可以利用可变形式参数来声明形式参数可以被传入值的数量是可变的。可以通过在形式参数的类型名称后边插入三个点符号（`...`）来书写可变形式参数。
 
 ```
 func sum(_ numbers:Int...) -> Int{
    var total = 0
    for item in numbers {
        total += item
    }
    return total
}
 ```
 
 **Swift自带的print函数**
 
 ```
 /// - Parameters:
///   - items: Zero or more items to print.
///   - separator: A string to print between each item. The default is a single
///     space (`" "`).
///   - terminator: The string to print after all items have been printed. The
///     default is a newline (`"\n"`).
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n")
 ```
- 1、第一个参数：就是需要打印的值，是一个可变参数
- 2、第二个参数：两个打印值连接的地方，默认是空格
- 3、第三个参数：结尾默认是\n换行
 
 
 
 ## 16、初始化
 
 初始化是为类、结构体或者枚举准备实例的过程。`这个过需要给实例里的每一个存储属性设置一个初始值并且在新实例可以使用之前执行任何其他所必须的配置或初始化`

你通过定义初始化器来实现这个初始化过程，它更像是一个用来创建特定类型新实例的特殊的方法。不同于 Objective-C 的初始化器，Swift 初始化器不返回值。这些初始化器主要的角色就是确保在第一次使用之前某类型的新实例能够正确初始化。

类有两种初始化器

- 1、指定初始化器(designated initializer)
- 2、便捷初始化器(convenience initializer)
 
 ```
 class Person {
    var age: Int
    var name: String
    
    //指定初始化器
    init(age:Int, name:String) {
        self.age = age
        self.name = name
    }
    //便捷初始化器
    convenience init(age:Int){
        self.init(age:age,name:"")
    }
}
 ```
 
- 1、每一个类至少有一个指定初始化器，指定初始化器是类的最主要初始化器
- 2、默认初始化器总是类的指定初始化器
- 3、类偏向于少量指定初始化器，一个类通常就只有一个指定初始化器
 
 **初始化器的相互调用规则**
 
- 1、指定初始化器必须从他的直系父类调用指定初始化器
- 2、便捷初始化器必须从相同的类里调用另一个初始化器
- 3、便捷初始化器最终必须调用一个指定初始化器
 
 
 ## 17、Static & Class

Swift 中表示 “类型范围作用域” 这一概念有两个不同的关键字，它们分别是 `static` 和 `class`。这两个关键字确实都表达了这个意思 

在`非class`的类型上下文中，我们统一使用 `static` 来描述类型作用域 


## 18、default 参数

Swift 的方法是支持默认参数的，也就是说`在声明方法时，可以给某个参数指定一个默认使用的值`。在调用该方法时要是传入了这个参数，则使用传入的值，如果缺少这个输入参数，那么直接使用设定的默认值进行调用 

```
func test(a:String = "1",b:String,c:String = "3"){}
```

## 19、匹配模式

**什么是模式**
模式是用于匹配的规则，比如`switch`的`case`、捕获错误的`catch`、`if\guard\while\for`语句


**Swift中模式有**
- 1、通配符模式(Wildcard Pattern)
- 2、标识符模式(Identifier Pattern)
- 3、值绑定模式(Value-Binding Pattern)
- 4、元祖模式(Tuple Pattern)
- 5、枚举Case模式(Enumeration Case Pattern)
- 6、可选模式(Optional Pattern)
- 7、类型转换模式(Type-Casting Pattern)
- 8、表达式模式(Expression Pattern)


### 通配符模式(Wildcard Pattern)

- `_` 匹配任何值 
- `_?`匹配非nil值


```
enum Life {
    case human(name:String,age:Int?)
    case animal(name:String,age:Int?)
}

func check(_ life:Life){
    switch life {
    case .human(let name,_):
        print("human:",name)
    case .animal(let name,_?):
        print("animal",name)
    default:
        print("other")
        break
    }
}

check(.human(name: "小明", age: 20)) //human: 小明
check(.human(name: "小红", age: nil))//human: 小红
check(.animal(name: "dog", age: 5))//animal dog
check(.animal(name: "cat", age: nil))//other
```

### 标识符模式(Identifier Pattern)

就是给对应的变量常亮赋值
```
let a = 10
let b = "text"
```

### 值绑定模式(Value-Binding Pattern)

```
let point = (2,3)
switch point {
case (let x,let y):
    print("x:\(x)  y:\(y)")
}
//x:2  y:3

```

### 元祖模式(Tuple Pattern)

匹配任何元祖
```
let point = [(0,0),(1,0),(2,0)]
for (x,_) in point{
    print(x)
}
//0
//1
//2
```

### 枚举Case模式(Enumeration Case Pattern)

`if case`语句等价于一个`case`的`switch`语句，简化了一些判断语句

```
let age = 2
//if
if age >= 0 && age <= 9 {
    print("[0,9]")
}
//枚举模式
if case 0...9 = age{
    print("[0,9]")
}
```

```
let ages:[Int?] = [2,3,nil,5]
for case nil in ages{
    print("有nil值")
}
```


### 可选模式(Optional Pattern)

```
let ages:[Int?] = [nil,2,3,nil]
for case let age? in ages{
    print(age)
}
// 2
//3
```

等价于
```
let ages:[Int?] = [nil,2,3,nil]
for item in ages{
    if let age = item {
        print(age)
    }
}

```


### 类型转换模式(Type-Casting Pattern)

```
class Animal {
    func eat() {
        print(type(of: self),"eat")
    }
}

class Dog: Animal {
    func run() {
        print(type(of: self),"run")
    }
}

class Cat: Animal {
    func jump() {
        print(type(of: self),"jump")
    }
}

func check(_ animal:Animal) {
    switch animal {
    case let dog as Dog:
        dog.run()
        dog.eat()
    case is Cat:
        animal.eat()
    default:
        break
    }
}
check(Dog())
//Dog run
//Dog eat
check(Cat())
//Cat eat
```
### 表达式模式(Expression Pattern)

可以通过重载运算符，自定义表达式模式的匹配规则

```
struct Student {
    var score = 0, name = ""
    static func ~=(pattern:Int,value:Student) -> Bool{
        value.score >= pattern
    }
    
    static func ~=(pattern:ClosedRange<Int>,value:Student) -> Bool{
        pattern.contains(value.score)
    }
    static func ~=(pattern:Range<Int>,value:Student) -> Bool{
        pattern.contains(value.score)
    }
    
}
var stu = Student(score: 81, name: "tom")
switch stu{
case 100:print(">=100")
case 90:print(">=90")
case 80..<90:print("[80,90]")
case 60...79:print("[60,79]")
default:break
}
```


```
extension String{
    static func ~=(pattern:(String) -> Bool,value:String) ->Bool{
        pattern(value)
    }
}

func hasPrefix(_ prefix:String) ->((String) -> Bool){{$0.hasPrefix(prefix)}}
func hasSuffix(_ prefix:String) ->((String) -> Bool){{$0.hasSuffix(prefix)}}



var str = "jack"
switch str {
case hasPrefix("j"),hasSuffix("k"):
    print("以j开头，或者以k结尾")
default:
    break
}
```


## 20、... 和 ..<

Range 操作符，用来简单地指定一个从 X 开始连续计数到 Y 的范围 

我们可以仔细看看 Swift 中对着两个操作符的定义  

```
/// Forms a closed range that contains both `minimum` and `maximum`.
func ...<Pos : ForwardIndexType>(minimum: Pos, maximum: Pos)
        -> Range<Pos>

/// Forms a closed range that contains both `start` and `end`.
/// Requres: `start <= end`
func ...<Pos : ForwardIndexType where Pos : Comparable>(start: Pos, end: Pos)
        -> Range<Pos>


/// Forms a half-open range that contains `minimum`, but not
/// `maximum`.
func ..<<Pos : ForwardIndexType>(minimum: Pos, maximum: Pos)
        -> Range<Pos>

/// Forms a half-open range that contains `start`, but not
/// `end`.  Requires: `start <= end`
func ..<<Pos : ForwardIndexType where Pos : Comparable>(start: Pos, end: Pos)
        -> Range<Pos>


/// Returns a closed interval from `start` through `end`
func ...<T : Comparable>(start: T, end: T) -> ClosedInterval<T>
  
  
 /// Returns a half-open interval from `start` to `end`
func ..<<T : Comparable>(start: T, end: T) -> HalfOpenInterval<T>  
```

不难发现，其实这几个方法都是支持泛型的。除了我们常用的输入 Int 或者 Double，返回一个 Range 以外，这个操作符还有一个接受 Comparable 的输入，并返回 ClosedInterval 或 HalfOpenInterval 的重载 

比如想确认一个单词里的全部字符都是小写英文字母的话，可以这么做 

```
let test = "helLo"
let interval = "a"..."z"
for c in test {
    if !interval.contains(String(c)) {
        print("\(c) 不是小写字母")
    }
}

// 输出
// L 不是小写字母
```

## 21、AnyClass，元类型和 .self

在 Swift 中能够表示 “任意” 这个概念的除了 Any 和 AnyObject 以外，还有一个 `AnyClass`。`AnyClass` 在 Swift 中被一个 `typealias` 所定义 

```
public typealias AnyClass = AnyObject.Type
```

通过 `AnyObject.Type` 这种方式所得到是一个元类型 `(Meta)`。在声明时我们总是在类型的名称后面加上 `.Type`，比如 `A.Type` 代表的是 `A 这个类型的类型`。也就是说，我们可以声明一个元类型来存储 A 这个类型本身，而在从A中取出其类型时，我们需要使用到 `.self` 

> 其实在 Swift 中，.self 可以用在类型后面取得类型本身，也可以用在某个实例后面取得这个实例本身。前一种方法可以用来获得一个表示该类型的值，这在某些时候会很有用；而后者因为拿到的实例本身 


```
class A {
    class func method() {
        print("Hello")
    }
}

let typeA: A.Type = A.self
typeA.method()

// 或者
let anyClass: AnyClass = A.self
(anyClass as! A.Type).method() 
```


也许你会问，这样做有什么意义呢，我们难道不是可以直接使用 A.method() 来调用么？没错，对于单个独立的类型来说我们完全没有必要关心它的元类型，但是元类型或者元编程的概念可以变得非常灵活和强大，这在我们编写某些框架性的代码时会非常方便。比如我们想要传递一些类型的时候，就不需要不断地去改动代码了。在下面的这个例子中虽然我们是用代码声明的方式获取了 MusicViewController 和 AlbumViewController 的元类型，但是其实这一步骤完全可以通过读入配置文件之类的方式来完成的。而在将这些元类型存入数组并且传递给别的方法来进行配置这一点上，元类型编程就很难被替代了 


```
class MusicViewController: UIViewController {

}

class AlbumViewController: UIViewController {

}

let usingVCTypes: [AnyClass] = [MusicViewController.self,
    AlbumViewController.self]

func setupViewControllers(_ vcTypes: [AnyClass]) {
    for vcType in vcTypes { 
            if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init()
            print(vc)
        }

    }
}

setupViewControllers(usingVCTypes) 
```

这么一来，我们完全可以搭好框架，然后用 DSL 的方式进行配置，就可以在不触及 Swift 编码的情况下，很简单地完成一系列复杂操作了 


## 22、动态类型


Swift 中我们虽然可以通过 dynamicType 来获取一个对象的动态类型 (也就是运行时的实际类型，而非代码指定或编译器看到的类型)。但是在使用中，Swift 现在却是不支持多方法的，也就是说，`不能根据对象在动态时的类型进行合适的重载方法调用`


```
class Pet {}
class Dog:Pet {}
class Cat:Pet {}
 
func eat(_ pet:Pet) {
    print("pet eat")
}

func eat(_ dog:Dog) {
    print("dog eat")
}

func eat(_ cat:Cat) {
    print("cat eat")
}
 
func eats(_ pet:Pet,_ cat:Cat) {
    eat(pet)
    eat(cat)
}
eats(Dog(), Cat())
//pet eat
//cat eat
```

我们在打印`Dog`类型信息的时候，并没有被用来在运行时选择合适的`func eat(_ dog:Dog) {}`方法，而是被忽略了，并采用了编译期间决定的`Pet`方法。

因为 Swift 默认情况下是不采用动态派发的，因此方法的调用只能在编译时决定 

要想绕过这个限制，我们可能需要进行通过对输入类型做判断和转换 

```
func eats(_ pet:Pet,_ cat:Cat) {
    if let aCat = pet as? Cat {
        eat(aCat)
    }else if let aDog = pet as? Cat{
        eat(aDog)
    }
    eat(cat)
}
```




## 23、属性

在Swift中所声明的属性包括
- 1、存储属性：存储属性将会在内存中实际分配地址进行属性的存储
- 2、计算属性：计算属性则不包括存储，只是提供`set`和`get`方法

### 存储属性

我们可以在存储属性中提供了`willSet`和`didSet`两种属性观察方法

```
class Person {
    var age:Int = 0{
        willSet{
            print("即将将年龄从\(age)设置为\(newValue)")
        }
        didSet{
            print("已经将年龄从\(oldValue)设置为\(age)")
        }
    }
}

let p = Person()
p.age = 10
//即将将年龄从0设置为10
//已经将年龄从0设置为10

```


在`willSet`和`didSet`中我们分别可以使用`newValue`和`oldValue` 来获取将要设定的和已经设定的值。 

>初始化方法对属性的设定，以及在 willSet 和 didSet 中对属性的再次设定都不会再次触发属性观察的调用 


### 计算属性

在 Swift 中所声明的属性包括`存储属性`和`计算属性`两种。其中存储属性将会在内存中实际分配地址对属性进行存储，而计算属性则不包括背后的存储，只是提供` set `和 `get` 两种方法。在同一个类型中，`属性观察和计算属性是不能同时共存的`。也就是说，想在一个属性定义中同时出现 `set` 和 `willSet` 或` didSet` 是一件办不到的事情。

计算属性中我们可以通过改写 `set` 中的内容来达到和` willSet` 及 `didSet` 同样的属性观察的目的。`如果我们无法改动这个类，又想要通过属性观察做一些事情的话，可能就需要子类化这个类，并且重写它的属性`

重写的属性并不知道父类属性的具体实现情况，而只从父类属性中继承名字和类型，因此在子类的重载属性中我们是可以对父类的属性任意地添加属性观察的，而不用在意父类中到底是存储属性还是计算属性 

```
class A {
    var number:Int {
        get{
            print("get")
            return 1
        }
        set{
            print("set")
        }
    }
}

class B:A {
    override var number: Int{
        willSet{
            print("willSet")
        }
        didSet{
            print("didSet")
        }
    }
}

let b = B()
b.number = 10

get
willSet
set
didSet
```

`set` 和对应的属性观察的调用都在我们的预想之中。这里要注意的是 `get` 首先被调用了一次。这是因为我们实现了 `didSet`，`didSet` 中会用到 `oldValue`，而这个值需要在整个 `set` 动作之前进行获取并存储待用，否则将无法确保正确性。如果我们不实现 `didSet` 的话，这次 `get`操作也将不存在。 

## 24、lazy修饰符

延时加载或者说延时初始化是很常用的优化方法，在构建和生成新的对象的时候，内存分配会在运行时耗费不少时间，如果有一些对象的属性和内容非常复杂的话，这个时间更是不可忽略。另外，有些情况下我们并不会立即用到一个对象的所有属性，而默认情况下初始化时，那些在特定环境下不被使用的存储属性，也一样要被初始化和赋值，也是一种浪费 

swift提供了一个关键字`lazy`

```
class A {
    lazy var str:String = {
        let str = "Hello"
        print("首次访问的时候输出")
        return str
    }()
}

let a = A()
print(a.str)
```

为了简化，我们如果不需要做什么额外工作的话，也可以对这个 lazy 的属性直接写赋值语句 
```
lazy var str1 = "word"
```



## 25、Reflection 和 Mirror

Objective-C 中我们不太会经常提及到 “反射” 这样的词语，因为 Objective-C 的运行时比一般的反射还要灵活和强大。可能很多读者已经习以为常的像是通过字符串生成类或者 selector，并且进而生成对象或者调用方法等，其实都是反射的具体的表现。而在 Swift 中其实就算抛开 Objective-C 的运行时的部分，在纯 Swift 范畴内也存在有反射相关的一些内容，只不过相对来说功能要弱得多。

Swift提供了`Mirror`类型来做映射的事情
```
struct Person {
    let name:String
    let age:Int
}

let xiaoming = Person(name: "小明", age: 10)
let r = Mirror(reflecting: xiaoming)

print("xiaoming是\(r.displayStyle)")
print("属性个数：\(r.children.count)")

for child in r.children{
    print("属性名:\(child.label) 值：\(child.value)")
}


xiaoming是Optional(Swift.Mirror.DisplayStyle.struct)
属性个数：2
属性名:Optional("name") 值：小明
属性名:Optional("age") 值：10
```


通过 `Mirror` 初始化得到的结果中包含的元素的描述都被集合在` children` 属性下 

```
public typealias Child = (label: String?, value: Any)
public typealias Children = AnyCollection<Mirror.Type.Child> 
```

如果觉得一个个打印太过于麻烦，我们也可以简单地使用 dump 
方法来通过获取一个对象的镜像并进行标准输出的方式将其输出出来 

```
print(dump(xiaoming))

▿ 反射.Person
  - name: "小明"
  - age: 10
Person(name: "小明", age: 10)
```

常见的应用场景是类似对 Swift 类型的对象做像 Objective-C 中 KVC 那样的 valueForKey: 的取值。通过比较取到的属性的名字和我们想要取得的 key 值就行了，非常简单 

```
func valueFrom(_ object: Any, key: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    for child in mirror.children {
        let (targetKey, targetMirror) = (child.label, child.value)
        if key == targetKey {
            return targetMirror
        }
    }
    return nil
}


if let name = valueFrom(xiaoming, key: "name") as? String {
    print("通过 key 得到值: \(name)")
}

通过 key 得到值: 小明
```

>在现在的版本中，Swift 的反射特性并不是非常强大，我们只能对属性进行读取，还不能对其设定。 另外需要特别注意的是，虽然理论上将反射特性应用在实际的 app 制作中是可行的，但是这一套机制设计的最初目的是用于 REPL 环境和 Playground 中进行输出的。所以我们最好遵守 Apple 的这一设定，只在 REPL 和 Playground 中用它来对一个对象进行深层次的探索，而避免将它用在 app 制作中 -- 因为你永远不知道什么时候它们就会失效或者被大幅改动  



## 26、可选值(optional)


我们点击进入官方文档，可以看到`optional`是一个枚举
```
enum Optional<Wrapped> : ExpressibleByNilLiteral {
    case none
    case some(Wrapped)
    public init(_ some: Wrapped)
}
```
我们来看看下面这两个值是否相同`anotherString  literalString`
```
var string:String? = "string"
var anotherString:String?? = string
var literalString:String?? = "string"

print(anotherString)
print(literalString)
print(anotherString == literalString)

//Optional(Optional("string"))
//Optional(Optional("string"))
//true
```

- 1、`var anotherString:String?? = string`的写法其实就是`Optional.some(string)`
- 2、`var literalString:String?? = "string"`的写法是`Optional.some(Optional.some("string"))`

两者的返回值是一样的，所以两者相等

下面两个对象是否相等呢?
```
var aNil:String? = nil
var anoterNil:String?? = aNil
var literalNil:String?? = nil
print(anoterNil)
print(literalNil)
print(anoterNil == literalNil)
//Optional(nil)
//nil
//false
```

 - 1、`anoterNil`是可选项里面包含一个可选项值为`nil`的可选项
 - 2、`literalNil`是可选择值为`nil`的可选项


我们可以使用`fr v -R`来打印具体信息

![1](https://user-gold-cdn.xitu.io/2020/4/1/17135a0c5676fdad?w=720&h=540&f=png&s=52626)



## 27、匹配模式

**什么是模式**
模式是用于匹配的规则，比如`switch`的`case`、捕获错误的`catch`、`if\guard\while\for`语句


**Swift中模式有**
- 1、通配符模式(Wildcard Pattern)
- 2、标识符模式(Identifier Pattern)
- 3、值绑定模式(Value-Binding Pattern)
- 4、元祖模式(Tuple Pattern)
- 5、枚举Case模式(Enumeration Case Pattern)
- 6、可选模式(Optional Pattern)
- 7、类型转换模式(Type-Casting Pattern)
- 8、表达式模式(Expression Pattern)


### 通配符模式(Wildcard Pattern)

- `_` 匹配任何值 
- `_?`匹配非nil值


```
enum Life {
    case human(name:String,age:Int?)
    case animal(name:String,age:Int?)
}

func check(_ life:Life){
    switch life {
    case .human(let name,_):
        print("human:",name)
    case .animal(let name,_?):
        print("animal",name)
    default:
        print("other")
        break
    }
}

check(.human(name: "小明", age: 20)) //human: 小明
check(.human(name: "小红", age: nil))//human: 小红
check(.animal(name: "dog", age: 5))//animal dog
check(.animal(name: "cat", age: nil))//other
```

### 标识符模式(Identifier Pattern)

就是给对应的变量常亮赋值
```
let a = 10
let b = "text"
```

### 值绑定模式(Value-Binding Pattern)

```
let point = (2,3)
switch point {
case (let x,let y):
    print("x:\(x)  y:\(y)")
}
//x:2  y:3

```

### 元祖模式(Tuple Pattern)

匹配任何元祖
```
let point = [(0,0),(1,0),(2,0)]
for (x,_) in point{
    print(x)
}
//0
//1
//2
```

### 枚举Case模式(Enumeration Case Pattern)

`if case`语句等价于一个`case`的`switch`语句，简化了一些判断语句

```
let age = 2
//if
if age >= 0 && age <= 9 {
    print("[0,9]")
}
//枚举模式
if case 0...9 = age{
    print("[0,9]")
}
```

```
let ages:[Int?] = [2,3,nil,5]
for case nil in ages{
    print("有nil值")
}
```


### 可选模式(Optional Pattern)

```
let ages:[Int?] = [nil,2,3,nil]
for case let age? in ages{
    print(age)
}
// 2
//3
```

等价于
```
let ages:[Int?] = [nil,2,3,nil]
for item in ages{
    if let age = item {
        print(age)
    }
}

```


### 类型转换模式(Type-Casting Pattern)

```
class Animal {
    func eat() {
        print(type(of: self),"eat")
    }
}

class Dog: Animal {
    func run() {
        print(type(of: self),"run")
    }
}

class Cat: Animal {
    func jump() {
        print(type(of: self),"jump")
    }
}

func check(_ animal:Animal) {
    switch animal {
    case let dog as Dog:
        dog.run()
        dog.eat()
    case is Cat:
        animal.eat()
    default:
        break
    }
}
check(Dog())
//Dog run
//Dog eat
check(Cat())
//Cat eat
```
### 表达式模式(Expression Pattern)

可以通过重载运算符，自定义表达式模式的匹配规则

```
struct Student {
    var score = 0, name = ""
    static func ~=(pattern:Int,value:Student) -> Bool{
        value.score >= pattern
    }
    
    static func ~=(pattern:ClosedRange<Int>,value:Student) -> Bool{
        pattern.contains(value.score)
    }
    static func ~=(pattern:Range<Int>,value:Student) -> Bool{
        pattern.contains(value.score)
    }
    
}
var stu = Student(score: 81, name: "tom")
switch stu{
case 100:print(">=100")
case 90:print(">=90")
case 80..<90:print("[80,90]")
case 60...79:print("[60,79]")
default:break
}
```


```
extension String{
    static func ~=(pattern:(String) -> Bool,value:String) ->Bool{
        pattern(value)
    }
}

func hasPrefix(_ prefix:String) ->((String) -> Bool){{$0.hasPrefix(prefix)}}
func hasSuffix(_ prefix:String) ->((String) -> Bool){{$0.hasSuffix(prefix)}}



var str = "jack"
switch str {
case hasPrefix("j"),hasSuffix("k"):
    print("以j开头，或者以k结尾")
default:
    break
}
```

 

 



































 
 
 
 
 
 
 
 








 
 






















