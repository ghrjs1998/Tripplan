//
//  PlaceRow.swift
//  tripplan
//
//  Created by 박호건 on 10/29/24.
//

import SwiftUI

struct PlaceRow: View {
    let place: Place
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            HStack{
                Text(formattedTime(place.startTime))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            HStack{
                VStack(alignment:.leading, spacing: 10){
                    Text(place.name)
                        .font(.title)
                    Text(place.category)
                }
                
                Spacer()
                
                
            }
            
            Button {
                
            } label: {
                if let linkTitle = place.linkTitle {
                    Text(linkTitle)
                        .underline()
                        .foregroundColor(.blue)
                }
            }
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//        HStack{
//            Button {
//
//            } label: {
//                Text("편집하기")
//                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//            }
//
//
//            Spacer()
//            Button {
//
//            } label: {
//                Text("메모추가")
//                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//            }
//
//
//        }
    }
}


#Preview {
    PlaceRow(place: Place(
        name: "예시 장소",
        category: "음식점",
        startTime: Date(),
        linkTitle: "링크 제목 예시",
        link: "https://example.com"
    ))
}
