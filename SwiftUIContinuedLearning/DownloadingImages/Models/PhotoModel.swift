//
//  PhotoModel.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/18.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
	let albumId: Int
	let id: Int
	let title: String
	let url: String
	let thumbnailUrl: String
}

/*
 {
 "albumId": 1,
 "id": 1,
 "title": "accusamus beatae ad facilis cum similique qui sunt",
 "url": "https://via.placeholder.com/600/92c952",
 "thumbnailUrl": "https://via.placeholder.com/150/92c952"
 },
 */
