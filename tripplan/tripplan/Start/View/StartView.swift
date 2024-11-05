//
//  StartView.swift
//  tripplan
//
//  Created by 박호건 on 10/25/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("나만의 여행 일지 앱")
                    Text("Trip Plan")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .font(.system(size: 32))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Rectangle()
                    .frame(width: 330, height: 395)
                    .cornerRadius(20)
                    .foregroundColor(.blue)
                
                Spacer()
                
                
                HStack(spacing: 20) {
                    
                    NavigationLink(destination: ContentView()) {
                        Text("둘러보기")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                    
                    NavigationLink(destination: LoginView()) {
                        Text("로그인/회원가입")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    StartView()
}
