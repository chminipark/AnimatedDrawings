//
//  Step.swift
//  AD_Feature
//
//  Created by minii on 2023/06/14.
//  Copyright © 2023 chminipark. All rights reserved.
//

import Foundation

public enum Step: Int {
  case UploadADrawing = 1
  case FindingTheCharacter = 2
  
  public var index: Int {
    return self.rawValue
  }
}