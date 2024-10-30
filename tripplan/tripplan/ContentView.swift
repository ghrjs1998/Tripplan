//
//  ContentView.swift
//  tripplan
//
//  Created by 박호건 on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
            
            ItineraryView1()
                .tabItem {
                    Label("일정", systemImage: "calendar")
                }
            
            SaveView()
                .tabItem {
                    Label("저장", systemImage: "folder")
                }
            
            SettingsView()
                .tabItem {
                    Label("설정", systemImage: "person.crop.circle")
                }
        }
        .navigationBarBackButtonHidden()
    }
}


struct SaveView: View {
    var body: some View {
        NavigationView {
            Text("저장")
                .font(.title)
        }
    }
}

struct ItineraryView1: View {
    var body: some View {
        NavigationView {
            Text("일정")
                .font(.title)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Text("설정")
                .font(.title)
        }
    }
}

#Preview {
    ContentView()
}
