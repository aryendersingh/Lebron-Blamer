//
//  ContentView.swift
//  Root Cause
//
//  Created by Aryender Singh on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var problem: String = ""
    @State private var isAnalyzing: Bool = false
    @State private var showResult: Bool = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // App title
                Text("Root Cause Analyzer")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.blue)
                
                if !showResult {
                    VStack(spacing: 25) {
                        Text("What problem are you experiencing?")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        // Larger text field with more padding and height
                        TextField("Enter your problem here", text: $problem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 16))
                            .frame(height: 50)
                            .padding(.horizontal)
                            .disabled(isAnalyzing)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                            .padding(.horizontal)
                        
                        // Multi-line text entry option
                        if !problem.isEmpty {
                            TextEditor(text: $problem)
                                .frame(minHeight: 100, maxHeight: 120)
                                .padding(.horizontal, 12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                                .padding(.horizontal)
                                .disabled(isAnalyzing)
                        }
                        
                        if isAnalyzing {
                            VStack(spacing: 15) {
                                Text("Analyzing root cause...")
                                    .foregroundColor(.secondary)
                                    .font(.headline)
                                
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                    .scaleEffect(1.5)
                                    .padding()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.8))
                                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                            )
                            .padding()
                        } else {
                            Button(action: {
                                if !problem.isEmpty {
                                    hideKeyboard()
                                    startAnalysis()
                                }
                            }) {
                                Text("Find Root Cause")
                                    .font(.headline)
                                    .padding(.vertical, 15)
                                    .padding(.horizontal, 30)
                                    .background(
                                        problem.isEmpty ? Color.gray : Color.blue
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            }
                            .disabled(problem.isEmpty)
                            .padding(.top, 15)
                        }
                    }
                    .padding(.horizontal)
                } else {
                    // Enhanced result view
                    VStack(spacing: 35) {
                        Text("Analysis Complete")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.green)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        Text("The root cause of your problem is:")
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.red.opacity(0.1))
                                .frame(height: 70)
                                .shadow(color: Color.red.opacity(0.2), radius: 5, x: 0, y: 2)
                            
                            Text("LEBRON JAMES")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal, 40)
                        
                        Button(action: resetForm) {
                            Text("Analyze Another Problem")
                                .font(.headline)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 30)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                        .padding(.top, 20)
                    }
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.9))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal, 20)
                    .transition(.opacity)
                }
                
                Spacer()
            }
            .padding(.top, 40)
            .padding(.bottom, 20)
        }
        .animation(.easeInOut(duration: 0.3), value: isAnalyzing)
        .animation(.easeInOut(duration: 0.5), value: showResult)
    }
    
    private func startAnalysis() {
        isAnalyzing = true
        
        // Simulate analysis for 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isAnalyzing = false
            showResult = true
        }
    }
    
    private func resetForm() {
        problem = ""
        showResult = false
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
