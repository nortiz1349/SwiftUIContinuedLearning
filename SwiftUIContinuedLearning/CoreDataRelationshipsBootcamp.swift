//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/16.
//

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity

class CoreDataManager {
	
	static let instance = CoreDataManager()
	let container: NSPersistentContainer
	let context: NSManagedObjectContext
	
	init() {
		container = NSPersistentContainer(name: "CoreDataContainer")
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Error loading Data... \(error)")
			}
		}
		context = container.viewContext
	}
	
	func save() {
		do {
			try context.save()
			print("Save successfully")
		} catch let error {
			print("Error Saving Core Data \(error.localizedDescription)")
		}
		
	}
	
}

class CoreDataRelationshipViewModel: ObservableObject {
	
	let manager = CoreDataManager.instance
	@Published var businesses: [BusinessEntity] = []
	@Published var departments: [DepartmentEntity] = []
	@Published var employees: [EmployeeEntity] = []
	
	init() {
		getBusiness()
		getDepartment()
		getEmployee()
	}
	
	func getBusiness() {
		let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
		
		do {
			businesses = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching... \(error.localizedDescription)")
		}
	}
	
	func getDepartment() {
		let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
		
		do {
			departments = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching... \(error.localizedDescription)")
		}
	}
	
	func getEmployee() {
		let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
		
		do {
			employees = try manager.context.fetch(request)
		} catch let error {
			print("Error fetching... \(error.localizedDescription)")
		}
	}
	
	func addBusiness() {
		let newBusiness = BusinessEntity(context: manager.context)
		newBusiness.name = "Microsoft"
		
		// add existing departments to the new business
		newBusiness.departments = [departments[0], departments[1]]
		
		// add existing employees to the new business
		newBusiness.employees = [employees[1]]
		
		// add new business to existing department
//		newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
		
		// add new business to existing employee
//		newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
		
		save()
	}
	
	func addDepartment() {
		let newDepartment = DepartmentEntity(context: manager.context)
		newDepartment.name = "Engineering"
//		newDepartment.businesses = [businesses[0]]
		
//		newDepartment.employees = [employees[1]]
		newDepartment.addToEmployees(employees[1])
		
		save()
	}
	
	func addEmployee() {
		let newEmployee = EmployeeEntity(context: manager.context)
		newEmployee.age = 99
		newEmployee.dateJoined = Date()
		newEmployee.name = "Emily"
		
//		newEmployee.business = businesses[0]
//		newEmployee.department = departments[0]
		save()
	}
	
	func save() {
		businesses.removeAll()
		departments.removeAll()
		employees.removeAll()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.manager.save()
			self.getBusiness()
			self.getDepartment()
			self.getEmployee()
		}
	}
	
}

struct CoreDataRelationshipsBootcamp: View {
	
	@StateObject private var vm = CoreDataRelationshipViewModel()
	
	
    var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 20) {
					Button {
						vm.addBusiness()
					} label: {
						Text("Peform Action")
							.foregroundColor(.white)
							.frame(height: 55)
							.frame(maxWidth: .infinity)
							.background(Color.blue.cornerRadius(10))
					}
					.padding()
					
					ScrollView(.horizontal, showsIndicators: true) {
						HStack(alignment: .top) {
							ForEach(vm.businesses) { business in
								BusinessView(entity: business)
							}
						}
					}
					
					ScrollView(.horizontal, showsIndicators: true) {
						HStack(alignment: .top) {
							ForEach(vm.departments) { department in
								DepartmentView(entity: department)
							}
						}
					}
					
					ScrollView(.horizontal, showsIndicators: true) {
						HStack(alignment: .top) {
							ForEach(vm.employees) { employee in
								EmployeeView(entity: employee)
							}
						}
					}
				}
				.padding()
			}
			.navigationTitle("Relationships")
		}
    }
}

struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}

struct BusinessView: View {
	
	let entity: BusinessEntity
	
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()
			
			if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
				Text("Departments:")
					.bold()
				ForEach(departments) { department in
					Text(department.name ?? "")
				}
			}
			
			if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
				Text("Employees:")
					.bold()
				ForEach(employees) { employee in
					Text(employee.name ?? "")
				}
			}
		}
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(Color(UIColor.secondarySystemBackground))
		.cornerRadius(10)
		.shadow(radius: 10)
	}
}

struct DepartmentView: View {
	
	let entity: DepartmentEntity
	
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()
			
			if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
				Text("Businesses:")
					.bold()
				ForEach(businesses) { business in
					Text(business.name ?? "")
				}
			}
			
			if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
				Text("Employees:")
					.bold()
				ForEach(employees) { employee in
					Text(employee.name ?? "")
				}
			}
		}
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(Color.green.opacity(0.3).cornerRadius(10))
		.shadow(radius: 10)
	}
}

struct EmployeeView: View {
	
	let entity: EmployeeEntity
	
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text("Name: \(entity.name ?? "")")
				.bold()
			
			Text("Age: \(entity.age)")
			Text("Date joined: \(entity.dateJoined ?? Date())")
			
			Text("Business:")
				.bold()
			
			Text(entity.business?.name ?? "")
			
			Text("Department:")
				.bold()
			
			Text(entity.department?.name ?? "")
			
		}
		.padding()
		.frame(maxWidth: 300, alignment: .leading)
		.background(Color.blue.opacity(0.3).cornerRadius(10))
		.shadow(radius: 10)
	}
}
