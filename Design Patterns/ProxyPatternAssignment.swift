//
//  ProxyPatternAssignment.swift
//  
//
//  Created by Damir Aliyev on 10.03.2023.
//

import Foundation
import UIKit

protocol DocumentManagementSystemProtocol {
    func uploadDocument(documentName: String, documentContent: String)
    func downloadDocument(documentName: String) -> (documentName: String, documentContent: String)?
    func editDocument(documentName: String, editedContent: String)
}

class DocumentManagementSystem: DocumentManagementSystemProtocol {
    //dictionaty as Database
    var documents = [String: String]()
    
    func uploadDocument(documentName: String, documentContent: String) {
        documents[documentName] = documentContent
    }
    
    func downloadDocument(documentName: String) -> (documentName: String, documentContent: String)? {
        
        return (documentName: documentName, documentContent: documents[documentName]!)
    }
    
    func editDocument(documentName: String, editedContent: String) {
        documents[documentName] = editedContent
    }
    
}


let permitedUsers = ["Damir Aliyev", "Ramazan Amangeldin", "Bekzhan Zhakas"]


class SystemProxy: DocumentManagementSystemProtocol {
    
    private let system: DocumentManagementSystem
    
    //Imitating authenticated user
    private var name: String?
    private var surname: String?
    private var isAuthorized = false
    
    //caching documents
    private var cachedDocuments = [String: String]()
    
    init(system: DocumentManagementSystem) {
        self.system = system
    }
    
    func authorize(name: String, surname: String) {
        self.name = name
        self.surname = surname
        
        if permitedUsers.contains("\(name) \(surname)") {
            print("Authorized succesfully!")
            isAuthorized = true
        } else {
            print("Authorizaten is denied")
        }
        
    }
    
    func checkAccess() -> Bool {
        return isAuthorized
    }
    
    func uploadDocument(documentName: String, documentContent: String) {
        
        // checking access
        if checkAccess() {
            //If we already have it, deny uploading
            guard system.documents[documentName] == nil else {
                print("There is already a document with such name in the system.")
                return
            }
            
            system.documents[documentName] = documentContent
            
            //Upload to cache
            cachedDocuments[documentName] = documentContent
            
            print("Document was uploaded!")
        } else {
            print("Your are not permitted to upload documents.")
        }
    }
    
    func downloadDocument(documentName: String) -> (documentName: String, documentContent: String)? {
        
        if checkAccess() {
            
            //check if we have it in cache
            //if it is -> return from cache
            if cachedDocuments[documentName] != nil {
                print("Downloading from cache...")
                return (documentName: documentName, cachedDocuments[documentName]!)
            }
            
            //checking if system has this document
            guard let document = system.documents[documentName] else {
                print("There is not such file in the system")
                return nil
            }
            
            print("Downloading...")
            return (documentName: documentName, documentContent: document)
        } else {
            print("You are not permitted to download documents.")
            return nil
        }
    }
    
    func editDocument(documentName: String, editedContent: String) {
        
        if checkAccess() {
            guard let _ = system.documents[documentName] else {
                print("There is not such file in the system")
                return
            }
            system.documents[documentName] = editedContent
            cachedDocuments[documentName] = editedContent
            print("Document with name \(documentName) was edited.")
        } else {
            print("You are not permitted to edit documents.")
        }
    }
}


let system = DocumentManagementSystem()

let systemProxy = SystemProxy(system: system)


systemProxy.downloadDocument(documentName: "ProxyPattern")
//Result: You are not permitted to download documents.

systemProxy.authorize(name: "Random", surname: "User")
//Result: Authorizaten is denied

systemProxy.authorize(name: "Damir", surname: "Aliyev")
//Result: Authorized successfully!

systemProxy.downloadDocument(documentName: "ProxyPattern")
//Result: There is not such file in the system

systemProxy.uploadDocument(documentName: "ProxyPattern", documentContent: "First Content")
//Result: Document was uploaded!

systemProxy.editDocument(documentName: "Proxy", editedContent: "")
//Result: There is not such file in the system

systemProxy.editDocument(documentName: "ProxyPattern", editedContent: "About Proxy design pattern")
//Result: Document with name ProxyPattern was edited.

let proxyPatternDocument = systemProxy.downloadDocument(documentName: "ProxyPattern")
//Result: Downloading from cache...

print(proxyPatternDocument?.documentName ?? "", proxyPatternDocument?.documentContent ?? "")
//Result: ProxyPattern About Proxy design pattern
