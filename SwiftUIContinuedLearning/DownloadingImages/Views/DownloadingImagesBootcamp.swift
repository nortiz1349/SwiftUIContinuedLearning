//
//  DownloadingImagesBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/18.
//

import SwiftUI

// Codable
// background threads
// weak self
// Combine
// Publishers and Subscribers
// FileManager
// NSCache

struct DownloadingImagesBootcamp: View {
	
	@StateObject var vm = DownloadingImagesViewModel()
	
	var body: some View {
		NavigationView {
			List {
				ForEach(vm.dataArray) { model in
					DownloadingImagesRow(model: model)
				}
			}
			.listStyle(.plain)
			.navigationTitle("Downloading Images!")
		}
	}
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
	static var previews: some View {
		DownloadingImagesBootcamp()
	}
}
