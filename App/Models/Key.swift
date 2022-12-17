//
//  Key.swift
//  KeyboardShorts
//
//  Created by Richard Wise on 12/16/22.
//

import Foundation

struct KeyReference: Identifiable {
    let id: Int
    let name: String
    let output: String
    let isSymbol: Bool
    
}

extension KeyReference {
    static let data: [KeyReference] = [
        
        // MARK: Action Keys
        
        KeyReference(id: 1, name: "Function", output: "fn", isSymbol: true),
        KeyReference(id: 2, name: "Globe", output: "globe", isSymbol: true),
        KeyReference(id: 3, name: "Control", output: "control", isSymbol: true),
        KeyReference(id: 4, name: "Option", output: "option", isSymbol: true),
        KeyReference(id: 5, name: "name", output: "name", isSymbol: true),
        KeyReference(id: 6, name: "Space", output: "space", isSymbol: true),
        KeyReference(id: 7, name: "Shift", output: "shift", isSymbol: true),
        KeyReference(id: 8, name: "Capslock", output: "capslock", isSymbol: true),
        KeyReference(id: 9, name: "Escape", output: "escape", isSymbol: true),
        KeyReference(id: 10, name: "Return", output: "return", isSymbol: true),
        KeyReference(id: 11, name: "Tab", output: "arrow.left.arrow.right", isSymbol: true),
        KeyReference(id: 12, name: "Delete", output: "delete.left", isSymbol: true),
        
        // MARK: Arrow Keys
        
        KeyReference(id: 13, name: "Up Arrow", output: "arrow.up", isSymbol: true),
        KeyReference(id: 14, name: "Down Arrow", output: "arrow.down", isSymbol: true),
        KeyReference(id: 15, name: "Right Arrow", output: "arrow.right", isSymbol: true),
        KeyReference(id: 16, name: "Left Arrow", output: "arrow.left", isSymbol: true),
        
        // MARK: Letter Keys
        KeyReference(id: 17, name: "A", output: "A", isSymbol: false),
        KeyReference(id: 18, name: "B", output: "B", isSymbol: false),
        KeyReference(id: 19, name: "C", output: "C", isSymbol: false),
        KeyReference(id: 20, name: "D", output: "D", isSymbol: false),
        KeyReference(id: 21, name: "E", output: "E", isSymbol: false),
        KeyReference(id: 22, name: "F", output: "F", isSymbol: false),
        KeyReference(id: 23, name: "G", output: "G", isSymbol: false),
        KeyReference(id: 24, name: "H", output: "H", isSymbol: false),
        KeyReference(id: 25, name: "I", output: "I", isSymbol: false),
        KeyReference(id: 26, name: "J", output: "J", isSymbol: false),
        KeyReference(id: 27, name: "K", output: "K", isSymbol: false),
        KeyReference(id: 28, name: "L", output: "L", isSymbol: false),
        KeyReference(id: 29, name: "M", output: "M", isSymbol: false),
        KeyReference(id: 30, name: "N", output: "N", isSymbol: false),
        KeyReference(id: 31, name: "O", output: "O", isSymbol: false),
        KeyReference(id: 32, name: "P", output: "P", isSymbol: false),
        KeyReference(id: 33, name: "Q", output: "Q", isSymbol: false),
        KeyReference(id: 34, name: "R", output: "R", isSymbol: false),
        KeyReference(id: 35, name: "S", output: "S", isSymbol: false),
        KeyReference(id: 36, name: "T", output: "T", isSymbol: false),
        KeyReference(id: 37, name: "U", output: "U", isSymbol: false),
        KeyReference(id: 38, name: "V", output: "V", isSymbol: false),
        KeyReference(id: 39, name: "W", output: "W", isSymbol: false),
        KeyReference(id: 40, name: "X", output: "X", isSymbol: false),
        KeyReference(id: 41, name: "Y", output: "Y", isSymbol: false),
        KeyReference(id: 42, name: "Z", output: "Z", isSymbol: false),
        
        // MARK: Number Keys
        KeyReference(id: 43, name: "One", output: "1", isSymbol: false),
        KeyReference(id: 44, name: "Two", output: "2", isSymbol: false),
        KeyReference(id: 45, name: "Three", output: "3", isSymbol: false),
        KeyReference(id: 46, name: "Four", output: "4", isSymbol: false),
        KeyReference(id: 47, name: "Five", output: "5", isSymbol: false),
        KeyReference(id: 48, name: "Six", output: "6", isSymbol: false),
        KeyReference(id: 49, name: "Seven", output: "7", isSymbol: false),
        KeyReference(id: 50, name: "Eight", output: "8", isSymbol: false),
        KeyReference(id: 51, name: "Nine", output: "9", isSymbol: false),
        KeyReference(id: 52, name: "Zero", output: "0", isSymbol: false),
        KeyReference(id: 53, name: "Minus", output: "minus", isSymbol: true),
        KeyReference(id: 54, name: "Plus", output: "plus", isSymbol: true),
        
        // MARK: Function Keys
        KeyReference(id: 55, name: "F1", output: "F1", isSymbol: false),
        KeyReference(id: 56, name: "F2", output: "F2", isSymbol: false),
        KeyReference(id: 57, name: "F3", output: "F3", isSymbol: false),
        KeyReference(id: 58, name: "F4", output: "F4", isSymbol: false),
        KeyReference(id: 59, name: "F5", output: "F5", isSymbol: false),
        KeyReference(id: 60, name: "F6", output: "F6", isSymbol: false),
        KeyReference(id: 61, name: "F7", output: "F7", isSymbol: false),
        KeyReference(id: 62, name: "F8", output: "F8", isSymbol: false),
        KeyReference(id: 63, name: "F9", output: "F9", isSymbol: false),
        KeyReference(id: 64, name: "F10", output: "F10", isSymbol: false),
        KeyReference(id: 65, name: "F11", output: "F11", isSymbol: false),
        KeyReference(id: 66, name: "F12", output: "F12", isSymbol: false),
        KeyReference(id: 67, name: "Print Screen", output: "camera.on.rectangle", isSymbol: true), // TODO: - Find a better Symbol
        
        // MARK: Numpad
        KeyReference(id: 68, name: "NumPad 0", output: "Num 0", isSymbol: false),
        KeyReference(id: 69, name: "NumPad 1", output: "Num 1", isSymbol: false),
        KeyReference(id: 70, name: "NumPad 2", output: "Num 2", isSymbol: false),
        KeyReference(id: 71, name: "NumPad 3", output: "Num 3", isSymbol: false),
        KeyReference(id: 72, name: "NumPad 4", output: "Num 4", isSymbol: false),
        KeyReference(id: 73, name: "NumPad 5", output: "Num 5", isSymbol: false),
        KeyReference(id: 74, name: "NumPad 6", output: "Num 6", isSymbol: false),
        KeyReference(id: 75, name: "NumPad 7", output: "Num 7", isSymbol: false),
        KeyReference(id: 76, name: "NumPad 8", output: "Num 8", isSymbol: false),
        KeyReference(id: 77, name: "NumPad 9", output: "Num 9", isSymbol: false),
        KeyReference(id: 78, name: "NumPad Plus", output: "Num +", isSymbol: false),
        KeyReference(id: 79, name: "NumPad Minus", output: "Num -", isSymbol: false),
        KeyReference(id: 80, name: "NumPad Multiply", output: "Num *", isSymbol: false),
        KeyReference(id: 81, name: "NumPad Divide", output: "Num /", isSymbol: false),
        KeyReference(id: 82, name: "NumPad Decimal", output: "Num .", isSymbol: false),
        KeyReference(id: 83, name: "NumPad return", output: "Enter", isSymbol: false),
        
        // MARK: Page Keys
        KeyReference(id: 84, name: "Page Down", output: "PGDN", isSymbol: false),
        KeyReference(id: 85, name: "Page Up", output: "PGUP", isSymbol: false),
        KeyReference(id: 86, name: "Home", output: "HOME", isSymbol: false),
        KeyReference(id: 87, name: "End", output: "END", isSymbol: false),
        KeyReference(id: 88, name: "Insert", output: "INS", isSymbol: false),
        KeyReference(id: 89, name: "Delete", output: "Del", isSymbol: false)
    ]
    
    
}
