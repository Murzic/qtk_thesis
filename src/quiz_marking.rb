def quiz_marking
  copy_answers = @copy.answers
  questions = Question.where(id: @copy.questions).includes(:answers)
  points = 0
  total = 0
  questions.each do |q|
    correct_answers = Array.new
    incorrect_answers = Array.new
    q.answers.each do |a|
      if a.correct
        correct_answers << a.id
      else
        incorrect_answers << a.id
      end
    end
    correctly_ans = correct_answers & copy_answers
    incorrectly_ans = incorrect_answers & copy_answers
    answered = correctly_ans | incorrectly_ans
    total += correct_answers.length
    unless answered.length > correct_answers.length
      points += correctly_ans.length
    end
  end
  mark = points.fdiv(total)*100
  ## Updating mark field in copies table
  @copy.mark = mark
  @copy.save
  mark
end
