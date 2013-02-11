require 'spec_helper'

describe BlogController do
  let(:blog_post)         { Fabricate(:blog_post) }
  let(:another_blog_post) { Fabricate(:another_blog_post) }

  describe('#index') do
    it "gets index successfully" do
      get :index
      response.should be_successful
    end

    describe("handles posts by") do
      before(:each) do
        blog_post
        another_blog_post
        get :index
        @posts = assigns(:posts)
      end
      it "fetching posts" do
        @posts.size.should == 2
      end
      it "sorting them in reverse order" do
        @posts.first.content[0].should > @posts.last.content[0]
      end
    end
  end

  describe "#show" do
    before(:each) do
      blog_post
      get :show, id: blog_post
    end
    it { response.should be_successful }
    it { assigns(:post).should == blog_post }
  end

  describe "#admin" do
    context "when user is not signed in" do
      before(:each) do
        get :create
      end
      #TODO Should it not use signin_path?
      it { response.should redirect_to(new_user_session_path) }
    end

    context "when user is not an blog_poster" do
      before(:each) do
        blog_post
        get :admin
      end
      it { response.should be_redirect }
      it { assigns(:post).should be_nil }
      it { assigns(:posts).should be_nil }
    end
    context "when user is a blog_poster" do
      before(:each) do
        sign_in Fabricate(:user, blog_poster: true)
        blog_post
        get :admin
      end
      it { response.should be_successful }
      it { assigns(:post).should be_a_new(BlogPost) }
      it { assigns(:posts).size.should == 1 }
    end
  end

  describe "#create" do
    context "when user is not signed in" do
      before(:each) do
        get :create
      end
      #TODO Should it not use signin_path?
      it { response.should redirect_to(new_user_session_path) }
    end

    context "when user is not an blog_poster" do
      before(:each) do
        sign_in Fabricate(:user)
        get :create
      end

      it { response.should redirect_to(blog_index_path) }

      it { assigns(:post).should be_nil }
    end

    context "when user is a blog_poster" do
      before(:each) do
        sign_in Fabricate(:user, blog_poster: true)
      end

      it "redirects to admin_blog_index_path when user is blog_poster" do
        post :create
        response.should redirect_to(admin_blog_index_path)
      end

      it "creates a new blogpost" do
        ->{ post :create, blog_post: Fabricate.build(:blog_post).attributes }
        .should change(BlogPost, :count).by(1)
      end
    end
  end
end
