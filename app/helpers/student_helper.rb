module StudentHelper
	def student_schedule_table_cell(schedule, semester_input = @student.semester)
		# Determine current semester season
	  semester = semester_input
    season   = semester % 2 == 0 ? 'F' : 'E'

    block = "#{season}#{schedule}"

    thecourse = nil

    # Find a match
    schs = []
    @student.courses_by_semester(semester).each do |course|
			#schs.add s.schedules.select { |s| s.block == block }
			if course.course_no == "01005"
				schedules = @student.field_of_study.math_schedules(semester)
			else
				schedules = course.schedules
			end
			schedules.each do |schedule|
				
				if schedule.block == block
					rowspan = ''
					if block == "#{season}5A" and schedules.include? Schedule.find_by_block("#{season}5B")
						rowspan = ' rowspan="2"' 
					elsif block == "#{season}5B" and schedules.include? Schedule.find_by_block("#{season}5A")
						return ''
					end 
					course_class = get_course_class(course)
					return "<td#{course_class}#{rowspan}><a href=\"#{course_path(course)}\">#{course.course_no} <strong>#{course.title}</strong></a></td>".html_safe
				end
			end
    end

  	"<td class=\"empty\">#{schedule}</td>".html_safe  
	end
	
	def student_schedule_week_course(semester_input = @student.semester)
		semester = semester_input
    block    = semester % 2 == 0 ? 'January' : 'June'

    thecourse = nil
	end
	
	def get_course_class(course)
		if not @student.field_of_study.nil?
			if course.is_basic_course(@student)
				return ' class="course basic"'
			elsif course.is_main_course(@student)
				return ' class="course main"'
			elsif course.is_project_course(@student)
				return ' class="course project"'
			end
		end
		' class="course"'
	end
end
