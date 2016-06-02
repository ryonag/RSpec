require 'rails_helper'

describe MyCommentsController, type: :controller do

  login_user

  let!(:my_thread){create(:my_thread)}
  let!(:my_thread_id){{my_thread_id: my_thread.id}}
  let!(:my_comment_id){{id: my_comment.id, my_thread_id: my_thread.id}}
  #my_thread_id: my_thread.id, id: my_comment.id
  let!(:my_comment){create(:my_comment, my_thread_id: my_thread.id)}
  let(:valid_attributes){FactoryGirl.attributes_for(:my_comment)}
  let(:invalid_attributes){FactoryGirl.attributes_for(:my_comment,content: nil)}
  let(:comment_valid_params){{my_thread_id: my_thread.id, my_comment: valid_attributes}}
  #my_comment: attributes_for(:my_comment)
  let(:comment_invalid_params){{my_thread_id: my_thread.id, my_comment: invalid_attributes}}
  #my_thread_id: my_thread.id, my_comment: invalid_attributes, my_comment: attributes_for(:my_comment, content: nil)
  let(:commentId_valid_params){{my_thread_id: my_thread.id,id: my_comment.id, my_comment: valid_attributes}}
  #my_comment: attributes_for(:my_comment)
  let(:commentId_invalid_params){{my_thread_id: my_thread.id, id: my_comment.id, my_comment: invalid_attributes}}
  #my_comment: attributes_for(:my_comment,content: nil)

  describe 'GET #index' do
    it 'renders the :index template' do
      #my_thread = create(:my_thread)
      get :index,my_thread_id
      expect(response).to render_template :index
    end
  end


  describe 'GET #new' do
    #@my_commentに新しいコメントを割り当てること

    it "assigns a new Thread to @my_comments" do

      get :new, my_thread_id
      expect(assigns(:my_comment)).to be_a_new(MyComment)
    end
      #:newテンプレートを表示すること
      it "renders the :new template" do

        get :new, my_thread_id
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do

      #@my_threadに要求されたスレッドを割り当てること
      it "assigns the requested thread to @my_comment" do
        #@my_thread = create(:my_thread)
        get :edit, my_comment_id
        expect(assigns(:my_comment)).to eq my_comment
      end

      #:editテンプレートを表示すること
      it "renders the :edit template" do
        #my_thread = create(:my_thread)
        get :edit, my_comment_id
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      #before :each do
       # @my_thread = create(:my_thread)
      #end
      #有効な属性の場合
      context "with valid attributes" do
        #データベースに新しいコメントを保存すること
        it "saves the new comment in the database" do
          expect{
            post :create, comment_valid_params
            }.to change(MyComment, :count).by(1)
          end

        #comments#indexにリダイレクトすること
        it "redirects to :index template" do
          post :create, comment_valid_params
          expect(response).to redirect_to my_thread_my_comments_path(assigns(:my_thread))
        end
      end

      #無効な属性の場合
      context "with invalid attributes" do
        #データベースに新しいスレッドを保存しないこと

        it "does not save the new thread in the database" do
          expect{
            post :create,comment_invalid_params
            }.not_to change(MyComment, :count)
          end
        #:new テンプレートを再表示すること
        it "re-renders the :new template" do
          post :create, comment_invalid_params
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do

      #有効な属性の場合
      context "with valid attributes" do
        #要求された@commentのを取得すること
        it "lacates the requested @comment" do
          patch :update, commentId_valid_params
          expect(assigns(:my_comment)).to eq(my_comment)
        end

        #データベースのコメントを更新すること
        it "updates the comments in the database" do
          patch :update, my_thread_id: my_thread.id,id: my_comment.id,my_comment: attributes_for(:my_comment, content: 'Lawrence')
          my_comment.reload
          expect(my_comment.content).to eq('Lawrence')
        end
        #更新したコメントのページへリダイレクトすること
        it "redirects to the index" do
          patch :update, commentId_valid_params
          expect(response).to redirect_to my_thread_my_comments_url
        end
      end

      #無効な属性の場合
      context "with invalid attributes" do
        #コメントを更新しないこと
        it "does not update the comments" do
          patch :update, commentId_invalid_params
          my_comment.reload
          expect(my_comment.content).not_to eq('Larry')
        end
        #:editテンプレートを再表示すること
        it "re-renders the :edit template" do
          patch :update,commentId_invalid_params
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do

      #データベースからコメントを削除すること
      it "deletes the comment from database" do
        expect{
          delete :destroy, my_comment_id
          }.to change(MyComment,:count).by(-1)
        end
      #comments#indexにリダイレクトすること
      it "redirects to comments#index" do
        delete :destroy, my_comment_id
        expect(response).to redirect_to my_thread_my_comments_url
      end
    end
  end

