import SwiftUI

protocol JobInputViewDelegate: AnyObject {
    func didFinished()
}

struct JobInputView: View {
    enum PriorityType: Int64, CaseIterable, Identifiable {
        case low
        case medium
        case high
        
        var id: Self { self }
        
        var label: String {
            switch self {
            case .low:
                return "Low"
            case .medium:
                return "Med"
            case .high:
                return "High"
            }
        }
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var job: Job
    
    private let person: Person
    private let dataManager = CoreDataManager.shared
    
    weak var delegate: JobInputViewDelegate?
    
    init(job: Job? =  nil) {
        self.job = job ?? dataManager.create(type: Job.self)
        
        self.person = dataManager.fetch(type: Person.self).first ?? dataManager.create(type: Person.self)
        self.person.nameValue = "default"
        self.person.dobValue = .now
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    let placeholderName = job.nameValue.isEmpty ? "Name" : job.nameValue
                    TextField(placeholderName, text: $job.nameValue)
                    
                    HStack {
                        Text("Date")
                            .font(.body)
                            .foregroundColor(.secondary)
                        DatePicker("", selection: $job.dateValue)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Priority")
                            .font(.body)
                            .foregroundColor(.secondary)
                        Picker("", selection: $job.priorityValue) {
                            ForEach(PriorityType.allCases) { priority in
                                Text(priority.label).tag(priority.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    let placeholderNote = job.noteValue.isEmpty ? "Note" : job.noteValue
                    TextField(placeholderNote, text: $job.noteValue, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                }
            }
            
            Button {
                job.owner = person
                
                dataManager.save()
                delegate?.didFinished()
                dismiss()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity, maxHeight: 30)
            }
            .disabled(job.nameValue.isEmpty)
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

struct JobInputViewPreview: PreviewProvider {
    static var previews: some View {
        JobInputView()
    }
}
