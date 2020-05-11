import UIKit

class Animal {
    var favoriteFood: String
    
    init(favoriteFood: String) {
        self.favoriteFood = favoriteFood
    }
}

class Dog: Animal {
    override init(favoriteFood: String) {
        super.init(favoriteFood: favoriteFood)
    }
}

class Cat: Animal {
    override init(favoriteFood: String) {
        super.init(favoriteFood: favoriteFood)
    }
}

class Owner {
    func feed(_ animal: Animal) {
        // Feed any animal
    }
}

let volt = Dog(favoriteFood: "bacon")
let bingo = Cat(favoriteFood: "fish")

let petter = Owner()

petter.feed(volt)
petter.feed(bingo)
