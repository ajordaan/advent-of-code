def part_one
  p1_total = 0
  p2_total = 0
  File.foreach('input.txt') do |line|
    sections = line.split ','
    
    a = parse_section_start_end(sections.first)
    b = parse_section_start_end(sections.last)

    if sections_fully_overlap?(a, b) || sections_fully_overlap?(b, a)
      p1_total += 1
    end

    if sections_partially_overlap?(a, b) || sections_partially_overlap?(b, a)
      p2_total += 1
    end
  end
  puts "============== PART ONE ============="
  puts "Overlaps:"
  puts p1_total
  puts "============== PART TWO ============="
  puts "Overlaps:"
  puts p2_total
end
  
def parse_section_start_end(section)
    section_start_end = section.split '-'
    section_start = section_start_end.first
    section_end = section_start_end.last

    [section_start.to_i, section_end.to_i]
end

def sections_fully_overlap?(a,b)
  a.first <= b.first && a.last >= b.last
end

def sections_partially_overlap?(a,b)
  return false if a.last < b.first || a.first > b.last

  a.first <= b.first || a.last >= b.last
end

part_one
