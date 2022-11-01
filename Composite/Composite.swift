//
//  Composite.swift
//  Composite
//
//  Created by Nataliya Lazouskaya on 1.11.22.
//

import Foundation

protocol Composite {
    var name: String { get }
    func showContent() -> Any
    func addComponent(c: Composite)
    func contentCount() -> Int
}

class File: Composite {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func showContent() -> Any {
        return name
    }
    
    func addComponent(c: Composite) {
        print("Impossible to add component to File")
    }
    
    func contentCount() -> Int {
        return 1
    }
}

class Folder: Composite {
    var name: String
    
    private var contentArray = [Composite]()
    
    init(name: String) {
        self.name = name
    }
    
    func showContent() -> Any {
        return contentArray
    }
    
    func addComponent(c: Composite) {
        contentArray.append(c)
    }
    
    func contentCount() -> Int {
        contentArray.count
    }
}
