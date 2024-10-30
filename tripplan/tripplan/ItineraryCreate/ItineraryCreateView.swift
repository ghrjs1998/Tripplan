//
//  ItinaryCreateView.swift
//  tripplan
//
//  Created by 박호건 on 10/24/24.
//

import SwiftUI

struct ItineraryCreateView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                
                
                VStack(alignment: .leading) {
                    Text("이번 여행에 대해\n알려주세요!")
                        .font(.system(size: 24))
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        navigationButton(country: "일본", regions: ["도쿄", "후쿠오카", "오사카"])
                        navigationButton(country: "대만", regions: ["타이베이", "가오슝", "타이난"])
                        navigationButton(country: "홍콩", regions: ["중앙", "카오룽", "신계"])
                    }
                    
                    
                    Spacer()
                }
                .padding()
                .navigationBarBackButtonHidden()
                
                Spacer()
            }
            
        }
    }
    
    // 버튼 컴포넌트
    private func navigationButton(country: String, regions: [String]) -> some View {
        NavigationLink(destination: RegionListView(country: country, regions: regions)) {
            Text(country)
                .frame(width: 350, height: 60)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(30)
                .shadow(radius: 5)
        }
    }
}


#Preview {
    ItineraryCreateView()
}
