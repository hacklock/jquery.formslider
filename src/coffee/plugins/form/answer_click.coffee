class @AnswerClick extends AbstractFormsliderPlugin
  init: =>
    @container.on('mouseup', @config.answerSelector, @onAnswerClicked)

  onAnswerClicked: (event) =>
    event.preventDefault()

    $answer = $(event.currentTarget)
    $slide  = $(@slideByIndex())

    if $slide.hasClass('multiple-answers')
      $answer.toggleClass(@config.answerSelectedClass)

    else
      $answerRow       = $answer.closest(@config.answersSelector)
      $allAnswersinRow = $(@config.answerSelector, $answerRow)
      $allAnswersinRow.removeClass(@config.answerSelectedClass)
      $answer.addClass(@config.answerSelectedClass)

    $questionInput = $(@config.questionSelector, $slide)
    $answerInput   = $('input', $answer)

    @trigger('question-answered',
      $questionInput.prop('id'),
      $answerInput.prop('id'),
      $answerInput.val(),
      @index(),
      $slide.hasClass('multiple-answers'),
      $answer.hasClass(@config.answerSelectedClass)
    )
