//
//  PhotoModelFileManager.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/18.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
	
	static let instance = PhotoModelFileManager()
	let folderName = "downloaded_photos"
	
	private init() {
		createFolerIfNeeded()
	}
	
	private func createFolerIfNeeded() {
		guard let url = getFolderPath() else { return }
		
		if !FileManager.default.fileExists(atPath: url.path) {
			do {
				try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
				print("Created Folder!")
			} catch let error {
				print("Error creating folder. \(error)")
			}
		}
	}
	
	private func getFolderPath() -> URL? {
		return FileManager
			.default
			.urls(for: .cachesDirectory, in: .userDomainMask)
			.first?
			.appendingPathComponent(folderName, conformingTo: .directory)
		
	}
	
	private func getImagePath(key: String) -> URL? {
		guard let foler = getFolderPath() else {
			return nil
		}
		return foler.appendingPathComponent(key, conformingTo: .png)
	}
	
	func add(key: String, value: UIImage) {
		guard
			let data = value.pngData(),
			let url = getImagePath(key: key) else { return }
		do {
			try data.write(to: url)
		} catch let error {
			print("Error saving to file manager. \(error)")
		}
	}
	
	func get(key: String) -> UIImage? {
		guard
			let url = getImagePath(key: key),
			FileManager.default.fileExists(atPath: url.path) else {
			return nil
		}
		return UIImage(contentsOfFile: url.path)
	}
}
