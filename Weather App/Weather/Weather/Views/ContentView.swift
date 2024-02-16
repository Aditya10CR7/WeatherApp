//
//  ContentView.swift/Users/adityapandiarajan/Desktop/Swift Programming/Weather App/Weather/Weather/ContentView.swift
//  Weather
//
//  Created by Aditya Pandiarajan on 12/02/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch  {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
                     } else {
                    if locationManager.isLoading {
                        LoadingView()
                    } else {
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
                }
            
            
        }
        .background(Color(hue: 0.628, saturation: 0.768, brightness: 0.447))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

#Preview {
    ContentView()
}
