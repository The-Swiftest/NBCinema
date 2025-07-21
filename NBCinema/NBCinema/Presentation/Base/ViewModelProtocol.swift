//
//  ViewModelProtocol.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State

    func action(_ action: Action)
    var state: State { get }
}
