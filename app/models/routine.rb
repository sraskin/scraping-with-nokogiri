class Routine

  def self.chart
    number_of_class = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    number_of_period = [1, 2, 3, 4, 5, 6, 7]
    number_of_section = [1, 2]
    number_of_subjects = [1, 2, 3, 4, 5]
    bangla = ["b1", "b2", "b3", "b4", "b5"]
    b2 = bangla.reverse
    english = ["e1", "e2", "e3", "e4", "e5"]
    e2 = english.reverse
    math = ["m1", "m2", "m3", "m4", "m5"]
    m2 = math.reverse
    science = ["d1", "s2", "s3", "s4", "s5"]
    s2 = science.reverse
    others = ["o1", "o2", "o3", "o4", "o5"]
    o2 = others.reverse

    p_1 = []
    p_2 = []
    p_3 = []
    p_4 = []
    p_5 = []
    p_6 = []
    p_7 = []
    periods = []

# period 1
    (0..4).each do |i|
      p_1 << {"class_#{i+1}": bangla[i]}
    end
    (0..4).each do |i|
      p_1 << {"class_#{i+6}": b2[i]}
    end
# period 2
    (0..4).each do |i|
      p_2 << {"class_#{i+1}": english[i]}
    end
    (0..4).each do |i|
      p_2 << {"class_#{i+6}": e2[i]}
    end
# period 3
    (0..4).each do |i|
      p_3 << {"class_#{i+1}": math[i]}
    end
    (0..4).each do |i|
      p_3 << {"class_#{i+6}": m2[i]}
    end
# period 4
    (0..4).each do |i|
      p_4 << {"class_#{i+1}": science[i]}
    end
    (0..4).each do |i|
      p_4 << {"class_#{i+6}": s2[i]}
    end
# period 5
    (0..4).each do |i|
      p_5 << {"class_#{i+1}": others[i]}
    end
    (0..4).each do |i|
      p_5 << {"class_#{i+6}": o2[i]}
    end

    periods << {first_period: p_1, second_period: p_2, third_period: p_3, fourth_period: p_4, fifth_period: p_5}


    periods.each do |key, value|
      key.each do |key, value|
        puts value.to_s
      end

    end

    # (1..10).each do |i|
    #   (1..7).each do |j|
    #     puts "|------------------------------------|     |------------------------------------|"
    #     puts "|        Class #{i} Section A           |     |        Class #{i} Section B           |"
    #     puts "|------------------------------------|     |------------------------------------|"
    #     puts "| Class | Section | Period | Teacher | and | Class | Section | Period | Teacher |"
    #     puts "|-------|---------|--------|---------|     |-------|---------|--------|---------|"
    #     puts "    #{i}        A        #{j}         #{letter}1              #{i}        B        #{j}         B1    "
    #     puts "|------------------------------------|     |------------------------------------|"
    #     puts "\n\n"
    #   end
    # end
  end

end