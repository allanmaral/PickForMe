//
//  PickListItem.swift
//  PickForMe
//
//  Created by Allan Amaral on 01/12/23.
//

import SwiftUI

struct PickListItem: View {
    let pick: Pick
    
    init(_ pick: Pick) {
        self.pick = pick
    }
    
    var body: some View {
        NavigationLink(value: pick) {
            VStack(alignment: .leading) {
                Text(pick.title)
                    .font(.headline)
                
                Text(pick.updatedAt.formatted(.relative(presentation: .named)))
                    .font(.callout)
            }
        }
    }
}

#Preview {
    ModelPreview { pick in
        NavigationStack {
            List {
                PickListItem(pick)
            }
        }
    }
}
