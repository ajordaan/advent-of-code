
require_relative 'directory'
require_relative 'system_file'

def command?(str)
  str[0] == '$'
end

def listing_file?(str)
  !command? str
end

TOTAL_DISK_SPACE          = 70000000
SPACE_REQUIRED_FOR_UPDATE = 30000000
  
curr_directory = nil
listing_files_in_progress = false

existing_directories = []

File.foreach('input.txt') do |l|
  line = l.split ' '

  if command? line
    case line[1]
    when 'cd'
      destination = line[2] == '..' ? curr_directory.parent : line[2]
      destination_path =
      if destination.is_a? Directory
        destination.path
      else
        curr_directory.nil? ? '/' : "#{curr_directory&.path}->#{destination}"
      end
      existing_directory = existing_directories.find { |dir| dir.path == destination_path }
      if existing_directory.nil?
        new_directory = Directory.new name: destination, parent: curr_directory
        curr_directory = new_directory
        existing_directories << new_directory
      else
        curr_directory = existing_directory
      end

    when 'ls'
      next
    end
  end

  if listing_file? line
    line_is_directory = line[0] == 'dir'

    if line_is_directory
      dir_name = line[1]
      destination_path = curr_directory.nil? ? '/' : "#{curr_directory.path}->#{dir_name}"

      existing_directory = existing_directories.find { |dir| dir.path == destination_path }

      if existing_directory.nil?
        new_directory = Directory.new name: dir_name, parent: curr_directory
        curr_directory.add_child new_directory
        existing_directories << new_directory
      else
        curr_directory.add_child existing_directory
      end
    else
      curr_directory.add_child SystemFile.new name: line[1], size: line[0]
    end
  end

end

p "Part 1:"
p existing_directories.filter {|directory| directory.total_size <= 100000 }.sum {|dir| dir.total_size }

root_dir = existing_directories.find { |dir| dir.name == '/' }

USED_SPACE = root_dir.total_size
FREE_SPACE = TOTAL_DISK_SPACE - USED_SPACE
SPACE_NEEDED = SPACE_REQUIRED_FOR_UPDATE - FREE_SPACE

p "Part 2:"
p existing_directories.filter { |dir| dir.total_size >= SPACE_NEEDED }.sort_by(&:total_size).first.name
