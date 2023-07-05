//
//  CoREx1.swift
//  
//
//  Created by Damir Aliyev on 31.03.2023.
//

import Foundation

protocol Support {
    
    var nextSupporter: Support? { get set }
    
    func setNext(supporter: Support) -> Support
    
    func answer(forQuestion question: String) -> String?
}

class HardwareSupport: Support {
    
    private var answers = [
        "How can I turn on the system's hardware?" : "Press the button on the system block.",
        "Why is my device overheating?" : "Сheck the fan and processor cooler, clean these components if necessary."
    ]
    
    var nextSupporter: Support?
    
    
    func setNext(supporter: Support) -> Support {
        self.nextSupporter = supporter
        
        return supporter
    }
    
    func answer(forQuestion question: String) -> String? {
        if answers[question] != nil {
            return "Hardware support is anwering: \(answers[question]!)"
        } else {
            print("Hardware Support doesn't know answer to the question, will send it to the Software support.")
            return nextSupporter?.answer(forQuestion: question)
        }
    }
    
}

class SoftwareSupport: Support {
    private var answers = [
        "How can I enter to the system?" : "Write your email and password to the appropriate fields.",
        "How can I change the content of the ticket?" : "Click the 'Edit' button ob the top right corner "
    ]
    
    var nextSupporter: Support?
    
    func setNext(supporter: Support) -> Support {
        self.nextSupporter = supporter
        
        return supporter
    }
    
    func answer(forQuestion question: String) -> String? {
        if answers[question] != nil {
            return "Software support is anwering: \(answers[question]!)"
        } else {
            print("Software Support doesn't know answer to the question, will send it to the Network support.")
            
            return nextSupporter?.answer(forQuestion: question)
        }
    }
}


class NetworkSupport: Support {
    
    private var answers = [
        "Why are system responses very slow?" : "Please, verify your internet connection.",
        "What is the password of the WiFi?" : "The password of WiFi is your password to the system"
    ]
    
    var nextSupporter: Support?
    
    func setNext(supporter: Support) -> Support {
        self.nextSupporter = supporter
        
        return supporter
    }
    
    func answer(forQuestion question: String) -> String? {
        if answers[question] != nil {
            return "Network support is anwering: \(answers[question]!)"
        } else {
            //  "?" is the optional chaining. If next supporter exists, it will call the answer of the next supporter
            // if it doesn't, it will not call this function
            print("Network Support doesn't know answer to the question.")
            return nextSupporter?.answer(forQuestion: question)
        }
    }
}


class System {
    let hardwareSupport = HardwareSupport()
    let softwareSupport = SoftwareSupport()
    let networkSupport  = NetworkSupport()
    
    func setSupportSystem() {
        hardwareSupport.setNext(supporter: softwareSupport).setNext(supporter: networkSupport)
    }
    
    func ask(question: String) -> String? {
       return hardwareSupport.answer(forQuestion: question)
    }
}


let system = System()

system.setSupportSystem()

// "??" means, if system.ask will return some value, this value will be printed
// if it will not, text after "??" will be printed
print(system.ask(question: "How can I turn on the system's hardware?") ?? "Sorry, we don't know the answer to this question. We will send you our specialists team.")
//Output: Hardware support is anwering: Press the button on the system block.

print("----------------------------------------------------------------------")

print(system.ask(question: "How can I enter to the system?") ?? "Sorry, we don't know the answer to this question. We will send you our specialists team.")
//Output: Hardware Support doesn't know answer to the question, will send it to the Software support.
//        Software support is anwering: Write your email and password to the appropriate fields.

print("----------------------------------------------------------------------")

print(system.ask(question: "Why are system responses very slow?") ?? "Sorry, we don't know the answer to this question. We will send you our specialists team.")
//Output: Hardware Support doesn't know answer to the question, will send it to the Software support.
//        Software Support doesn't know answer to the question, will send it to the Network support.
//        Network support is anwering: Please, verify your internet connection.

print("----------------------------------------------------------------------")

print(system.ask(question: "Specific question") ?? "Sorry, we don't know the answer to this question. We will send you our specialists team.")
//Output: Hardware Support doesn't know answer to the question, will send it to the Software support.
//        Software Support doesn't know answer to the question, will send it to the Network support.
//        Network Support doesn't know answer to the question.
//        Sorry, we don't know the answer to this question. We will send you our specialists team.
