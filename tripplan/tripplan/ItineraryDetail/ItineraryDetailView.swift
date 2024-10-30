//
//  ItineraryDetailView.swift
//  tripplan
//
//  Created by 박호건 on 10/29/24.
//

import SwiftUI

struct ItineraryDetailView: View {
    let destination: String
    let dates: [Date]
    
    @State private var selectedDate: Date? = nil
    @State private var showModal = false
    // 날짜별로 저장된 장소들을 관리
    @State private var savedPlaces: [Date: [Place]] = [:]
    
    var body: some View {
        VStack {
            // 상단 제목
            HStack {
                Text(destination)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            // 날짜 수평 스크롤 뷰
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(dates, id: \.self) { date in
                        Button(action: {
                            selectedDate = date
                        }) {
                            Text(formattedDate(date))
                                .padding()
                                .background(selectedDate == date ? Color.blue : Color.clear)
                                .foregroundColor(selectedDate == date ? .white : .black)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)

            // 선택된 날짜에 따른 장소 목록 표시
            if let date = selectedDate, let places = sortedPlaces(for: date) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(places.indices, id: \.self) { index in
                                PlaceRow(place: places[index])
                                    .id(index)
                                    .padding(.horizontal)
                            }
                            
                            // 플러스 버튼 (장소 목록 하단에 위치)
                            Button(action: {
                                showModal = true
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .id("PlusButton")
                            .padding()
                        }
                    }
                    .onChange(of: savedPlaces[date]?.count) { _ in
                        if let count = savedPlaces[date]?.count, count > 0 {
                            proxy.scrollTo("PlusButton", anchor: .bottom) // 마지막 항목으로 스크롤
                        }
                    }
                }
            } else {
                // 날짜가 선택되지 않았거나 장소가 없을 때
                VStack {
                    Text("날짜를 선택하고 장소를 추가하세요.")
                        .foregroundColor(.gray)
                        .padding()

                    // 플러스 버튼 (기본 위치)
                    Button(action: {
                        showModal = true
                    }) {
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

            Spacer()

            // 저장 버튼
            Button {
                print("여행 저장: \(savedPlaces)")
            } label: {
                Text("저장")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .sheet(isPresented: $showModal) {
            ModalView { newPlace in
                savePlace(for: selectedDate, place: newPlace)
                showModal = false
            }
            .presentationDetents([.fraction(0.6)])
        }
    }
    
    // 날짜별로 저장된 장소를 시간순으로 정렬하는 함수
    private func sortedPlaces(for date: Date) -> [Place]? {
        return savedPlaces[date]?.sorted { $0.startTime < $1.startTime }
    }
    
    // 장소를 저장하는 함수
    private func savePlace(for date: Date?, place: Place) {
        guard let date = date else { return }
        if savedPlaces[date] != nil {
            savedPlaces[date]?.append(place)
        } else {
            savedPlaces[date] = [place]
        }
    }
    
    // 날짜 포매팅 함수
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter.string(from: date)
    }
}

func formattedTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}


#Preview {
    ItineraryDetailView(
        destination: "도쿄",
        dates: [Date()]
    )
}
