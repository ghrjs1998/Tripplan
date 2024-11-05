//
//  LoginView.swift
//  tripplan
//
//  Created by 박호건 on 10/25/24.
//

import SwiftUI

struct LoginView: View {
    // 소셜 로그인 버튼의 데이터
    let socialLogins = [
        ("navericon", "네이버로 로그인하기", Color.green, Color.white, false),
        ("kakaoicon", "카카오로 로그인하기", Color.yellow, Color.black, false),
        ("googleicon", "구글로 로그인하기", Color.white, Color.black, true)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Text("지금 로그인하고\nTripPlan을 시작해 보세요!")
                    .font(.system(size: 25))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

            // ForEach로 소셜 로그인 버튼 생성
            VStack(spacing: -20) {
                ForEach(socialLogins, id: \.0) { login in
                    SocialLoginButton(
                        image: login.0,
                        text: login.1,
                        backgroundColor: login.2,
                        textColor: login.3,
                        hasBorder: login.4
                    )
                    .padding(.vertical, 5) // 버튼 사이 간격 추가
                }
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

// 소셜 로그인 버튼을 위한 재사용 가능한 컴포넌트
struct SocialLoginButton: View {
    let image: String
    let text: String
    let backgroundColor: Color
    let textColor: Color
    var hasBorder: Bool = false

    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Capsule()
                    .frame(width: 350, height: 60)
                    .foregroundColor(backgroundColor)
                    .overlay(
                        Capsule()
                            .stroke(Color.gray, lineWidth: hasBorder ? 1 : 0)
                    )
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()

                    Spacer()

                    Text(text)
                        .foregroundColor(textColor)
                        .padding()

                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
