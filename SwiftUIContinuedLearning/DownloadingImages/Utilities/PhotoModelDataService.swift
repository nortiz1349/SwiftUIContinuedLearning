//
//  PhotoModelDataService.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/18.
//

import Foundation
import Combine

class PhotoModelDataService {
	
	static let instance = PhotoModelDataService()
	
	@Published var photoModels: [PhotoModel] = []
	private var cancellables = Set<AnyCancellable>()
	
	private init() {
		downloadData()
	}
	
	func downloadData() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
		
		URLSession.shared
			.dataTaskPublisher(for: url)
			.subscribe(on: DispatchQueue.global(qos: .background))
			.receive(on: DispatchQueue.main)
			.tryMap(handleOutput)
			.decode(type: [PhotoModel].self, decoder: JSONDecoder())
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("Error downloading data. \(error)")
				}
			} receiveValue: { [weak self] returnedPhotoModels in
				self?.photoModels = returnedPhotoModels
			}
			.store(in: &cancellables)
	}
	
	private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard
			let response = output.response as? HTTPURLResponse,
			200..<300 ~= response.statusCode else {
			throw URLError(.badServerResponse)
		}
		return output.data
	}
}
