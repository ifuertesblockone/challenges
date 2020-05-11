import UIKit

protocol Area {
    func calculateArea() -> Float
}

class Rectagule: Area {
    var width: Float
    var height: Float
    
    init(width: Float, height: Float) {
        self.width = width
        self.height = height
    }
    
    func calculateArea() -> Float {
        return width * height
    }
}

class Circle: Area {
    var radius: Float
    
    init(radius: Float) {
        self.radius = radius
    }
    
    func calculateArea() -> Float {
        return radius * radius * Float.pi
    }
}

class CostManager {
    var area: Area
    
    init(area: Area) {
        self.area = area
    }
    
    func calculate() -> Float {
        var costPerUnit: Float = 1.5
        
        return costPerUnit * area.calculateArea()
    }
}

let costManager = CostManager(area: Rectagule(width: 10, height: 5))

let cost = costManager.calculate()

