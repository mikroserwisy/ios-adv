import Combine

protocol LocationProvider {

    func refreshLocation()
    
    var location: AnyPublisher<(Double, Double), Never> { get }
    
}
