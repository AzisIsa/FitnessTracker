

import MapKit

protocol Run {
	
	var type: Activity { get }
	
	///The total amount of energy burned in kilocalories
	var totalCalories: Double { get }
	/// The total distance in meters
	var totalDistance: Double { get }
	
	var start: Date { get }
	var end: Date { get }
	var duration: TimeInterval { get }
	/// The average pace in seconds per kilometer.
	var pace: TimeInterval { get }
	/// The current pace in seconds per kilometer when relevant, `nil` otherwise.
	var currentPace: TimeInterval? { get }
	
	var route: [MKPolyline] { get }
	var startPosition: MKPointAnnotation? { get }
	var endPosition: MKPointAnnotation? { get }
	
	/// Load all additional data such as the workout route. If all data is already loaded this method may not be implemented.
	func loadAdditionalData(completion: @escaping (Bool) -> Void)

}

extension Run {
	
	var name: String {
		return start.getFormattedDateTime()
	}
	
	var pace: TimeInterval {
		return totalDistance > 0 ? duration / totalDistance * 1000 : 0
	}
	
	var currentPace: TimeInterval? {
		return nil
	}
	
	func annotation(for location: CLLocation, isStart: Bool) -> MKPointAnnotation {
		let ann = MKPointAnnotation()
		ann.coordinate = location.coordinate
		ann.title = isStart ? "Start" : "End"
		
		return ann
	}
	
	func loadAdditionalData(completion: @escaping (Bool) -> Void) {
		completion(true)
	}
	
}
