class QuestionsController < InheritedController
  load_and_authorize_resource

  def create
    @question = Question.create params[:question]
    @question.user = current_user
    create!(:notice => "Question Asked!"){ collection_url }
  end
end
