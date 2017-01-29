require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
puts "EventManager Initialized!"
=begin
contents = File.read "../event_attendees.csv"
puts contents
lines = File.readlines "../event_attendees.csv"
lines.each_with_index do |line, index|
  next if index == 0
  columns = line.split(',')
  name = columns[2]
  puts name
end
=end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0...5]
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letter(id, form_letter)  
  Dir.mkdir("../output") unless Dir.exists? "../output"
  filename = "../output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def validate_phone(number)
  valid = true
  number = number.to_s.gsub(/-|\(|\.|\)|\s/, '')
  if number.length < 10
    valid = false
  elsif number.length > 11
    valid = false
  elsif number.length == 11 && number[0] != "1"
    valid = false
  end
  return valid
end

contents = CSV.open "../event_attendees.csv", headers: true, header_converters: :symbol
template_letter = File.read "../form_letter.erb"
erb_template = ERB.new(template_letter)

reg_freq = Hash.new(0)
day_freq = Hash.new(0)
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone_no = row[:homephone]
  valid_no = validate_phone(phone_no)
  puts "#{name} #{phone_no} #{valid_no}"
  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)

  regdate = row[:regdate]
  date = DateTime::strptime(regdate, '%m/%d/%y %H:%M')
  reg_freq[date.hour.to_s.to_sym] += 1
  day = Date.new(date.year, date.month, date.day).wday.to_s.to_sym
  day_freq[day] += 1
end

p reg_freq
puts "Registration frequency by hour of the day"
(0..24).each do |hour|
  if hour < 10; print "0"; end
  print "#{hour}:00 "
  reg_freq[hour.to_s.to_sym].times { print "="}
  puts
end

weekday = {:"#{0}" => "Sunday",
           :"#{1}" => "Monday",
           :"#{2}" => "Tuesday",
           :"#{3}" => "Wednesday",
           :"#{4}" => "Thursday",
           :"#{5}" => "Friday",
           :"#{6}" => "Saturday"}
puts
puts "Registration frequency by day of the week"
weekday.each do |day, name|
  print "#{name.rjust(9)}: "
  day_freq[day].times { print "="}
  puts
end
