//
//  DownloadingImagesViewModel.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/18.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
	
	@Published var dataArray: [PhotoModel] = []
	private var cancellables = Set<AnyCancellable>()
	
	let dataService = PhotoModelDataService.instance
	
	init() {
		addSubscriber()
	}
	
	func addSubscriber() {
		dataService.$photoModels
			.sink { returnedPhotoModel in
				self.dataArray = returnedPhotoModel
			}
			.store(in: &cancellables)
	}
}
