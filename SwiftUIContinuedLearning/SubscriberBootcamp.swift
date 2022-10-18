//
//  SubscriberBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/17.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
	
	@Published var count: Int = 0
	private var cancellables = Set<AnyCancellable>()
	
	@Published var textFieldText: String = ""
	@Published var textIsValid: Bool = false
	
	@Published var showButton: Bool = false
	
	init() {
		setUpTimer()
		addTextFieldSubscriber()
		addButtonSubscriber()
	}
	
	func setUpTimer() {
		Timer
			.publish(every: 1.0, on: .main, in: .common)
			.autoconnect()
			.sink { [weak self] _ in
				guard let self = self else { return }
				self.count += 1
			}
			.store(in: &cancellables)
	}
	
	func addTextFieldSubscriber() {
		$textFieldText
			.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // 딜레이
			.map { text in
				
				if text.count > 3 {
					return true
				}
				return false
			}
			.sink(receiveValue: { [weak self] isValid in
				self?.textIsValid = isValid
			})
			.store(in: &cancellables)
	}
	
	func addButtonSubscriber() {
		$textIsValid
			.combineLatest($count)
			.sink {[weak self] isValid, count in
				guard let self = self else { return }
				if isValid && count >= 10 {
					self.showButton = true
				} else {
					self.showButton = false
				}
			}
			.store(in: &cancellables)
	}
}

struct SubscriberBootcamp: View {
	
	@StateObject private var vm = SubscriberViewModel()
	
    var body: some View {
		VStack {
			Text("\(vm.count)")
				.font(.largeTitle)
			
			TextField("type something here...", text: $vm.textFieldText)
				.padding(.leading)
				.frame(height: 55)
				.font(.headline)
				.background(Color(UIColor.secondarySystemBackground))
				.cornerRadius(10)
				.overlay(alignment: .trailing) {
					ZStack {
						Image(systemName: "xmark")
							.foregroundColor(.red)
							.opacity(
								vm.textFieldText.count < 1 ? 0 :
								vm.textIsValid ? 0 : 1.0)
						Image(systemName: "checkmark")
							.foregroundColor(.green)
							.opacity(vm.textIsValid ? 1.0 : 0)
						
					}
					.font(.title)
					.padding(.trailing)
				}
			Button {
				
			} label: {
				Text("Submit")
//					.frame(height: 45)
//					.frame(maxWidth: .infinity)
			}
			.buttonStyle(.borderedProminent)
			.disabled(!vm.showButton)

		}
		.padding()
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
