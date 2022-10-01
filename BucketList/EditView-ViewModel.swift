//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Vincent Salinas on 9/30/22.
//

import Foundation

extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    class ViewModel: ObservableObject {
        @Published private(set) var pages = [Page]()
        @Published private(set) var loadingState = LoadingState.loading
        
        func fetchNearbyPlaces(location: Location) async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                // success – convert the array values to our pages array
                DispatchQueue.main.async {
                    self.pages = items.query.pages.values.sorted()
                    self.loadingState = .loaded
                }
            } catch {
                // if we're still here it means the request failed somehow
                DispatchQueue.main.async {
                    self.loadingState = .failed
                }
            }
        }
        
        func createNewLoc(location: Location, name: String, description: String) -> Location {
            let newLocation = Location(id: UUID(), name: name, description: description, latitude: location.latitude, longitude: location.longitude)
            
            return newLocation
        }
    }
    
}
