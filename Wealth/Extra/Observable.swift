
//
//  Observable.swift
//  Wealth
//
//  Created by Jack Lapin on 5/3/18.
//  Copyright © 2018 Jack Lapin. All rights reserved.
//

import Foundation

final class Observable<T> {
    
    typealias Block = (T) -> Void
    
    var value: T {
        didSet {
            notifyObservers()
        }
    }
    
    private var subscribers = [String: Block]()
    
    init(_ value: T) {
        self.value = value
    }
    
    private func notifyObservers() {
        subscribers.values.forEach { $0(value) }
    }
    
    func onChange(_ callback: @escaping Block) -> String {
        let token = ProcessInfo.processInfo.globallyUniqueString
        subscribers[token] = callback
        
        return token
    }
    
    func unsubscribe(with token: String) {
        subscribers[token] = nil
    }
    
}
