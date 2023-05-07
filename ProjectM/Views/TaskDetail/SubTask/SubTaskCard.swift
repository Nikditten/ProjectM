//
//  SubTaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 27/03/2023.
//

import SwiftUI

struct SubTaskCard: View {
    
    @ObservedObject var vm: SubTaskViewModel
    
    init(subtaskId: UUID, dataSource: DataSource = DataSource.shared) {
        self.vm = SubTaskViewModel(subTaskId: subtaskId, dataSource: dataSource)
    }
    
    @State var showMore = false
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    withAnimation {
                        vm.toggleState()
                    }
                } label: {
                    Image(systemName: vm.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(vm.color.toColor())
                        .accessibility(label: Text(vm.completed ? "Checked" : "Unchecked"))
                        .imageScale(.large)
                }
                .font(.headline)
                .frame(alignment: .topLeading)
                .buttonStyle(PlainButtonStyle())
                
                Text(vm.subTask.title)
                    .foregroundColor(Color.subTaskCardText)
                    .minimumScaleFactor(0.2)
                    .truncationMode(.tail)
            }
   
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.subTaskCardBackground)
        .cornerRadius(10)
      }
  }

