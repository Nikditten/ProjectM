//
//  SubtaskContainerView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct TaskContainerView: View {
    
    
    @Binding var newTaskTitle: String
    @Binding var showInputField: Bool
    var color: Color
    var tasks: [UUID]
    var onSubmit: () -> Void
    
    init(newTaskTitle: Binding<String>, showInputField: Binding<Bool>, color: Color, tasks: [UUID], _ onSubmit: @escaping () -> Void) {
        self._newTaskTitle = newTaskTitle
        self._showInputField = showInputField
        self.color = color
        self.tasks = tasks
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        HStack {
            Text("Tasks")
                .foregroundColor(Color.text)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                withAnimation {
                    showInputField.toggle()
                }
            } label: {
                Image(systemName: showInputField ?  "xmark.circle": "plus.circle")
                    .foregroundColor(color)
            }
        }
        .font(.title2)
        
        Spacer().height(20)
        
        if (showInputField) {
            HStack {
                Image(systemName: "circle")
                    .foregroundColor(color)
                    .accessibility(label: Text("Unchecked"))
                    .imageScale(.large)
                    .font(.headline)
                
                TextField("New task", text: $newTaskTitle)
                    .keyboardType(.default)
                    .cornerRadius(10)
                    .foregroundColor(Color.subTaskCardText)
                    .submitLabel(.done)
                    .onSubmit {
                        onSubmit()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.subTaskCardBackground)
            .cornerRadius(10)
        }
        
        ForEach(tasks, id: \.self) { taskId in
            TaskCardView(
                taskId: taskId
            )
        }
    }
}
