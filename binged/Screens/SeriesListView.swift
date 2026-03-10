//
//  SeriesListView.swift
//  binged
//
//  Created by apprenant85 on 09/03/2026.
//

import SwiftUI

struct SeriesListView: View {
    @State var vm = SerieViewModels()
    var body: some View {
        VStack {
            List(vm.series, id: \.name) { serie in
                Text(serie.name)
            }
        }
        .task {
            do {
                try await vm.fetchSeries()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    SeriesListView()
}
