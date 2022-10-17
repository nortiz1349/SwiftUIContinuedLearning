//
//  WeakSelfBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/17.
//

import SwiftUI

struct WeakSelfBootcamp: View {
	
	@AppStorage("count") var count: Int?
	
	init() {
		count = 0
	}
	
    var body: some View {
		NavigationStack {
			NavigationLink {
				WeakSelfSecondScreen()
			} label: {
				Text("Navigate")
			}
			.navigationTitle("Screen 1")
		}
		.overlay(alignment: .topTrailing) {
			Text("\(count ?? 0)")
				.font(.largeTitle)
				.padding()
				.background(Color.green.cornerRadius(10))
				
		}
    }
}

struct WeakSelfSecondScreen: View {
	
	@StateObject private var vm = WeakSelfSecondScreenViewModel()
	
	var body: some View {
		VStack {
			Text("Second View")
				.font(.largeTitle)
			.foregroundColor(.red)
			
			if let data = vm.data {
				Text(data)
			}
		}
	}
}

class WeakSelfSecondScreenViewModel: ObservableObject {
	
	@Published var data: String? = nil
	
	init() {
		print("INITIALIZE NOW")
		let currentCount = UserDefaults.standard.integer(forKey: "count")
		UserDefaults.standard.set(currentCount + 1, forKey: "count")
		getData()
	}
	
	deinit {
		print("DE-INITIALIZE NOW")
		let currentCount = UserDefaults.standard.integer(forKey: "count")
		UserDefaults.standard.set(currentCount - 1, forKey: "count")
	}
	
	func getData() {
		
//		data = "NEW DATA!!"
		
		/*
		 Strong reference cycle 의 경우 메인화면으로 되돌아가도
		 deinit 되지 않고 백그라운드에서 계속 작업을 수행한다.
		 weak self 를 사용해서 화면이 전환되는 경우 참조를 해제하여 메모리 누수를 막는다.
		 */
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
			self?.data = "NEW DATA!"
		}
		
	}
}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
