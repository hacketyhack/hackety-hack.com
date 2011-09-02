class QuestionsController < InheritedController

  def index
    @question = Question.new
    index!
  end

  def create
    create!(:notice => "Question Asked!"){collection_url}
  end
end
