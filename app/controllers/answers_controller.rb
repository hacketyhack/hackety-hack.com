class AnswersController < InheritedController
  load_and_authorize_resource

  belongs_to :question

  def create
    @answer = Answer.create params[:answer]
    @answer.question = @question
    @answer.user = current_user
    
    captcha = params[:answer][:captcha]
    captcha_key = params[:answer][:captcha_key]
    
    if simple_captcha_valid?(captcha, captcha_key)
      Notification.new_answer(@question).deliver
      create!(:notice => "Answer Posted!"){ question_url(params[:question_id]) }
    else
      redirect_to @question, notice: "Incorrect captcha, are you robot?"
    end
  end

  def update
    # inherited resorces (gem) magic
    super do |format|
      format.html { redirect_to question_url(resource.question) }
    end
  end


end

