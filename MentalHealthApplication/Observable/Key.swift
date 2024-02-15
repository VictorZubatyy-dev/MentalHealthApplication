//
//  Key.swift
//  MentalHealthApplication
//
//  Created by Victor on 15/02/2024.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var user: UserDetails {
        get { self[UserKey.self] }
        set { self[UserKey.self] = newValue }
    }
}

private struct UserKey: EnvironmentKey {
    static var defaultValue: UserDetails = UserDetails()
}
