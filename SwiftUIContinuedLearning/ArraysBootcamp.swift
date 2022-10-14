//
//  ArraysBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/14.
//

import SwiftUI

struct UserModel: Identifiable {
	let id = UUID().uuidString
	let name: String?
	let point: Int
	let isVerified: Bool
}

class ArrayModificaionViewModel: ObservableObject {
	
	@Published var dataArray: [UserModel] = []
	@Published var filteredArray: [UserModel] = []
	@Published var mappedArray: [String] = []
	
	init() {
		getUsers()
		updateFilterArray()
	}
	
	func updateFilterArray() {
		// sort
		/*
		 filteredArray = dataArray.sorted { user1, user2 in
		 return user1.point > user2.point
		 }
		 // -> 축약형
		 filteredArray = dataArray.sorted(by: {$0.point < $1.point})
		 */
		
		// filter
		/*
		 //		filteredArray = dataArray.filter({ user in
		 //			user.point > 50 && user.isVerified
		 //			user.name.contains("i")
		 //		})
		 // -> 축약형
		 filteredArray = dataArray.filter { $0.isVerified && $0.point > 30}
		 */
		
		// map
		/*
//		mappedArray = dataArray.map { user in
//			user.name
//		}
		// -> 축약형
//		mappedArray = dataArray.map { $0.name ?? "ERROR" }
		// 리스트에 nil 이 있는 경우
		// -> 리스트에 ERROR 가 표시된다. so use compactMap(non-nil 결과만 반환한다.)
		mappedArray = dataArray.compactMap { $0.name }
		*/
		
//		let sort = dataArray.sorted { $0.point > $1.point }
//		let filter = dataArray.filter { $0.isVerified }
//		let map = dataArray.compactMap { $0.name }
		
		mappedArray = dataArray
			.sorted { $0.point > $1.point }
			.filter { $0.isVerified }
			.compactMap { $0.name }
	}
	
	func getUsers() {
		let user1 = UserModel(name: "Nick", point: 5, isVerified: true)
		let user2 = UserModel(name: "Chris", point: 0, isVerified: false)
		let user3 = UserModel(name: nil, point: 20, isVerified: true)
		let user4 = UserModel(name: "Emiley", point: 50, isVerified: false)
		let user5 = UserModel(name: "Samantha", point: 45, isVerified: true)
		let user6 = UserModel(name: "Jason", point: 23, isVerified: false)
		let user7 = UserModel(name: "Sarah", point: 76, isVerified: true)
		let user8 = UserModel(name: nil, point: 45, isVerified: false)
		let user9 = UserModel(name: "Steve", point: 1, isVerified: true)
		let user10 = UserModel(name: "Jack", point: 100, isVerified: true)
		self.dataArray.append(contentsOf: [
			user1,
			user2,
			user3,
			user4,
			user5,
			user6,
			user7,
			user8,
			user9,
			user10,
		])
	}
	
}

struct ArraysBootcamp: View {
	
	@StateObject var vm = ArrayModificaionViewModel()
	
	var body: some View {
		ScrollView {
			VStack(spacing: 10) {
				ForEach(vm.mappedArray, id: \.self) { name in
					Text(name)
						.font(.title)
				}
//				ForEach(vm.filteredArray) { user in
//					VStack(alignment: .leading) {
//						Text(user.name)
//							.font(.headline)
//						HStack {
//							Text("Points: \(user.point)")
//							Spacer()
//							if user.isVerified {
//								Image(systemName: "flame.fill")
//							}
//						}
//					}
//					.foregroundColor(.white)
//					.padding()
//					.background(Color.blue.cornerRadius(10))
//					.padding(.horizontal)
			}
		}
	}
}


struct ArraysBootcamp_Previews: PreviewProvider {
	static var previews: some View {
		ArraysBootcamp()
	}
}
