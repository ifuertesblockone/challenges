import UIKit

protocol WorkerInterface {
    func work()
}

protocol SleepAbleInterface {
    func sleep()
}

class HummanWorker: WorkerInterface, SleepAbleInterface {
    func work() {
        // Human works
    }
    
    func sleep() {
        // Human sleeps
    }
}

class RobotWorker: WorkerInterface {
    func work() {
        // Robot works
    }
}
