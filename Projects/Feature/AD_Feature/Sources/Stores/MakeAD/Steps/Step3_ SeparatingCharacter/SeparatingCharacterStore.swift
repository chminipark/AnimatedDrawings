//
//  SeparatingCharacterStore.swift
//  AD_Feature
//
//  Created by minii on 2023/07/02.
//  Copyright © 2023 chminipark. All rights reserved.
//

import ComposableArchitecture

public struct SeparatingCharacterStore: ReducerProtocol {
  public init() {}
  
  public struct State: Equatable {
    public init() {}
    
    @BindingState public var checkState1 = false
    @BindingState public var checkState2 = false
    @BindingState public var maskState = false
  }
  
  public enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    
    case checkAction1
    case checkAction2
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .checkAction1:
        state.checkState1.toggle()
        activeUploadButton(state: &state)
        return .none
        
      case .checkAction2:
        state.checkState2.toggle()
        activeUploadButton(state: &state)
        return .none
      }
    }
  }
  
  func activeUploadButton(state: inout SeparatingCharacterStore.State) {
    if state.checkState1 && state.checkState2 {
      state.maskState = true
    } else {
      state.maskState = false
    }
  }
}