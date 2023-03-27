//
//  TaskDetailView.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import SwiftUI

struct subtask: Hashable {
var name: String
var note: String
var state: TaskState
    
    init(name: String, note: String, state: TaskState) {
        self.name = name
        self.note = note
        self.state = state
    }
}

struct TaskDetailView: View {
    
    //let task: Task
    
    @Environment(\.dismiss) private var dismiss
    
    @State var showFullDescription = false
    
    let name = "Show pending transactions"
    let estimation = 4.5
    let deadline = Date()
    
    let desciption = "Creating a landing page is an important task that involves designing and developing a webpage with the specific goal of converting visitors into leads or customers. The landing page should be visually appealing, user-friendly, and optimized for search engines to drive traffic to the website. To create a landing page, you will need to start by defining the objective and audience of the page. This will involve researching the target market, identifying their pain points and needs, and creating a value proposition that addresses these issues. Once you have a clear understanding of the target audience and objectives, you can begin designing the layout and content of the landing page. This will involve creating a headline that grabs the visitor's attention, crafting persuasive copy that highlights the benefits of your product or service, and adding compelling images or videos that reinforce your message."
    
    let subtasks = [
        subtask(name: "Clean the floor", note: "This has to be done", state: TaskState.ToDo),
        subtask(name: "This is a very long name for a subtask", note: "The description can be even longer so we can see how the User experience is and if we can optimize it", state: TaskState.Completed)
    ]
    
    
    
    var body: some View {
        VStack {
            
            VStack (alignment: .leading) {
                
                Text(name)
                    .foregroundColor(Color.taskcardText)
                    .font(name.count > 25 ? .title : .largeTitle)
                    .fontWeight(.bold)
                    
                    .truncationMode(.tail)
                    .padding([.top, .bottom])
                
                
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "alarm")
                            Text(String(estimation) + " hours")
                        }
                        
                        
                        HStack {
                            Image(systemName: "calendar")
                            Text(deadline.formatAsDate())
                        }
                    }
                    .foregroundColor(Color.taskcardText.opacity(0.75))
                    .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            print("TIMETRACKING")
                        }
                        
                    } label: {
                        Image(systemName: "play.circle.fill")
                        
                    }
                    .font(.largeTitle)
                    .foregroundColor(Color.background)
                    
                }
                
            }
            .padding([.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.text)
                        .padding(.bottom, 5)
                        .padding(.top)
                    
                    VStack {
                        Text(desciption)
                            .lineLimit(showFullDescription ? .max : 4)
                            .truncationMode(.tail)
                            .foregroundColor(Color.text)
                        
                        Button {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                            
                        } label: {
                            HStack {
                                Text("See full description")
                                Image(systemName: showFullDescription ? "chevron.up" : "chevron.down")
                            }
                            
                        }
                        .padding(.top, 2)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(ProjectColors.green.toColor())
                        
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Sub task")
                            .foregroundColor(Color.text)
                        
                        Spacer()
                        
                        
                        Button {
                            withAnimation {
                                showFullDescription.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "plus.square.fill")
                                .foregroundColor(ProjectColors.green.toColor())
                        }
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    
                    ScrollView {
                        VStack{
                            ForEach(subtasks, id: \.self) { subtask in
                                SubTaskCard(_subtask: subtask)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding()
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.7, alignment: .bottom)
            .background(Color.background)
            .roundedCorner(30, corners: [.topLeft, .topRight])
            
        }
        .background(ProjectColors.green.toColor())
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .font(.title2)
                .foregroundColor(Color.background)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("EDIT")
                    
                } label: {
                    Image(systemName: "pencil.circle.fill")
                    
                }
                .font(.title2)
                .foregroundColor(Color.background)
            }
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TaskDetailView()
        }
    }
}
