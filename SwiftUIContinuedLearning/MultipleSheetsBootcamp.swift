//
//  MultipleSheetsBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/14.
//

import SwiftUI

private struct RandomModel: Identifiable {
	let id = UUID().uuidString
	let title: String
}

// 1 - use binding
// 2 - multiple .sheets
// 3 - use $item (best solution)

struct MultipleSheetsBootcamp: View {
	
	@State fileprivate var selectedModel: RandomModel? = nil
	@State private var showSheet: Bool = false
// 2 -	@State private var showSheet2: Bool = false
	
    var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				ForEach(0..<50) { index in
					Button("Button \(index)") {
						selectedModel = RandomModel(title: "\(index)")
					}
					.sheet(item: $selectedModel) { model in
						NextScreen(selectedModel: model)
					}
				}
			}
		}
    }
}

struct NextScreen: View {
	
// 1 -	@Binding fileprivate var selectedModel: RandomModel
	fileprivate let selectedModel: RandomModel
	
	var body: some View {
		Text(selectedModel.title)
			.font(.largeTitle)
	}
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
