//
//  CacheBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/18.
//

import SwiftUI

class CacheManager {
	
	static let instance = CacheManager()
	private init() { }
	
	var imageCache: NSCache<NSString, UIImage> = {
		let cache = NSCache<NSString, UIImage>()
		cache.countLimit = 100
		cache.totalCostLimit = 1024 * 1024 // 100mb
		return cache
	}()
	
	func add(image: UIImage, name: String) -> String {
		imageCache.setObject(image, forKey: name as NSString)
		return "Added to cache!"
	}
	
	func remove(name: String) -> String {
		imageCache.removeObject(forKey: name as NSString)
		return "Remove from cache!"
	}
	
	func get(name: String) -> UIImage? {
		return imageCache.object(forKey: name as NSString)
	}
}


class CacheViewModel: ObservableObject {
	
	@Published var startingImage: UIImage? = nil
	@Published var cachedImage: UIImage? = nil
	@Published var infoMessage: String = ""
	let imageName = "sample_image"
	let manager = CacheManager.instance
	
	init() {
		getImageFromeAssetsFoler()
	}
	
	func getImageFromeAssetsFoler() {
		startingImage = UIImage(named: imageName)
	}
	
	func saveToCache() {
		guard let image = startingImage else { return }
		infoMessage = manager.add(image: image, name: imageName)
	}
	
	func removeFromCache() {
		infoMessage = manager.remove(name: imageName)
	}
	
	func getFromCache() {
		if let returnedImage = manager.get(name: imageName) {
			cachedImage = returnedImage
			infoMessage = "Got image from Cache"
		} else {
			infoMessage = "Image not found in Cache"
		}
	}
	
}

struct CacheBootcamp: View {
	
	@StateObject private var vm = CacheViewModel()
	
	var body: some View {
		NavigationView {
			VStack {
				if let image = vm.startingImage {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(height: 200)
						.clipped()
						.cornerRadius(10)
						.shadow(radius: 5)
						.padding()
				}
				
				Text(vm.infoMessage)
					.font(.headline)
				
				HStack {
					Button {
						vm.saveToCache()
					} label: {
						Label("Save \nto Cache", systemImage: "tray.and.arrow.down.fill")
							.font(.headline)
							.padding(5)
					}
					.shadow(radius: 2, x: 4, y: 4)
					.buttonStyle(.borderedProminent)
					
					Button {
						vm.removeFromCache()
					} label: {
						Label("Delete \nfrom Cache", systemImage: "tray.and.arrow.up.fill")
							.font(.headline)
							.padding(5)
					}
					.shadow(radius: 2, x: 4, y: 4)
					.buttonStyle(.borderedProminent)
					.tint(.red)
				}
				
				Button {
					vm.getFromCache()
				} label: {
					Text("Get from Cache")
						.font(.headline)
						.padding(5)
				}
				.shadow(radius: 2, x: 4, y: 4)
				.buttonStyle(.borderedProminent)
				.tint(.green)
				
				if let image = vm.cachedImage {
					Image(uiImage: image)
						.resizable()
						.scaledToFill()
						.frame(height: 200)
						.clipped()
						.cornerRadius(10)
						.shadow(radius: 5)
						.padding()
				}
				Spacer()
			}
			.navigationTitle("Cache Bootcamp")
		}
	}
}

struct CacheBootcamp_Previews: PreviewProvider {
	static var previews: some View {
		CacheBootcamp()
	}
}
