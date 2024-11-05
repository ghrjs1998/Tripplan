//
//  HomeViewModel.swift
//  tripplan
//
//  Created by 박호건 on 10/31/24.
//

import Foundation

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var itineraries: [String] = []
    @Published var userName: String = "티디아이"
}
