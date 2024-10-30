//
//  ItineraryView.swift
//  tripplan
//
//  Created by 박호건 on 10/29/24.
//

import SwiftUI

struct ItineraryView: View {
    let destination: String  // 선택된 여행지
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var viewModel = ItineraryViewModel()  // ViewModel 인스턴스 생성
    @State private var shouldNavigate = false  // 화면 이동을 위한 플래그

    var body: some View {
        NavigationStack {
            VStack {
                // 상단 뒤로가기 버튼
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
                .padding(.horizontal)
                .padding(.top, 10)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(destination) 일정에 대해\n알려주세요!")
                            .font(.system(size: 24))
                            .padding(.top, 20)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("여행 이름").fontWeight(.semibold)
                            ZStack(alignment: .leading) {
                                if viewModel.travelName.isEmpty {
                                    Text("여행 이름을 입력해주세요.")
                                        .foregroundColor(.gray)
                                        .padding(10)
                                }
                                TextField("", text: $viewModel.travelName)
                                    .padding(10)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("여행일").fontWeight(.semibold)
                            VStack(spacing: 20) {
                                TextField("여행 기간을 입력해주세요", text: $viewModel.travelPeriod)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .disabled(true)

                                CustomCalendarView(
                                    checkInDate: $viewModel.checkInDate,
                                    checkOutDate: $viewModel.checkOutDate,
                                    onDatesSelected: viewModel.updateTravelPeriod
                                )
                                .frame(height: 400)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            }
                        }
                    }
                    .padding()
                }

                Button {
                    viewModel.savePlan(destination: destination)
                    if viewModel.isSaveSuccessful {
                        shouldNavigate = true
                    }
                } label: {
                    Text("다음")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                }

                NavigationLink(
                    destination: ItineraryDetailView(
                        destination: viewModel.travelName,
                        dates: viewModel.generateDateList()
                    ),
                    isActive: $shouldNavigate
                ) {
                    EmptyView()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ItineraryView(destination: "일본")
}
