//
//  GameSceneDelegate.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This is the protocol to enforce implementation of the method
//  didTapExitToGameEnd that can then
//  be modified in the class that implements it
//

protocol GameSceneDelegate: AnyObject {
    func didTapExitToGameEnd()
}

