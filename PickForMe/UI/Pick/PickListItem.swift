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
                    .font(.body)
                
                Text(pick.updatedAt.formatted(.relative(presentation: .named)))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
