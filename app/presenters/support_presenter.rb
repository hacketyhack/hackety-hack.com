class SupportPresenter
  include Rails.application.routes.url_helpers

  def initialize(sq)
    @support_question = sq
  end

  def page_title
    "Support Questions"
  end

  def new_resource_path
    new_support_question_path
  end

  def collection_path
    support_questions_path
  end

  def edit_resource_path
    edit_support_question_path
  end

  def resource_path(question)
    if question
      support_question_path(question)
    else
      support_question_path(@question)
    end
  end

  def apply_scope(chain)
    chain.supports
  end
end
