//
//  DragGestureBootcamp2.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/13.
//

import SwiftUI

struct DragGestureBootcamp2: View {
	
	@State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
	@State private var currentDragOffsetY: CGFloat = 0
	@State private var endingOffsetY: CGFloat = 0
	
    var body: some View {
		ZStack {
			Color.green.ignoresSafeArea()
			
			MySignUpView()
				.offset(y: startingOffsetY)
				.offset(y: currentDragOffsetY)
				.offset(y: endingOffsetY)
				.gesture(
					DragGesture()
						.onChanged { value in
							withAnimation(.spring()) {
								currentDragOffsetY = value.translation.height
							}
						}
						.onEnded { value in
							withAnimation(.spring()) {
								if currentDragOffsetY < -150 {
									endingOffsetY = -startingOffsetY
								} else if endingOffsetY != 0 && currentDragOffsetY > 150 {
									endingOffsetY = 0
								}
								currentDragOffsetY = 0
								
							}
						}
				)
			
			VStack(alignment: .leading) {
				Text("startingOffsetY: \(startingOffsetY)")
				Text("currentDragOffsetY: \(currentDragOffsetY)")
				Text("endingOffsetY: \(endingOffsetY)")
			}
			
		}
		.ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureBootcamp2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp2()
    }
}

struct MySignUpView: View {
	var body: some View {
		VStack(spacing: 20.0) {
			Image(systemName: "chevron.up")
				.padding(.top)
			Text("Sign up")
				.font(.headline)
				.fontWeight(.semibold)
			
			Image(systemName: "flame.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
			
			Text("This is the description for our app. This is my favorite SwiftUI course and I recommend to all of my friends to subscribe to Swiftful Thinking!")
				.multilineTextAlignment(.center)
			
			Text("CREATE AN ACCOUNT")
				.foregroundColor(.white)
				.font(.headline)
				.padding()
				.padding(.horizontal)
				.background(Color.black.cornerRadius(10))
			
			Spacer()
		}
		.frame(maxWidth: .infinity)
		.background(.white)
		.cornerRadius(30)
	}
}
