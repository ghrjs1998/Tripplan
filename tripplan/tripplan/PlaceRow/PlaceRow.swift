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
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3, x: 0, y: 3)
                        
                }
                
                Spacer()
                
                
            }
            
            Button {
                
            } label: {
                if let linkTitle = place.linkTitle {
                    Text(linkTitle)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3, x: -3, y: 3)
                }
            }
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .padding(.top, 10)
    }
}


#Preview {
    PlaceRow(place: Place(
        name: "예시 장소",
        category: "음식점",
        startTime: Date(),
        linkTitle: "google",
        link: "https://example.com"
    ))
}
