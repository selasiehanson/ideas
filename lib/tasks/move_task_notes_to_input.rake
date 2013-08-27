namespace :move_task_notes_to_input do
  desc "TODO"
  task :run => :environment do
		notes = Note.all  	
		
		notes.each do	|note|
			if note.task
				# build a new input based on task
				t = note.task
				n = Input.new
				n.content = t.content
				n.status = t.status
				n.project_id =  t.project_id
				n.type = "Task"
				n.save
			else	
				# build a new input based on note
				n =  Input.new
				n.content = note.content
				n.project_id = note.project_id
				n.status = :note
				n.type = "Note"
				n.save
			end 
		end
  end
end
