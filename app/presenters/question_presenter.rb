class QuestionPresenter
  include Rails.application.routes.url_helpers

  def initialize(q)
    @question = q
  end

  def resource_path(question)
    if question
      question_path(question)
    else
      question_path(@question)
    end
  end

  def new_resource_path
    new_question_path
  end

  def collection_path
    questions_path
  end

  def edit_resource_path
    edit_question_path(@question)
  end

  def apply_scope(chain)
    chain.no_supports
  end

  def answers_path
    question_answers_path(@question)
  end
end
