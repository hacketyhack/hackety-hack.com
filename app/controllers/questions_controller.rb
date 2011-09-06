class QuestionsController < InheritedController
  load_and_authorize_resource

  def create
    @question = Question.create params[:question]
    @question.user = current_user
    create!(:notice => "Question Asked!"){ collection_url }
  end
  
  def show
    @answer = Answer.new
    show!
  end

  def update
    params[:question][:solution_id] != @question.solution_id ? update!(:notice => "Okay! We've selected that answer") : update!
  end
end
