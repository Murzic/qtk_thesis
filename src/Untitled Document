def perform(scanned_quiz)
  @scanned_quiz = scanned_quiz
  @answers = Array.new
  qr = read_qr()
  if qr.at(0).is_a? ZBar::Symbol
    copy_id = qr.at(0).data.gsub(/\+\d*/, '')
    @page_nr = qr.at(0).data.gsub(/\d+\+/, '')
    @copy = Copy.find(copy_id)
    @copy_answers = @copy.answers
    @coordinates = @copy.squares_xy
  else
    raise "QR code wasn't decoded!"
  end

  answers_processing()
  if @answers
    puts "Saving checked answers"
    if @copy_answers
      @copy.answers = @copy_answers | @answers
    else
      @copy.answers = @answers
    end
    @copy.save
  end
end
