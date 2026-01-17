////
////  SuggestionScrollView.swift
////  brink
////
////  Created by Aria Han on 12/4/24.
////
//
//import SwiftUI
//
//struct SuggestionScrollView: View {
//    @ObservedObject var messageService: MessageService
//    @Binding var text: String
//    @Environment(\.themeColors) private var themeColors
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 12) {
//                ForEach(Array(messageService.suggestedQuestions.enumerated()), id: \.offset) { _, suggestion in
//                    suggestionButton(for: suggestion)
//                }
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 10)
//        }
//        .background(themeColors.secondary.opacity(0.5))
//    }
//
//    private func suggestionButton(for suggestion: String) -> some View {
//        Button(action: {
//            text = suggestion
//        }) {
//            Text(suggestion)
//                .font(.system(size: 14, weight: .medium))
//                .foregroundColor(themeColors.text)
//                .padding(.horizontal, 16)
//                .padding(.vertical, 8)
//                .background(
//                    Capsule()
//                        .fill(themeColors.cardBackground)
//                        .overlay(
//                            Capsule()
//                                .strokeBorder(themeColors.tertiary.opacity(0.5), lineWidth: 1)
//                        )
//                )
//        }
//        .accessibilityLabel(suggestion)
//    }
//}
