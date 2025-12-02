//
//  VideoPlayerView.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import SwiftUI

struct VideoPlayerView: View {
    let url: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("▶️")
                        .font(.system(size: 100))
                    
                    Text("Video Player")
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Text(url)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
            }
        }
    }
}
