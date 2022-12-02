//
//  RuntimeError.swift
//  Prompts-UIKit
//
//  Created by Vishal Dubey on 12/2/22.
//

import Foundation



struct RuntimeError {
    var message: String
    var error: Error
}

extension RuntimeError: Error { }

