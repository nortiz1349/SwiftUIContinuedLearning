//
//  CoreDataBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/14.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {

	let container: NSPersistentContainer
	@Published var savedEntities: [FruitEntity] = []
	
	init() {
		container = NSPersistentContainer(name: "FruitsContainer")
		container.loadPersistentStores { description, error in
			if let error = error {
				print("ERROR LOADING CORE DATA. \(error)")
			}
		}
		fetchFruit()
	}
	
	func fetchFruit() {
		let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
		
		do {
			savedEntities = try container.viewContext.fetch(request)
		} catch {
			print("Error fetching. \(error)")
		}
	}
	
	func addFruit(text: String) {
		let newFruit = FruitEntity(context: container.viewContext)
		newFruit.name = text
		saveData()
	}
	
	func updateFruit(entity: FruitEntity) {
		let currentName = entity.name ?? ""
		let newName = currentName + "!"
		entity.name = newName
		saveData()
	}
	
	func deleteFruit(indexSet: IndexSet) {
		guard let index = indexSet.first else { return }
		let entity = savedEntities[index]
		container.viewContext.delete(entity)
		saveData()
	}
	
	func saveData() {
		do {
			try container.viewContext.save()
			fetchFruit()
		} catch let error {
			print("Error saving. \(error)")
		}
	}
}

struct CoreDataBootcamp: View {
	
	@StateObject private var vm = CoreDataViewModel()
	@State private var textFieldText: String = ""
	
    var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				TextField("Add fruit...", text: $textFieldText)
					.font(.headline)
					.padding(.leading)
					.frame(height: 55)
					.background(Color(UIColor.secondarySystemBackground))
					.cornerRadius(10)
					.padding(.horizontal)
				
				Button {
					guard !textFieldText.isEmpty else { return }
					vm.addFruit(text: textFieldText)
					textFieldText = ""
				} label: {
					Text("Button")
						.font(.headline)
						.foregroundColor(.white)
						.frame(height: 55)
						.frame(maxWidth: .infinity)
						.background(.blue)
						.cornerRadius(10)
				}
				.padding(.horizontal)
				
				List {
					ForEach(vm.savedEntities) { entity in
						Text(entity.name ?? "No Name")
							.onTapGesture {
								vm.updateFruit(entity: entity)
							}
					}
					.onDelete(perform: vm.deleteFruit)
				}
				.listStyle(.plain)
				
			}
			.navigationTitle("Fruits")
		}
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}
