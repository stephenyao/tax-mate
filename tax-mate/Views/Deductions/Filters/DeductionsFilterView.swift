//
//  DeductionsFilterView.swift
//  tax-mate
//
//  Created by Stephen Yao on 1/4/22.
//

import Foundation
import SwiftUI
import Combine

struct DeductionsFilterView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if !viewModel.showsFilters {
            DeductionsFilterSummary(selectionOption: viewModel.selectedOption)
                .onTapGesture {
                    withAnimation {
                        self.viewModel.showsFilters = true
                    }
                }
        } else {
            DateFilterView(selected: $viewModel.selectedOption)
        }
    }
}

private final class ViewModel: ObservableObject {
    @Published var showsFilters = false
    @Published var selectedOption: DateFilterOption = .all
    var cancellable: AnyCancellable!
    
    init() {
        self.cancellable = $selectedOption.sink { [weak self] _ in
            withAnimation {
                self?.showsFilters = false
            }
        }
    }
}

struct Previews_Deductions_Filter_View: PreviewProvider {
    static var previews: some View {
        DeductionsFilterView().preferredColorScheme(.light)
        DeductionsFilterView().preferredColorScheme(.dark)
    }
}
