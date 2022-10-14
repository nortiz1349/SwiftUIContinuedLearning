//
//  LongPressGestureBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/13.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
	
	@GestureState private var isDetectingLongPress: Bool = false
	@State private var completedLongPress: Bool = false
	
    var body: some View {
		
		VStack {
			Rectangle()
				.fill(completedLongPress ? .green : .blue)
				.frame(maxWidth: isDetectingLongPress ? .infinity : 0)
				.frame(height: 55)
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(.gray)
			
			HStack {
				Text("CLICK HERE")
					.foregroundColor(.white)
					.padding()
					.background(.black)
					.cornerRadius(10)
				
				// ??
					.gesture(
						LongPressGesture(minimumDuration: 1.0, maximumDistance: 50)
							.updating($isDetectingLongPress) { currentState, gestureState, transaction in
								gestureState = currentState
								transaction.animation = Animation.easeInOut
							}
							.onEnded { finished in
								self.completedLongPress = finished
							}
							
						
					)
				// 제대로 작동하지 않음 - Deprecated
//					.onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
//						// start of press -> min duration
//						if isPressing {
//							withAnimation(.easeInOut(duration: 1.0)) {
//								isCompleted = true
//							}
//						} else {
//							DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//								if !isSuccess {
//									withAnimation(.easeInOut) {
//										isCompleted = false
//									}
//								}
//							}
//						}
//					} perform: {
//						// at the min duration
//						withAnimation(.easeInOut) {
//							isSuccess = true
//						}
//					}

//				Text("RESET")
//					.foregroundColor(.white)
//					.padding()
//					.background(.black)
//					.cornerRadius(10)
//					.onTapGesture {
//						isCompleted = false
//						isSuccess = false
//					}
			}
			
		}
		
//		Text(isCompleted ? "Completed" : "Not Completed")
//			.padding()
//			.padding(.horizontal)
//			.background(isCompleted ? .green : .gray)
//			.cornerRadius(10)
//			// maximumDistance : 터치 후 이동 가능한 거리, 1 은 싱글포인트
//			.onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
//				isCompleted.toggle()
//			}
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
