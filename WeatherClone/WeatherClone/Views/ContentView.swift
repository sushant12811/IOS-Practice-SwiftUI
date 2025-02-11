import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State private var weather: WeatherData?

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.navyBlue, Color.lightBlue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                if let location = locationManager.location{
                    if let weather = weather{
                        Text("\(weather.name)")
                        Text("\(location.latitude), \(location.longitude)")
                    }else{
                        ProgressView()
                            .task {
                                do{
                                    weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                }catch{
                                    print("Error getting weather:\(error)")
                                }
                            }
                    }
                }else{
                    if locationManager.isLoading{
                        ProgressView()
                    }else{
                        WelcomeView()
                           .environmentObject(locationManager)
                    }
                }
                
                
                
                
            }
            
        }
    }
}

#Preview{
    ContentView()
}
