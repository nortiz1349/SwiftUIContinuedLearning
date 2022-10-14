//
//  MaskBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/14.
//

import SwiftUI

struct MaskBootcamp: View {
	
	@State private var rating: Int = 0
	
	var body: some View {
		ZStack {
			starsView
				.overlay(overlayView.mask(starsView))
		}
	}
	
	private var overlayView: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				Rectangle()
//					.foregroundColor(.yellow)
					.fill(LinearGradient(
						colors: [Color(#colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1))],
						startPoint: .leading,
						endPoint: .trailing))
					.frame(width: CGFloat(rating) / 5 * geometry.size.width)
			}
		}
		.allowsHitTesting(false)
	}
	
	private var starsView: some View {
		HStack {
			ForEach(1..<6) { index in
				Image(systemName: "star.fill")
					.font(.largeTitle)
					.foregroundColor(.gray)
					.onTapGesture {
						withAnimation(.easeInOut) {
							rating = index
						}
					}
			}
		}
	}
}

struct MaskBootcamp_Previews: PreviewProvider {
	static var previews: some View {
		MaskBootcamp()
	}
}
