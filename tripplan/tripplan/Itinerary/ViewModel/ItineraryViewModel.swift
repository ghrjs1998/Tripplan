//
//  ItineraryViewModel.swift
//  tripplan
//
//  Created by 박호건 on 10/30/24.
//

import Foundation
import OSLog

class ItineraryViewModel: ObservableObject {
    @Published var travelName: String = ""
    @Published var travelPeriod: String = ""
    @Published var checkInDate: Date? = nil
    @Published var checkOutDate: Date? = nil
    @Published var isSaveSuccessful: Bool = false
    @Published var errorMessage: String?  // 에러 메시지 저장

    private let logger = Logger(subsystem: "com.tripplan", category: "Itinerary")

    // 여행 기간 업데이트 함수
    func updateTravelPeriod(checkIn: Date?, checkOut: Date?) {
        if let checkIn = checkIn, let checkOut = checkOut {
            travelPeriod = "\(formattedDate(checkIn)) ~ \(formattedDate(checkOut))"
        } else if let checkIn = checkIn {
            travelPeriod = "\(formattedDate(checkIn))"
        } else {
            travelPeriod = ""
        }
    }

    // API를 통한 여행 계획 저장 로직
    func savePlan(destination: String) {
        guard !travelName.isEmpty else {
            logger.error("저장 실패: 여행 이름이 비어 있습니다.")
            self.errorMessage = "여행 이름을 입력해 주세요."
            return
        }

        guard let checkIn = checkInDate, let checkOut = checkOutDate else {
            logger.error("저장 실패: 날짜가 올바르지 않습니다.")
            self.errorMessage = "여행 기간을 선택해 주세요."
            return
        }

        let plan = Plan(
            planTitle: travelName,
            startDate: formattedDate(checkIn),
            endDate: formattedDate(checkOut),
            city: destination
        )

        guard let url = URL(string: "https://yourapi.com/plans") else {
            logger.error("유효하지 않은 URL")
            self.errorMessage = "유효하지 않은 요청입니다."
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(plan)
        } catch {
            logger.error("JSON 변환 오류: \(error.localizedDescription)")
            self.errorMessage = "데이터 변환에 실패했습니다."
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.logger.error("네트워크 요청 실패: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.errorMessage = "네트워크 오류가 발생했습니다."
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                self.logger.error("잘못된 응답")
                DispatchQueue.main.async {
                    self.errorMessage = "서버 응답이 올바르지 않습니다."
                }
                return
            }

            DispatchQueue.main.async {
                switch httpResponse.statusCode {
                case 200:
                    self.logger.log("여행 계획 저장 성공")
                    self.isSaveSuccessful = true
                case 400:
                    self.logger.error("잘못된 요청 (400)")
                    self.errorMessage = "잘못된 요청입니다."
                case 403:
                    self.logger.error("권한 없음 (403)")
                    self.errorMessage = "권한이 없습니다."
                case 500:
                    self.logger.error("서버 오류 (500)")
                    self.errorMessage = "서버에 문제가 발생했습니다."
                default:
                    self.logger.error("알 수 없는 오류: \(httpResponse.statusCode)")
                    self.errorMessage = "알 수 없는 오류가 발생했습니다."
                }
            }
        }
        task.resume()
    }

    // 날짜 리스트 생성
    func generateDateList() -> [Date] {
        guard let checkIn = checkInDate, let checkOut = checkOutDate else { return [] }
        var dates: [Date] = []
        var currentDate = checkIn

        while currentDate <= checkOut {
            dates.append(currentDate)
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }

    // 날짜 포매팅 함수
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
