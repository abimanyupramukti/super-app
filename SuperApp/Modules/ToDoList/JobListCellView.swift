//
//  JobListCellView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 18/08/23.
//

import SwiftUI

struct JobListCellView: View {
    
    @ObservedObject private var job: Job
    private let dataManager = CoreDataManager.shared
    
    init(job: Job) {
        self.job = job
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: job.isDoneValue ? "circle.fill" : "circle")
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 2) {
                    Text(job.nameValue)
                        .font(.body)
                    Text(job.dateValue.formatted())
                        .font(.caption2)
                }
                
                if !job.noteValue.isEmpty {
                    Text(job.noteValue)
                        .font(.caption)
                }
            }
            
            Spacer()
            
            Image(systemName: "exclamationmark.square.fill")
                .foregroundColor(getWarningColor())
        }
    }
    
    private func getWarningColor() -> Color? {
        let priority = JobInputView.PriorityType(rawValue: job.priorityValue)
        switch  priority {
        case .low:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .red
        case .none:
            return nil
        }
    }
}
