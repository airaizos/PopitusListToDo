import SwiftUI

struct TaskItemRow: View {
    
    //Propierties
    @Environment(TaskViewModel.self) var taskViewModel: TaskViewModel

    @State var task: TaskItem
    
    var body: some View {

        VStack {
            HStack {
                Text(task.title)
                    .strikethrough(task.completed)
                    .foregroundColor(task.completed ? .gray : .primary)
                    .font(.title3)
                
                Spacer()
                
                StatusIndicator(status: task.status)
            }
            
            HStack {
                Text(task.lastUpdate.format())
                    .strikethrough(task.completed)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Spacer()
            }
            HStack {
                if taskViewModel.tags.filter({$0.taskItem?.id == task.id}) != [] {
                    Image(systemName: "tag.circle")
                        .padding(.vertical, 4)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(taskViewModel.tags.filter{$0.taskItem?.id == task.id}) { tag in
                                TagsListView(tag: tag.title)
                            }
                        }
                    }
                    Spacer()
                }
                if !task.note.isEmpty {
                    Spacer()
                    Image(systemName: "text.bubble")
                        .padding(.vertical, 4)
                }
                
            }
            
        }
    }
}

#Preview {
    @State var taskViewModel = TaskViewModel()
    return TaskItemRow(
        task: TaskItem(title: "Test", date: Date(), status: .pending, note: "Prueba de nota", lastUpdate: Date()))
    .environment(taskViewModel)
}
