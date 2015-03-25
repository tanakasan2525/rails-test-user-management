shared_examples 'a protected admin controller' do
	describe '#index' do
		example 'Redirect to a login form' do
			get :index
			expect(response).to redirect_to(login_url)
		end
	end

	describe '#show' do
		example 'Redirect to a login form' do
			get :show, id: 1
			expect(response).to redirect_to(login_url)
		end
	end
end

shared_examples 'a protected singular admin controller' do
	describe '#show' do
		example 'Redirect to a login form' do
			get :show
			expect(response).to redirect_to(login_url)
		end
	end
end

