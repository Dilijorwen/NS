//
//  MainMenuView.swift
//  NS
//
//  Created by Даниил on 22.11.2023.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        Text("ff")
    }
}

#Preview {
    MainMenuView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
