//
//  SequenceView.swift
//  HomeWork
//
//  Created by Юлия Бегман on 18.04.2023.
//

import SwiftUI

struct SequenceView: View {
    
    @StateObject var sequenceViewModel: SequenceViewModel = .init()
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 15) {
                
                Text("Введите текст для анализа: ")
                    .font(.headline)
                
                TextEditor(text: $sequenceViewModel.text)
                    .autocorrectionDisabled(true)
                    .frame(maxHeight: 60)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.mint, lineWidth: 1)
                    }
                
                HStack {
                    Text("Сортировка: ")
                        .font(.headline)
                    
                    Picker("", selection: $sequenceViewModel.isSortByAsc) {
                        Text("ASC")
                            .tag(true)
                        
                        Text("DESC")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    .colorMultiply(.mint)
                    .onChange(of: sequenceViewModel.isSortByAsc) { newValue in
                        Task {
                            await sequenceViewModel.setSequence(sequenceViewModel.text, newValue)
                        }
                    }
                }
                
                Text("Поиск по суффиксам:")
                    .font(.headline)
                TextField("Введите текст", text: $sequenceViewModel.searchText)
                    .autocorrectionDisabled(true)
                    .frame(height: 30)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.mint, lineWidth: 1)
                    )
                
                Group {
                    Picker("", selection: $sequenceViewModel.isTop) {
                        Text("Все суффиксы")
                            .tag(false)
                        
                        Text("Топ суффиксов")
                            .tag(true)
                    }
                    .pickerStyle(.segmented)
                    .padding(.top, 20)
                    
                    if sequenceViewModel.isTop {
                        ScrollView {
                            ForEach(sequenceViewModel.topSuffixes, id: \.self) { suffix in
                                HStack {
                                    Text(suffix.value)
                                        .foregroundColor(suffix.isSearched ? .mint : .black)
                                    Spacer()
                                    Text("frequencyText \(suffix.frequency)")
                                }
                                .padding(.horizontal, 40)
                            }
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            ForEach(sequenceViewModel.sequence, id: \.word) { element in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(element.word)
                                            .font(.title)
                                        
                                        Spacer()
                                    }
                                    
                                    Divider()
                                    
                                    ForEach(element.suffixes, id: \.self) { suffix in
                                        HStack {
                                            Text(suffix.value)
                                                .foregroundColor(suffix.isSearched ? .mint : .black)
                                            Spacer()
                                            Text("frequencyText \(suffix.frequency)")
                                        }
                                        .padding(.horizontal, 40)
                                    }
                                    
                                    Divider()
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

