def set_header(copy)
  if copy.student_group_id
    student_group = StudentGroup.find(copy.student_group_id)
    student = Student.find(copy.student_id)
    text "#{student.name} #{student.surname}", align: :right, size: 12
    text "#{student_group.name}", align: :right, size: 12
  else
    move_down 24
  end
  stroke do
    circle [-10, 730], 10
    line [-10, 735], [-10,725]
    line [-15, 730], [-5, 730]
    circle [-10, -10], 10
    circle [550, -10], 10
    circle [550, 730], 10
  end
  Strokes::Barcode.new(:qrcode, "#{copy.id}+#{@page}").save("#{Rails.root}/app/pdfs/qrcodes/#{copy.id}-#{@page}.png", width: 60)
  image "app/pdfs/qrcodes/#{copy.id}-#{@page}.png", at: [10, 735]
  text "#{@quiz.name}", align: :center, size: 16
  move_down 20
  draw_text! "#{@page}", at: [550, 5]
  @page += 1
end
