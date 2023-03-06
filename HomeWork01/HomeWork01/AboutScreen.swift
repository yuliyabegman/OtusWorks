//
//  AboutScreen.swift
//  Homework001
//
//  Created by Юлия Бегман on 06.03.2023.
//

import SwiftUI

struct AboutScreen: View {
    
    @Binding var selectedTab: Int
    
    @State var isShowContacts: Bool = false
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .center) {
                    Spacer()
                    Text("Позвоните нам по бесплатному телефону 8 (800) 301-30-80 или напишите на shop@krasniykarandash.ru\nПо вопросам возврата товара — на почту vopros@krasniykarandash.ru,\nтрудоустройство — hr@krasniykarandash.ru.")
                        .multilineTextAlignment(.center)
                    Spacer()
            }
            .sheet(isPresented: $isShowContacts) {
                VStack {
                    Text("Наши контакты")
                        .font(.largeTitle)
                        .padding()
                    
                    Text("Мы всегда рады ответить на ваши вопросы и предложения!\nПозвоните нам или напишите электронное письмо, и мы вам поможем.")
                        .font(.subheadline)
                        .padding()
                    
                    Text("Режим работы:\nпн-вс: c 09.00 до 21.00\nТелефон:\n8 (800) 301-30-80")
                        .font(.subheadline)
                        .padding()
                    
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        isShowContacts = true
                    } label: {
                        Image(systemName: "phone.circle")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 50, height: 50)
                            .padding(20)
                    }
                    
                }
            }
        }
        .onAppear() {
            selectedTab = 2
        }
        
    }
    
}
