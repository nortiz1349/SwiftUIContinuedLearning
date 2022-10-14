//
//  DragGestureBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/13.
//

import SwiftUI

struct DragGestureBootcamp: View {
	
	@State private var offset: CGSize = .zero
	
    var body: some View {
		ZStack {
			
			VStack {
				Text("\(offset.width)")
				Spacer()
			}
			
			RoundedRectangle(cornerRadius: 20)
				.frame(width: 300, height: 500)
				.offset(offset)
				.scaleEffect(getScaleAmount())
				.rotationEffect(Angle(degrees: getRotationAmount()))
				.gesture(
					DragGesture()
						.onChanged { value in
							withAnimation(.spring()) {
								offset = value.translation
							}
						}
						.onEnded { value in
							withAnimation(.spring()) {
								offset = .zero
							}
						}
			)
		}
    }
	
	private func getScaleAmount() -> CGFloat {
		let max = UIScreen.main.bounds.width / 2
		let currentAmount = abs(offset.width)
		let percentage = currentAmount / max
		return 1.0 - min(percentage, 0.5) * 0.5
	}
	
	private func getRotationAmount() -> Double {
		let max = UIScreen.main.bounds.width / 2
		let currentAmount = offset.width
		let percentage = currentAmount / max
		let percentageAsDouble = Double(percentage)
		let maxAngle: Double = 10
		return percentageAsDouble * maxAngle
	}
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp()
    }
}
