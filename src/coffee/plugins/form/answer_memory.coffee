class @AnswerMemory extends AbstractFormsliderPlugin
  init: =>
    @on('question-answered', @memorize)
    @memoryByQuestionId = {}

  memorize: (event, questionId, answerId, value, index, multiple, set) =>
    if multiple
      unless @memoryByQuestionId[questionId]
        @memoryByQuestionId[questionId] = []

      if set
        @memoryByQuestionId[questionId].push
          id:    answerId
          value: value
      else
        i = 0
        for record in @memoryByQuestionId[questionId]
          if record.id == answerId
            delete @memoryByQuestionId[questionId][i]

          i++

    else
      @memoryByQuestionId[questionId] =
        id:    answerId
        value: value

    @trigger('answer-memory-updated',
      @memoryByQuestionId
    )
