//
//  JobSheduler.swift
//  HomeWork06
//
//  Created by Юлия Бегман on 29.04.2023.
//

import SwiftUI

actor JobSheduler: ObservableObject {
    var jobs: [Task<Void, Never>] = []
    
    var setSequenceJob: Task<Void, Never>?
    
    var searchJob: Task<Void, Never>?
    
}

class Job: Task<Success: T, Failure: E> {
    
}
