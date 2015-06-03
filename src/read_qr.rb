def read_qr()
	puts "Reading QR code.."
	image = MiniMagick::Image.open(@scanned_quiz.scan.path)
	orig_format = image.type.downcase
	width_c = image.width / 612.0
	heigth_c = image.height / 792.0
	image.crop "#{(150*width_c).round}x#{(100*heigth_c).round-1}+0+0"
	image.format "pgm"
	image.write "public/system/qrcodes/#{@scanned_quiz.id}.pgm"
	image = nil
	image = MiniMagick::Image.open(@scanned_quiz.scan.path)
	puts "Thresholding.."
	if orig_format == "jpeg"
		image.format "png"
		image.threshold "60%"
		image.write @scanned_quiz.scan.path
		puts "Image converted to png"
	elsif orig_format == "png"
		image.threshold "60%"
		image.write @scanned_quiz.scan.path
	end
end

