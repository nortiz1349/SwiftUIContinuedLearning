//
//  DownloadWithCombineBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/17.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
	
	@Published var posts: [PostModel] = []
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		getPost()
	}
	
	func getPost() {
		
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
		
		// Combine discussion:
		/*
		// 1. sign up for monthly subscription for package to be delivered
		// 2. the company would make the package behind the scene
		// 3. receive the package at your front door
		// 4. make sure the box isn't damaged
		// 5. open and make sure the item is correct
		// 6. use the item!!
		// 7. cancellable at any time!!
		
		// 1. create the publisher
		// 2. subscribing publisher on background thread
		// 3. recieve on main thread
		// 4. tryMap (check that the data is good)
		// 5. decode (decode data into PostModels)
		// 6. sink (put the item into our app)
		// 7. store (cancel subscription if needed)
		*/
		URLSession.shared
			.dataTaskPublisher(for: url)
			.subscribe(on: DispatchQueue.global(qos: .background))
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: [PostModel].self, decoder: JSONDecoder())
//			.replaceError(with: []) // 에러 print 하지 않을때
//			.sink(receiveValue: { [weak self] returnedPosts in
//				self?.posts = returnedPost
//			})
			.sink { completion in
				switch completion {
				case .finished:
					print("finished")
				case .failure(let error):
					print("There was an error. \(error)")
				}
			} receiveValue: { [weak self] returnedPost in
				self?.posts = returnedPost
			}
			.store(in: &cancellables)

	}
	
	func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard
			let response = output.response as? HTTPURLResponse,
			200..<300 ~= response.statusCode else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
	
}

struct DownloadWithCombineBootcamp: View {
	
	@StateObject private var vm = DownloadWithCombineViewModel()
	
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

struct DownloadWithCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineBootcamp()
    }
}
