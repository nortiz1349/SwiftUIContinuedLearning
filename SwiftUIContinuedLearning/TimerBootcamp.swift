//
//  TimerBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/17.
//

import SwiftUI

struct TimerBootcamp: View {
	
	private let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
	
	// Current Time
	/*
	@State private var currentDate: Date = Date()
	var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.timeStyle = .medium
		return formatter
	}
	*/
	
	// Countdown
	/*
	@State private var count: Int = 10
	@State private var finishedText: String? = nil
	*/
	
	// Countdown to date
	/*
	@State private var timeRemaining: String = ""
	let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
	
	func updateTimeRemaining() {
		let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
		let hour = remaining.hour ?? 0
		let minute = remaining.minute ?? 0
		let second = remaining.second ?? 0
		timeRemaining = "\(hour):\(minute):\(second)"
	}
	*/
	
	// Animation counter
	@State var count: Int = 1
	
    var body: some View {
		ZStack {
			RadialGradient(
				gradient: Gradient(colors: [Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1))]),
				center: .center,
				startRadius: 5,
				endRadius: 500)
			.ignoresSafeArea()
			
			TabView(selection: $count) {
				Rectangle()
					.foregroundColor(.red)
					.tag(1)
				Rectangle()
					.foregroundColor(.blue)
					.tag(2)
				Rectangle()
					.foregroundColor(.green)
					.tag(3)
				Rectangle()
					.foregroundColor(.orange)
					.tag(4)
				Rectangle()
					.foregroundColor(.pink)
					.tag(5)
			}
			.frame(height: 200)
			.tabViewStyle(.page)
//			HStack(spacing: 15.0) {
//				Circle()
//					.offset(y: count == 1 ? -20 : 0)
//				Circle()
//					.offset(y: count == 2 ? -20 : 0)
//				Circle()
//					.offset(y: count == 3 ? -20 : 0)
//			}
//			.frame(width: 150)
//			.foregroundColor(.white)
			
		}
		.onReceive(timer) { _ in
			withAnimation(.default) {
				count = count == 5 ? 0 : count + 1
			}
		}
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
