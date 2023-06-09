//
//  FindingCharacterJointsView.swift
//  AD_UI
//
//  Created by minii on 2023/07/13.
//  Copyright © 2023 chminipark. All rights reserved.
//

import SwiftUI
import AD_Feature
import AD_Utils
import ComposableArchitecture

struct FindingCharacterJointsView: ADUI {
  typealias MyStore = FindingCharacterJointsStore
  let store: StoreOf<MyStore>
  
  init(
    store: StoreOf<MyStore> = Store(
      initialState: MyStore.State(
        sharedState: SharedState(),
        state: FindingCharacterJointsStore.MyState()
      ),
      reducer: MyStore()
    )
  ) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ADScrollView {
        VStack(alignment: .leading, spacing: 20) {
          if let maskedImage = viewStore.state.sharedState.maskedImage {
            Image(uiImage: maskedImage)
              .frame(height: 400)
              .aspectRatio(contentMode: .fit)
          } else {
            Text("NO MaskedImage ...")
          }
        }
      }
    }
  }
}

struct FindingCharacterJointsView_Previews: PreviewProvider {
  static var previews: some View {
    FindingCharacterJointsView()
  }
}
