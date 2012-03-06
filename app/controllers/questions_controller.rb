class QuestionsController < InheritedController
  load_and_authorize_resource
  prepend_before_filter :set_presenter
  prepend_before_filter :set_support

  def create
    @question = Question.create params[:question]
    @question.user = current_user
    create!(:notice => "Question Asked!") { collection_url }
  end

  def show
    @title = "Questions"
    @answer = Answer.new
    show!
  end

  def update
    params[:question][:solution_id] != @question.solution_id ? update!(:notice => "Okay! We've selected that answer") : update!
  end

  def feed
    @title = "Questions Feed"

    @questions = Question.sort(:created_at.desc).limit(20).all

    @updated = @questions.first.updated_at

    respond_to do |format|
      format.atom
    end
  end

  def collection
    @questions = @presenter.apply_scope(end_of_association_chain).newest_first.paginate(:page => params[:page])
  end

  def collection_url
    collection_path
  end

  def collection_path
    @presenter.collection_path
  end

  def new_resource_path
    @presenter.new_resource_path
  end

  def resource_url(*params)
    resource_path(params)
  end
  
  def resource_path(*other)
    if other[0]
      @presenter.resource_path(other)
    else
      @presenter.resource_path(resource)
    end
  end
  
  def edit_resource_path
    @support ? edit_support_question_path : edit_question_path
  end
  
  def set_support
    @support = request.env['PATH_INFO'].include?('support') || params[:support]
    if @support && params[:question]
      params[:question][:support] = true
    end
  end
  
  def set_presenter
    if @support
      @presenter = SupportPresenter.new(resource)
    else
      @presenter = QuestionPresenter.new(resource)
    end
  end

end
