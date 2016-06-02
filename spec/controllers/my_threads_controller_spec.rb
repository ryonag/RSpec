require 'rails_helper'

describe MyThreadsController, type: :controller do

  login_user

  let!(:my_thread){create(:my_thread)}
  let!(:threadId_params){{id: my_thread.id}}
  let(:valid_attributes){FactoryGirl.attributes_for(:my_thread)}
   #my_thread: attributes_for(:my_thread)
  let(:invalid_attributes){FactoryGirl.attributes_for(:my_thread,title: nil)}
  let(:threadId_valid_params){{id: my_thread, my_thread: valid_attributes}}
  #my_thread: attributes_for(:my_thread)
  let(:threadId_invalid_params){{id: my_thread, my_thread: invalid_attributes}}
  #my_thread: attributes_for(:my_thread,title: nil)

  describe 'GET #index' do

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
      #@my_threadに新しいスレッドを割り当てること
      it "assigns a new Thread to @my_threads" do
        get :new
        expect(assigns(:my_thread)).to be_a_new(MyThread)
      end
        #:newテンプレートを表示すること
        it "renders the :new template" do
          get :new
          expect(response).to render_template :new
        end
  end

  describe 'GET #edit' do
        #@my_threadに要求されたスレッドを割り当てること
        it "assigns the requested thread to @my_thread" do
          #my_thread = create(:my_thread)
          get :edit, threadId_params
          expect(assigns(:my_thread)).to eq my_thread
        end

        #:editテンプレートを表示すること
        it "renders the :edit template" do
          #my_thread = create(:my_thread)
          get :edit, threadId_params
          expect(response).to render_template :edit
        end
  end

    describe 'POST #create' do

      #有効な属性の場合
      context "with valid attributes" do
        #データベースに新しいスレッドを保存すること
        it "saves the new thread in the database" do
          expect{
            post :create, {my_thread: valid_attributes}
            }.to change(MyThread, :count).by(1)
          end

        #threads#indexにリダイレクトすること
        it "redirects to :index template" do
          post :create, {my_thread: valid_attributes}
          expect(response).to redirect_to my_threads_path(assigns([:my_thread]))
        end
      end

      #無効な属性の場合
      context "with invalid attributes" do
        #データベースに新しいスレッドを保存しないこと
        it "does not save the new thread in the database" do
          expect{
            post :create, {my_thread: invalid_attributes}
            }.not_to change(MyThread, :count)
          end
        #:new テンプレートを再表示すること
        it "re-renders the :new template" do
          post :create, {my_thread: invalid_attributes}#my_thread: attributes_for(:my_thread, title: nil)
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do

      #有効な属性の場合
      context "with valid attributes" do
        #要求された@threadのを取得すること
        it "lacates the requested my_thread" do
          patch :update,threadId_valid_params
          expect(assigns(:my_thread)).to eq(my_thread)
        end

        #データベースのスレッドを更新すること
        it "updates the threads in the database" do
          patch :update, id: my_thread, my_thread: attributes_for(:my_thread,title: 'Lawrence')
          my_thread.reload
          expect(my_thread.title).to eq('Lawrence')
        end
        #更新したスレッドのページへリダイレクトすること
        it "redirects to the index" do
          patch :update, threadId_valid_params
          expect(response).to redirect_to my_threads_url
        end
      end

      #無効な属性の場合
      context "with invalid attributes" do
        #スレッドを更新しないこと
        it "does not update the threads" do
          patch :update,threadId_invalid_params
          my_thread.reload
          expect(my_thread.title).not_to eq('Larry')
        end
        #:editテンプレートを再表示すること
        it "re-renders the :edit template" do
          patch :update, threadId_invalid_params
            expect(response).to render_template :edit
          end
        end
      end

      describe 'DELETE #destroy' do

      #データベースからスレッドを削除すること
      it "deletes the thread from database" do
        expect{
          delete :destroy, threadId_params
          }.to change(MyThread,:count).by(-1)
        end
      #threads#indexにリダイレクトすること
      it "redirects to threads#index" do
        delete :destroy, threadId_params
        expect(response).to redirect_to my_threads_url
      end
    end

end