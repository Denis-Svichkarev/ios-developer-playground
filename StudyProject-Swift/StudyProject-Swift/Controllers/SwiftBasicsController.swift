//
//  SwiftBasicsController.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 20/11/24.
//

import UIKit

class SwiftBasicsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        testInitializers()
        testGettersAndSetters()
        testObjectReferences()
        testMaps()
        testFlatMaps()
        testCompactMaps()
        testVariadicParameters()
        testReduce()
        testSelectors()
        testFilter()
        testDecodable()
        testSwitch(x: 100, y: 0)
        testClosures()
        fetchData { data in
            print(data)
        }
        testTrailingClosure()
        performTask {
            print("Completed")
        }
        testLazyVar()
        testGenerics()
        let max = maximum(a: 10, b: 20)
        print("max: \(max)")
        testClassStaticFunctions()
        testPropertyWrapper()
        testNestedTypes()
        testResultBuilders()
        testEnums()
        testDefer()
    }
    
    // MARK: - Swift Basics
    
    func testInitializers() {
        // Example of using classes
        let myObject = MyClass(name: "James")
        let myObject2 = myObject
        myObject2.name = "Paul"
        
        myObject.test()
        myObject2.test()
        
        // Example of using structures
        let myStruct = MyStruct(name: "John")
        var myStruct2 = myStruct
        myStruct2.changeName()
        
        myStruct.test()
        myStruct2.test()
        
        // Copy-on-write example
        var array1 = [1, 2, 3]
        let array2 = array1
        array1.append(4)
        
        print(array1)
        print(array2)
    }
    
    func testGettersAndSetters() {
        let person = Person(firstName: "John", lastName: "Smith", age: 20)
        person.age = 30
        person.greet()
        
        print(person.fullName)
    }
    
    func testObjectReferences() {
        var person: Person? = Person(firstName: "John", lastName: "Smith", age: 20)
        let pet = Animal(name: "Charlie", owner: person!)
        person?.pet = pet
        person = nil
        
        // Leads to crash
        // print(pet.owner.firstName)
    }
    
    func testMaps() {
        let numbers = [1, 2, 3, 4, 5]
        let squaredNumbers = numbers.map { $0 * 2 }

        print(squaredNumbers)
        
        let number: Int? = 5
        let result = number.map { $0 * 2 }

        print(result ?? "nil")
    }
    
    func testFlatMaps() {
        let array = [[1, 2, 3], [4, 5, 6]]
        let flatArray = array.flatMap { $0 }

        print(flatArray)
        
        let number: Int? = 5
        let result = number.flatMap { Optional($0 * 2) }

        // With flatMap the result is Optional(10), not Optional(Optional(10))
        print(result ?? "nil")
    }
    
    func testCompactMaps() {
        let numbers = ["1", "2", "three", "4"]
        let validNumbers = numbers.compactMap { Int($0) }
        print(validNumbers)
    }
    
    func testVariadicParameters() {
        logMessages("Server started", "User logged in", "Error 404")
        
        print(sumOfNumbers(1, 2, 3, 4, 5))
        print(sumOfNumbers(10, 20))
    }
    
    func logMessages(_ messages: String...) {
        for message in messages {
            print("Log: \(message)")
        }
    }
    
    func sumOfNumbers(_ numbers: Int...) -> Int {
        var total = 0
        for number in numbers {
            total += number
        }
        return total
    }
    
    func testReduce() {
        let numbers = [1, 2, 3, 4, 5]
        let sum = numbers.reduce(0) { (total, number) in
            total + number
        }
        print(sum)
        
        let strings = ["Hello", " ", "World", "!"]
        let result = strings.reduce("") { (currentString, nextString) in
            currentString + nextString
        }
        print(result)
        
        let numbers2 = [3, 5, 1, 8, 2]
        let maxNumber = numbers2.reduce(numbers2[0]) { (currentMax, number) in
            return max(currentMax, number)
        }
        print(maxNumber)
    }
    
    func testSelectors() {
        // Old style
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        // New style
        let button2 = UIButton()
        button2.addAction(UIAction { _ in
            print("Button tapped")
        }, for: .touchUpInside)
        
        // @autoclosure example
        logIfNeeded(5 > 3, message: "Condition is true")
    }
    
    @objc func buttonTapped() {
        print("Button tapped")
    }
    
    func logIfNeeded(_ condition: @autoclosure () -> Bool, message: String) {
        if condition() {
            print(message)
        }
    }
    
    func testFilter() {
        let numbers = [1, 6, 3, 8, 4]
        let filteredNumbers = numbers.filter { $0 > 5 }  // Result: [6, 8]
        print(filteredNumbers)
        
        struct User {
            let name: String
            let age: Int
        }

        let users = [
            User(name: "John", age: 30),
            User(name: "Jane", age: 25),
            User(name: "Tom", age: 20)
        ]

        let filteredUsers = users.filter { $0.age >= 25 }
        print(filteredUsers)
    }
    
    func testDecodable() {
        struct User: Decodable {
            let id: Int
            let name: String
            let email: String
        }
        
        let jsonString = """
        {
            "id": 1,
            "name": "John Doe",
            "email": "john.doe@example.com"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!

        do {
            let user = try JSONDecoder().decode(User.self, from: jsonData)
            print(user.name)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func testSwitch(x: Int, y: Int) {
        let point = (x, y)

        switch point {
        case (0, 0):
            print("Point is at origin")
            print("End")
        case (let x, 0):
            print("Point is on x-axis at \(x)")
            print("End")
        case (0, let y):
            print("Point is on y-axis at \(y)")
            print("End")
        case let (x, y):
            print("Point is at (\(x), \(y))")
            print("End")
        }
    }

    func testClosures() {
        let simpleClosure = {
            print("This is a simple closure.")
        }
        
        simpleClosure()
        
        fetchData { data in
            print("Data received: \(data)")
        }
        
        let myObject = MyClass()
        
        myObject.completion = {
            print("Task completed!")
        }

        myObject.executeTask()
    }
    
    func fetchData(completion: @escaping (String) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let data = "Fetched data"
            completion(data)
        }
    }
    
    func testTrailingClosure() {
        performTask(completion: {
            print("Task in progress")
        })
        
        performTask {
            print("Task in progress")
        }
    }
    
    func performTask(completion: () -> Void) {
        print("Task started")
        completion()
        print("Task completed")
    }
    
    func testLazyVar() {
        let calculator = ComplexCalculator()
        print("Calculation not started yet")
        print("The result is \(calculator.result)")
    }
    
    func testGenerics() {
        let maxInt = maximum(a: 10, b: 20)
        let maxDouble = maximum(a: 3.14, b: 2.72)
        print("\(maxInt), \(maxDouble)")
        
        let person = Human(name: "John")
        let car = Car(model: "Tesla")

        printDescription(item: person) // Person: John
        printDescription(item: car)    // Car model: Tesla
        
        var x = 5
        var y = 10
        swapValues(a: &x, b: &y)
        print("x: \(x), y: \(y)")
    }
    
    func maximum<T: Comparable>(a: T, b: T) -> T {
        return a > b ? a : b
    }
    
    func testClassStaticFunctions() {
        print(ParentClass.description())
        print(ChildClass.description())
    }
    
    func testPropertyWrapper() {
        let user = MyUser(username: "johnDoe")
        print(user.username) // "JOHNDOE"
    }
    
    func testNestedTypes() {
        let address = Person.Address(street: "123 Main St", city: "Anytown")
        print(address)
    }
    
    func testResultBuilders() {
        let page = buildHTML {
            "<h1>Hello, world!</h1>"
            "<p>This is a paragraph.</p>"
        }
        
        print(page)
        
        let buttons = createButtons {
            CustomButton(title: "Save", action: { print("Saving...") })
            CustomButton(title: "Cancel", action: { print("Cancelled") })
        }
        
        print(buttons)
    }
    
    func testEnums() {
        let myDog = TestAnimal.dog(name: "Rex", breed: "Labrador")
        //let myCat = TestAnimal.cat(name: "Whiskers", age: 3)

        switch myDog {
        case .dog(let name, let breed):
            print("Dog's name is \(name) and breed is \(breed)")
        case .cat(let name, let age):
            print("Cat's name is \(name) and age is \(age)")
        case .bird(let name, let canFly):
            print("\(name) can fly: \(canFly)")
        }
    }
    
    func testDefer() {
        print("Open file...")
        
        defer {
            print("Close file 2.")
        }
        
        defer {
            print("Close file 1.")
        }

        print("Read data from file...")
        
        if true {
            print("Error occurred.")
            return
        }
        
        print("Success.")
    }
}
