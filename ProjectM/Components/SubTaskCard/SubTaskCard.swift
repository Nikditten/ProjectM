//
//  SubTaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 27/03/2023.
//

import SwiftUI

struct SubTaskCard: View {
    
    let _subtask: subtask
    
    @State var completed = false
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    completed.toggle()
                }
            } label: {
                Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(completed ? Color.white : Color.white)
                    .accessibility(label: Text(completed ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
            .font(.footnote)
            .frame(alignment: .leading)
            .buttonStyle(PlainButtonStyle())
            
            Text(_subtask.name)
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(ProjectColors.green.toColor())
        .cornerRadius(10)
      }
  }

struct SubTaskCard_Previews: PreviewProvider {
    static var previews: some View {
        SubTaskCard(
            _subtask: subtask(name: "This is a test", note: "This is a test description", state: TaskState.ToDo)
        )
    }
}
