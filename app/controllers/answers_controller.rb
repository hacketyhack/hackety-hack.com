class AnswersController < InheritedController
  load_and_authorize_resource

  belongs_to :question

  def create
    @answer = Answer.create params[:answer]
    @answer.question = @question
    @answer.user = current_user

    Notification.new_answer(@question).deliver

    create!(:notice => "Answer Posted!"){ question_url(params[:question_id]) }
  end


end
