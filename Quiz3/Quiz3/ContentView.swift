//
//  ContentView.swift
//  Quiz3
//
//  Created by Varun Sidhu on 2022-03-10.
//

import SwiftUI

struct Child:Identifiable{
    var id: Int
    var name: String
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}

class ChildModel: ObservableObject{
    @Published var child: [Child]
    
    init(){
        self.child = [
            Child(id: 1, name: "Jack"),
            Child(id: 2, name: "Adam"),
            Child(id: 3, name: "Michael"),
        ]
    }
}

struct ContentView: View {
    
    @State private var Name = [String]()
    @State private var newChild = ""
    @State private var errorMsg: String?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        ZStack {
            Color.gray
                    .ignoresSafeArea()
            VStack{
                Text("Child Names")
                    .fontWeight(.bold)
                    .font(.system(size: 35))
                    
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(Name, id: \.self){ name in
                            
                            Rectangle()
                                .foregroundColor(.pink)
                                .frame(width: 50,height: 50)
                                .cornerRadius(5)
                                .overlay(
                                    Text(name)
                                        .foregroundColor(.white)
                                )
                                .padding(.vertical, 10)
                            
                        }
                    }
                    .padding(.horizontal, 10.0)
                }
                
                VStack{
                    Text(errorMsg ?? "")
                        .foregroundColor(.red)
                    HStack{
                        Spacer()
                            .frame(width: 30)
                        TextField("Enter Name", text: $newChild)
                            

                        Button("Submit"){
                            addNewChild()
                        }
                        .padding(.all, 10)
                        .background(.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                       
                        Spacer()
                            .frame(width: 60)
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
            }
            
        }
    }
    
    func addNewChild() {
        let addNewName = newChild.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if newChild.isEmpty {
            errorMsg = "Name can't be empty."
        }
        else {
            Name.append(addNewName)
            newChild = ""
            errorMsg = ""
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
