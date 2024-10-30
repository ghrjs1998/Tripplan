//
//  ItineraryDetailView.swift
//  tripplan
//
//  Created by 박호건 on 10/28/24.
//

import SwiftUI

struct CountryListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // 뒤로 가기 버튼
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 34))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding()
                .padding(.bottom, 20)
                
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("이번 여행에 대해\n알려주세요!")
                        .font(.system(size: 24))
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        navigationButton(destination: "일본", title: "일본")
                        navigationButton(destination: "대만", title: "대만")
                        navigationButton(destination: "미국", title: "미국")
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationBarBackButtonHidden()
                
                Spacer()
            }
            
        }
    }
    
    // NavigationLink가 포함된 버튼 컴포넌트
    private func navigationButton(destination: String, title: String) -> some View {
        NavigationLink(destination: ItineraryView(destination: destination)) {
            Text(title)
                .frame(width: 350, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
        }
    }
}

#Preview {
    CountryListView()
}
