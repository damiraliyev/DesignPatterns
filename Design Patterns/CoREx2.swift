//
//  CoREx2.swift
//  
//
//  Created by Damir Aliyev on 31.03.2023.
//

import Foundation

enum Event {
    case ConnectingToDatabase
    case ConnectedToDatabase
    case LowDiskSpaceDetected
    case FileNotFound
    case AnotherCase
}

protocol Log {
    var nextLog: Log? { get set }
    
    func setNext(log: Log) -> Log
    
    func showOutput(event: Event) -> String?
}

class DebugLog: Log {
    var nextLog: Log?
    
    func setNext(log: Log) -> Log {
        self.nextLog = log
        
        return log
    }
    
    func showOutput(event: Event) -> String? {
        if event == .ConnectingToDatabase {
            return "[DEBUG] Connecting to database."
        } else {
            print("It is not DEBUG level. Next is INFO.")
            return nextLog?.showOutput(event: event)
        }
    }
    
}

class InfoLog: Log {
    var nextLog: Log?
    
    func setNext(log: Log) -> Log {
        self.nextLog = log
        
        return log
    }
    
    func showOutput(event: Event) -> String? {
        if event == .ConnectedToDatabase {
            return "[INFO] Connected to database."
        } else {
            print("It is not INFO level. Next is WARNING.")
            return nextLog?.showOutput(event: event)
        }
    }
    
    
}

class WarningLog: Log {
    var nextLog: Log?
    
    func setNext(log: Log) -> Log {
        self.nextLog = log
        
        return log
    }
    
    func showOutput(event: Event) -> String? {
        if event == .LowDiskSpaceDetected {
            return "[WARNING] Low disk space detected."
        } else {
            print("It is not WARNING level. Next is ERROR.")
            return nextLog?.showOutput(event: event)
        }
    }
    
    
}

class ErrorLog: Log {
    var nextLog: Log?
    
    func setNext(log: Log) -> Log {
        self.nextLog = log
        
        return log
    }
    
    func showOutput(event: Event) -> String? {
        if event == .FileNotFound {
            return "[ERROR] File not found."
        } else {
            return nextLog?.showOutput(event: event)
        }
    }
    
}


let debugLog = DebugLog()
let infoLog = InfoLog()
let warningLog = WarningLog()
let errorLog = ErrorLog()

debugLog.setNext(log: infoLog).setNext(log: warningLog).setNext(log: errorLog)

print(debugLog.showOutput(event: .ConnectingToDatabase) ?? "Reached to the end of the chain.")
//Output: [DEBUG] Connecting to database.

print("----------------------------------------------------------------------")

print(debugLog.showOutput(event: .ConnectedToDatabase) ?? "Reached to the end of the chain.")
//Output: It is not DEBUG level. Next is INFO.
//        [INFO] Connected to database.

print("----------------------------------------------------------------------")

print(debugLog.showOutput(event: .LowDiskSpaceDetected) ?? "Reached to the end of the chain.")
//Output: It is not DEBUG level. Next is INFO.
//        It is not INFO level. Next is WARNING.
//        [WARNING] Low disk space detected.

print("----------------------------------------------------------------------")

print(debugLog.showOutput(event: .FileNotFound) ?? "Reached to the end of the chain.")
//Output: It is not DEBUG level. Next is INFO.
//        It is not INFO level. Next is WARNING.
//        It is not WARNING level. Next is ERROR.
//        [ERROR] File not found.
//

print("----------------------------------------------------------------------")

print(debugLog.showOutput(event: .AnotherCase) ?? "Reached to the end of the chain.")
//Output: It is not DEBUG level. Next is INFO.
//        It is not INFO level. Next is WARNING.
//        It is not WARNING level. Next is ERROR.
//        Reached to the end of the chain.
