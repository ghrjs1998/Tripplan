//
//  HomeView.swift
//  tripplan
//
//  Created by 박호건 on 10/28/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 10) {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                    Text("\(viewModel.userName) 님")
                    
                    Spacer()
                    
                    Button {
                        // 알림 버튼 기능 구현
                    } label: {
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("어디로 떠나시나요?")
                        .font(.system(size: 24))
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 323, height: 191)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        NavigationLink(destination: ItineraryCreateView()) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
