//
//  TypealiasBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/17.
//

import SwiftUI

struct MovieModel {
	let title: String
	let director: String
	let count: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
	
	@State private var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
	@State private var item2: TVModel = TVModel(title: "TV Title", director: "Emmily", count: 10)
	
    var body: some View {
		VStack {
			Text(item.title)
			Text(item.director)
			Text("\(item.count)")
		}
    }
}

struct TypealiasBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasBootcamp()
    }
}
