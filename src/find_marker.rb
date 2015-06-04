def find_marker(pixels, x_range, y_range)
  marker = Hash["x" => Array.new, "y" => Array.new]
  black = false 
  x_range.each do |x|
    y_range.each do |y|
      if ChunkyPNG::Color.to_hex(pixels[x, y], false)[1,6] == "000000"
        marker["x"] << x
        marker["y"] << y
        if black == false
          black = true
        end
      end
    end
    if black == true
      unless marker["x"].include? x
        break
      end
    end
  end
  marker
end
