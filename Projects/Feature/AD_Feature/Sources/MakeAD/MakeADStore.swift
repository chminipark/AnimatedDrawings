//
//  MakeADStore.swift
//  AD_Feature
//
//  Created by minii on 2023/06/10.
//  Copyright © 2023 chminipark. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct MakeADStore: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public init() {}
    
    @BindingState public var curStep: Step = .UploadADrawing
    public var originalImage: UIImage? = nil
    
    public var uploadADrawing: UploadADrawingStore.State {
      get {
        UploadADrawingStore.State(
          curStep: self.curStep,
          originalImage: self.originalImage
        )
      }
      set {
        self.curStep = newValue.curStep
        self.originalImage = newValue.originalImage
      }
    }
    public var findingTheCharacter: FindingTheCharacterStore.State {
      get {
        FindingTheCharacterStore.State(originalImage: self.originalImage)
      }
      set {}
    }
  }
  
  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    
    case upStep
    case downStep
    case uploadADrawing(UploadADrawingStore.Action)
    case findingTheCharacter(FindingTheCharacterStore.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    
    Scope(state: \.uploadADrawing, action: /Action.uploadADrawing) {
      UploadADrawingStore()
    }
    
    Scope(state: \.findingTheCharacter, action: /Action.findingTheCharacter) {
      FindingTheCharacterStore()
    }
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      // 안쓰면 지우기
      case .upStep:
        let nexIndex = state.curStep.index + 1
        guard nexIndex != 5,
              let nexStep = Step.init(rawValue: nexIndex)
        else {
          return .none
        }
        state.curStep = nexStep
        return .none
        
      case .downStep:
        let nexIndex = state.curStep.index - 1
        guard nexIndex != 0,
              let nexStep = Step.init(rawValue: nexIndex)
        else {
          return .none
        }
        state.curStep = nexStep
        return .none
        
      case .uploadADrawing, .findingTheCharacter:
        return .none
      }
    }
  }
}
