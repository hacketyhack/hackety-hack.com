class QuestionsController < InheritedController

  def index
    @question = Question.new
  end

  def create
    create!(:notice => "Question Asked!"){collection_url}
  end
end
