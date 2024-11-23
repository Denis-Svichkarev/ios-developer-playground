//
//  PatternsController.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 21/11/24.
//

import UIKit

class PatternsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testPatterns()
    }
    
    func testPatterns() {
        // Design Patterns
        testSingleton()
        testFactoryMethod()
        testAbstractFactory()
        testBuilder()
        testPrototype()
        
        // Structural Patterns
        testAdapter()
        testDecorator()
        testFacade()
        testComposite()
        testBridge()
        
        // Behavioral Patterns
        testObserver()
        testStrategy()
        testCommand()
        testIterator()
        
        // Other Patterns
        testState()
        testPipeline()
        testProxy()
        testChainOfResponsibility()
        testDependencyInjection()
    }
    
    // MARK: - Design Patterns
    
    func testSingleton() {
        NetworkManager.shared.fetchData(from: "https://api.example.com/data")
    }
    
    func testFactoryMethod() {
        let windowsDialog = WindowsDialog()
        clientCode(dialog: windowsDialog)

        let macDialog = MacOSDialog()
        clientCode(dialog: macDialog)
    }
    
    func clientCode(dialog: Dialog) {
        dialog.renderUI()
    }
    
    func testAbstractFactory() {
        let windowsFactory = WindowsFactory()
        clientCode(factory: windowsFactory)

        let macFactory = MacOSFactory()
        clientCode(factory: macFactory)
    }

    func clientCode(factory: GUIFactory) {
        let button = factory.createButton()
        let checkbox = factory.createCheckbox()
        
        button.render()
        checkbox.check()
    }
    
    func testBuilder() {
        let builder = ConcretePizzaBuilder()
        let director = PizzaDirector(builder: builder)

        let margherita = director.makeMargherita()
        print(margherita)

        let pepperoni = director.makePepperoni()
        print(pepperoni)
    }
    
    func testPrototype() {
        let originalCar = SuperCar(model: "Tesla Model S", color: "Red")
        let clonedCar = originalCar.clone()

        clonedCar.color = "Blue"

        print("Original Car: \(originalCar.model), Color: \(originalCar.color)")
        print("Cloned Car: \(clonedCar.model), Color: \(clonedCar.color)")
    }
    
    // MARK: - Structural Patterns
    
    func testAdapter() {
        let adaptee = Adaptee()
        let adapter = Adapter(adaptee: adaptee)
        adapter.request()
    }
    
    func testDecorator() {
        let myCoffee = SimpleCoffee()
        print("\(myCoffee.description()) costs \(myCoffee.cost())")

        let milkCoffee = MilkDecorator(decoratedCoffee: myCoffee)
        print("\(milkCoffee.description()) costs \(milkCoffee.cost())")

        let sugarMilkCoffee = SugarDecorator(decoratedCoffee: milkCoffee)
        print("\(sugarMilkCoffee.description()) costs \(sugarMilkCoffee.cost())")
    }
    
    func testFacade() {
        let computer = ComputerFacade()
        computer.start()
    }
    
    func testComposite() {
        let dot = Dot()
        let circle = Circle2()

        let compound = CompoundGraphic()
        compound.add(child: dot)
        compound.add(child: circle)

        compound.draw()
        
        let nestedCompound = CompoundGraphic()
        nestedCompound.add(child: compound)
        nestedCompound.add(child: Circle2())

        nestedCompound.draw()
    }
    
    func testBridge() {
        let vectorRenderer = VectorRenderer()
        let rasterRenderer = RasterRenderer()

        let vectorCircle = TCircle(renderer: vectorRenderer, radius: 5.0)
        vectorCircle.draw()

        let rasterCircle = TCircle(renderer: rasterRenderer, radius: 10.0)
        rasterCircle.draw()
    }
    
    // MARK: - Behavioral Patterns
    
    func testObserver() {
        let subject = ConcreteSubject()
        let observer1 = ConcreteObserver()
        let observer2 = ConcreteObserver()

        subject.attach(observer: observer1)
        subject.attach(observer: observer2)

        subject.state = 10

        subject.detach(observer: observer1)
        subject.state = 20
    }
    
    func testStrategy() {
        let cart = ShoppingCart()
        cart.addItem("Book")
        cart.addItem("Pen")

        cart.setPaymentStrategy(CreditCardPayment())
        cart.checkout()

        cart.setPaymentStrategy(PayPalPayment())
        cart.checkout()

        cart.setPaymentStrategy(BitcoinPayment())
        cart.checkout()
    }
    
    func testCommand() {
        let light = Light()
        let turnOn = TurnOnCommand(light: light)
        let turnOff = TurnOffCommand(light: light)

        let remote = RemoteControl()

        remote.setCommand(turnOn)
        remote.pressButton()

        remote.setCommand(turnOff)
        remote.pressButton()
    }
    
    func testIterator() {
        let collection = BookCollection()
        collection.addBook("1984")
        collection.addBook("Brave New World")
        collection.addBook("Fahrenheit 451")

        for book in collection {
            print(book)
        }
    }
    
    // MARK: - Other Patterns
    
    func testState() {
        let startState = StartState()
        let context = Context(state: startState)

        context.request()
        context.request()
        context.request()
    }
    
    func testPipeline() {
        let pipeline = Pipeline()
        pipeline.addStage(TrimStage())
        pipeline.addStage(UppercaseStage())
        pipeline.addStage(AppendStage(suffix: "!!!"))

        let input = "   hello world   "
        let output = pipeline.execute(data: input)
        print(output)
    }
    
    func testProxy() {
        let image = ProxyImage(filename: "photo.jpg")
        image.display()
        image.display()
    }
    
    func testChainOfResponsibility() {
        let logger = LoggerHandler()
        let auth = AuthenticationHandler()
        let data = DataHandler()

        logger.next = auth
        auth.next = data

        let request1 = "auth request with data"
        print("Processing request1:")
        logger.handle(request: request1)
        // Processing request1:
        // LoggerHandler: Logging request - auth request with data
        // AuthenticationHandler: Authenticating request
        // DataHandler: Processing data for request - auth request with data

        let request2 = "public request without auth"
        print("\nProcessing request2:")
        logger.handle(request: request2)
        // Processing request2:
        // LoggerHandler: Logging request - public request without auth
        // AuthenticationHandler: No authentication needed
    }
    
    func testDependencyInjection() {
        let networkService = NetworkService()
        let dataController = DataController(networkService: networkService)

        dataController.displayData()
    }
}
