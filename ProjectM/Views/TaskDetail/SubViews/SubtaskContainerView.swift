//
//  SubtaskContainerView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct SubtaskContainerView: View {
    
    
    @Binding var newSubTaskTitle: String
    @Binding var showInputField: Bool
    var color: Color
    var subtasks: [UUID]
    var onSubmit: () -> Void
    
    init(newSubTaskTitle: Binding<String>, showInputField: Binding<Bool>, color: Color, subtasks: [UUID], _ onSubmit: @escaping () -> Void) {
        self._newSubTaskTitle = newSubTaskTitle
        self._showInputField = showInputField
        self.color = color
        self.subtasks = subtasks
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        HStack {
            Text("Sub task")
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
                
                TextField("New subtask", text: $newSubTaskTitle)
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
        
        ForEach(subtasks, id: \.self) { subtaskId in
            SubTaskCard(
                subtaskId: subtaskId
            )
        }
    }
}
