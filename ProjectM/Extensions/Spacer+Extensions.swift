//
//  Spacer+Extensions.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

extension Spacer {
    func height(_ height: CGFloat) -> some View {
        self.frame(height: height)
    }
}
