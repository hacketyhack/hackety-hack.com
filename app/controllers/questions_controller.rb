class QuestionsController < InheritedController
  before_filter :set_support
  load_and_authorize_resource

  def create
    @question = Question.create params[:question]
    @question.user = current_user
    create!(:notice => "Question Asked!") { collection_url }
  end

  def show
    @answer = Answer.new
    show!
  end

  def update
    params[:question][:solution_id] != @question.solution_id ? update!(:notice => "Okay! We've selected that answer") : update!
  end

  def collection
    if @support
      @questions ||= end_of_association_chain.supports.newest_first.paginate(:page => params[:page])
    else
      @questions ||= end_of_association_chain.no_supports.newest_first.paginate(:page => params[:page])
    end
  end
  
  def collection_url
    @support ? support_questions_path : questions_path
  end
  def new_resource_path
    @support ? new_support_question_path : new_question_path
  end
  
  def resource_path(*resource)
    @support ? support_question_path(*resource) : question_path(*resource)
  end
  
  def edit_resource_path
    @support ? edit_support_question_path : edit_question_path
  end
  
  def set_support
    @support = request.env['PATH_INFO'].include?('support')
    if @support && params[:question]
      params[:question][:support] = true
    end
  end
  
end
