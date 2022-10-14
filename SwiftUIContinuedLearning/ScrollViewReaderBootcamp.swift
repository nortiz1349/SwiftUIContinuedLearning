//
//  ScrollViewReaderBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/13.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
	
	@State private var scrollToIndex: Int = 0
	@State private var textFieldText: String = ""
	
	var body: some View {
		VStack {
			
			TextField("Enter a # here...", text: $textFieldText)
				.frame(height: 55)
				.border(.gray)
				.padding(.horizontal)
				.keyboardType(.numberPad)
			
			Button {
				if let index = Int(textFieldText) {
					scrollToIndex = index
				}
			} label: {
				Text("Move to #")
			}
			
			ScrollView {
				ScrollViewReader { proxy in
					ForEach(0..<50) { index in
						Text("This is item #\(index)")
							.font(.headline)
							.frame(height: 200)
							.frame(maxWidth: .infinity)
							.background(.white)
							.cornerRadius(10)
							.shadow(radius: 10)
							.padding()
							.id(index)
					}
					.onChange(of: scrollToIndex) { newValue in
						withAnimation(.spring()) {
							proxy.scrollTo(newValue, anchor: .top)
						}
					}
				}
			}
		}
	}
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
	static var previews: some View {
		ScrollViewReaderBootcamp()
	}
}
