rads = rotation_detection(tl_coord, bl_coord)
prev_y = 0
current_page = 1
@coordinates.each do |qid, ahash|
  ahash.each do |aid, carray|
    square_pixels = Array.new
    current_page += 1 if carray[1] < prev_y
    if current_page == @page_nr.to_i
      ((carray[1]*dpi_ratio).round..((carray[1]+9)*dpi_ratio).round).each do |y|
        (((carray[0])*dpi_ratio).round..((carray[0]+9)*dpi_ratio).round).each do |x|
          corrected_x = x * Math.cos(-rads) - y * Math.sin(-rads)
          corrected_y = y * Math.cos(-rads) + x * Math.sin(-rads)
          square_pixels << ChunkyPNG::Color.to_hex(png[corrected_x.round + tl_coord[0], corrected_y.round + tl_coord[1]], false)
        end
      end
    end
    white_pixels = square_pixels.count "#ffffff"
    black_pixels = square_pixels.count "#000000"
    bw_ratio = black_pixels.fdiv(white_pixels)

    ## Add the checked answered to array
    if bw_ratio > 1
      @answers << aid
    end
	end
end

