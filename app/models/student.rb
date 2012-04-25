# == Schema Information
#
# Table name: students
#
#  id             :integer         not null, primary key
#  student_number :string(255)
#  direction_id   :integer
#  start_year     :integer
#  cn_access_key  :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

class Student < ActiveRecord::Base
  belongs_to :field_of_study
  has_many :course_students
  has_many :courses, :through => :course_students
  
  attr_accessor :password
  
  attr_accessible :student_number, :password
  
  validates :student_number, :presence => true, :uniqueness => true
  
  after_create :update_courses
	before_create :authenticate
  
  def authenticate(pass = password)
    require "net/http"
    require "uri"

    uri = URI.parse("https://auth.dtu.dk/dtu/mobilapp.jsp")

    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"username" => self.student_number, "password" => pass})
    response = http.request(request)
    
    if response.body =~ /LimitedAccess Password/ && key = /Password=\"([^\"]*)\"/.match(response.body)
      self.update_attribute(:cn_access_key, key[1] )
    else
      false
    end
  end
  
  def get_info
    student_info = CambusNet.api_call(self, "UserInfo")
    raise student_info.to_yaml
    
  end
  
  def old_courses
    cn_courses = CambusNet.api_call(self, "Grades")['EducationProgrammes']['EducationProgramme']['ExamResults']['ExamResult']
    
    cn_courses.each do |course|
      course_number = course['CourseCode']
      course = Course.find_by_course_number(course_number)
      course_students.find_or_create_by_course_id(:course_id => course.id, :semester => semester(course['Year'], course['Period'] == "Winter" ? 1 : 0 )) unless course.nil?
    end
    self.save
  end
  
  def current_courses
    cn_courses = CambusNet.api_call(self, "Elements")['ElementGroupings']['Grouping'][0]['Element'].select! {|c| c['UserElementRelation']['ACL'] == 'User' && c['IsArchived'] == 'false'}
    
    cn_courses.each do |course|
      course_number = course['Name'].match('(\d{5})')[0]
      course = Course.find_by_course_number(course_number)
      course_students.find_or_create_by_course_id(:course_id => course.id, :semester => semester) unless course.nil?
    end
    self.save
  end
  
  def update_courses
    old_courses
    current_courses
  end
  
  def semester(year = Time.now.year, semester = Time.now.month === 2...7 ? 1 : 0)
    semester = semester > 1 ? 1 : semester
    (year.to_i - start_year) * 2 + semester
  end
  
  def start_year
    short_year = student_number.match('^s(\d{2})')[1].to_i
    if short_year + 2000 <= Time.now.year + 1
      short_year + 2000
    else
      short_year + 1900
    end
  end
  
  class << self
    ## GLOBALIZE MISSING FUNCTION. HOPELY THERE WILL BE A FIX SOON!
    def find_or_create_by_student_number(nr)
      find_by_student_number(nr) || create(:student_number => nr)
    end
    
  end
    
end
