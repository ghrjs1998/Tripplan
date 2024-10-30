//
//  RegionListView.swift
//  tripplan
//
//  Created by 박호건 on 10/28/24.
//

import SwiftUI

struct RegionListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let country: String // 선택한 나라
    let regions: [String] // 해당 나라의 지역 목록
    
    var body: some View {
        NavigationStack {
            VStack {
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
                
                VStack(alignment: .leading){
                    Text("\(country)의 지역을 알려주세요!")
                        .font(.system(size: 24))
                    
                    Spacer()
                    
                    // 지역 목록 표시
                    VStack(spacing: 20) {
                        ForEach(regions, id: \.self) { region in
                            NavigationLink(destination: ItineraryView(destination: region)) {
                                Capsule()
                                    .frame(width: 350, height: 60)
                                    .foregroundColor(.blue)
                                    .overlay(
                                        Text(region)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    )
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    Spacer()
                    
                }
                .padding()
                .navigationBarBackButtonHidden()
                
            }
            Spacer()
        }
    }
}

#Preview {
    RegionListView(country: "일본", regions: ["후쿠오카", "도쿄", "오사카"])
}
