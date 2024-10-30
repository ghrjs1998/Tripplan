//
//  ModalView.swift
//  tripplan
//
//  Created by 박호건 on 10/30/24.
//


import SwiftUI

struct ModalView: View {
    @State private var placeName: String = ""
    @State private var startTime: Date = Calendar.current.startOfDay(for: Date())
    @State private var selectedCategory: String = "기타"
    @State private var linkTitle: String? = nil
    @State private var link: String? = nil
    
    let categories = ["교통", "숙소", "장소", "음식점", "기타"]
    var onSave: (Place) -> Void  // 저장 후 호출할 클로저
    
    var body: some View {
        VStack(alignment: .leading) {
            // 장소명 입력
            VStack(alignment: .leading) {
                Text("장소명")
                    .fontWeight(.semibold)
                TextField("장소 이름을 입력해주세요.", text: $placeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // 카테고리 선택
            VStack(alignment: .leading) {
                Text("카테고리")
                    .fontWeight(.semibold)
                Picker("카테고리를 선택해주세요", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            }
            
            // 시간 선택
            VStack(alignment: .leading) {
                Text("시간")
                    .fontWeight(.semibold)
                
                DatePicker("시작 시간", selection: $startTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                
            }
            
            // 링크 정보 입력
            VStack(alignment: .leading) {
                Text("링크 제목")
                    .fontWeight(.semibold)
                TextField("링크 제목을 입력해주세요.", text: Binding(
                    get: { linkTitle ?? "" },
                    set: { linkTitle = $0.isEmpty ? nil : $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading) {
                Text("링크")
                    .fontWeight(.semibold)
                TextField("링크를 입력해주세요.", text: Binding(
                    get: { link ?? "" },
                    set: { link = $0.isEmpty ? nil : $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Spacer()
            
            // 다음 버튼
            Button {
                let place = Place(
                    name: placeName,
                    category: selectedCategory,
                    startTime: startTime,
                    linkTitle: linkTitle,
                    link: link
                )
                print("저장된 데이터: \(place)")  // 콘솔 출력
                onSave(place)  // 부모 뷰에 데이터 전달
            } label: {
                Text("다음")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
}

// 데이터 모델 정의
struct Place: CustomStringConvertible {
    let name: String
    let category: String
    let startTime: Date
    let linkTitle: String?
    let link: String?
    
    // 디버깅용 출력 포맷 정의
    var description: String {
        """
        \n
        Place:
          - Name: \(name)
          - Category: \(category)
          - Start Time: \(formattedTime(startTime))
          - Link Title: \(linkTitle ?? "N/A")
          - Link: \(link ?? "N/A")
        """
    }
    
     func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    ModalView { place in
        
    }
}
