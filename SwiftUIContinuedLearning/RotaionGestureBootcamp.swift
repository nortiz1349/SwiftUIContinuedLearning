//
//  RotaionGestureBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/13.
//

import SwiftUI

struct RotaionGestureBootcamp: View {
	
	@State private var angle: Angle = Angle(degrees: 0)
    var body: some View {
        Text("Hello, World!")
			.font(.largeTitle)
			.fontWeight(.semibold)
			.foregroundColor(.white)
			.padding(50)
			.background(.blue)
			.cornerRadius(10)
			.rotationEffect(angle)
			.gesture(
				RotationGesture()
					.onChanged { value in
						angle = value
					}
					.onEnded { value in
						withAnimation(.spring()) {
							angle = Angle(degrees: 0)
						}
					}
			)
    }
}

struct RotaionGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotaionGestureBootcamp()
    }
}
