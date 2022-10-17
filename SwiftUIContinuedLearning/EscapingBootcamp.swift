//
//  EscapingBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/17.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
	
	@Published var text: String = "Hello"
	
	func getData() {
		downloadData5 { [weak self] returnedData in
			self?.text = returnedData.data
		}
		
	}
	
	func downloadData() -> String {
		return "New data!"
	}
	
	func downloadData2(completionHandler: (_ data: String) -> ()) {
		completionHandler("New data!")
	}
	
	func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			completionHandler("New data!")
		}
	}
	
	func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			let result = DownloadResult(data: "New data!")
			completionHandler(result)
		}
	}
	
	func downloadData5(completionHandler: @escaping DownloadCompletion) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			let result = DownloadResult(data: "New data!")
			completionHandler(result)
		}
	}
}

struct DownloadResult {
	let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
	
	@StateObject var vm = EscapingViewModel()
	
    var body: some View {
		Text(vm.text)
			.font(.largeTitle)
			.fontWeight(.semibold)
			.foregroundColor(Color.blue)
			.onTapGesture {
				vm.getData()
			}
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
