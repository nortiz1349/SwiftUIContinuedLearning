//
//  HashableBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/14.
//

import SwiftUI

struct myCustomModel: Hashable {
	let title: String
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(title)
	}
}

struct HashableBootcamp: View {
	
	private let data: [myCustomModel] = [
		myCustomModel(title: "ONE"),
		myCustomModel(title: "two"),
		myCustomModel(title: "three")
	]
	
    var body: some View {
		ScrollView {
			VStack(spacing: 20.0) {
//				ForEach(data) { item in
//					Text(item.id) // Identifiable 를 채택한 경우 고유 아이디를 생성함
//						.font(.headline)
//				}
				
				ForEach(data, id: \.self) { item in
					Text(item.hashValue.description) // String 타입은 고유의 hashvalue 를 가진다.
						.font(.headline)
				}
			}
		}
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
