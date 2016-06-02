module ControllerMacros
  def login_admin
    before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    #admin = FactoryGirl.create(:admin, role: FactoryGirl.create(:role_admin))
    sign_in FactoryGirl.create(:admin)
   end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      #@login_org_user = create(:org_user, :admin)
      #@user = @login_org_user.user
      #@user.confirm
      #sign_in @user
      #user = FactoryGirl.create(:user,role: FactoryGirl.create(:role_user))
      sign_in FactoryGirl.create(:user)
    end
 end
end
