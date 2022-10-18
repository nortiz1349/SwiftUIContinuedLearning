//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/17.
//

import SwiftUI

//struct PostModel: Identifiable, Codable {
//	let userId: Int
//	let id: Int
//	let title: String
//	let body: String
//}

class DownloadWithEscapingViewModel: ObservableObject {
	
	@Published var posts: [PostModel] = []
	
	init() {
		getPost()
	}
	
	func getPost() {
		
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
		
		downloadData(fromURL: url) { returnedData in
			if let data = returnedData {
				guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
				DispatchQueue.main.async { [weak self] in
					self?.posts = newPosts // UI를 업데이트 하는 작업이므로 main에서 작업
				}
			} else {
				print("No data returned")
			}
		}
	}
	
	func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let data = data,
				error == nil,
				let response = response as? HTTPURLResponse,
				200...299 ~= response.statusCode
//					response.statusCode >= 200 && response.statusCode < 300
			else {
				print("Error downloading data.")
				completionHandler(nil)
				return
			}
			completionHandler(data)
		}.resume()
	}
	
}

struct DownloadWithEscapingBootcamp: View {
	
	@StateObject var vm = DownloadWithEscapingViewModel()
	
    var body: some View {
		List {
			ForEach(vm.posts) { post in
				VStack(alignment: .leading) {
					Text(post.title)
						.font(.headline)
					Text(post.body)
						.foregroundColor(.secondary)
				}
			}
		}
		.listStyle(.plain)
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
