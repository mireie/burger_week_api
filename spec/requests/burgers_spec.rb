require 'rails_helper'

describe "GET burger routes", :type => :request do 
  let!(:burgers) {FactoryBot.create_list(:burger, 20)}
  let(:burger_id) {burgers.first.id}

  it 'returns a single burger' do
    get "/burgers/#{burger_id}"
    expect(JSON.parse(response.body)).not_to be_empty
    expect(json['id']).to eq(burger_id)
  end

  before { get '/burgers'}

  it 'returns all burgers' do 
    expect(JSON.parse(response.body).size).to eq(20)
  end

  it 'returns status code 200' do 
    expect(response).to have_http_status(:success)
  end
end

describe "post a burger route", :type => :request do

  before do
    post '/burgers', params: { :name => 'test_burger', :description => 'test_description', :inspiration => "test_inspiration", :address => "test_address", :hours_of_availability => "test_hours", :drink_special => "test_drink_special", :location => "test_location" }
  end

  it 'returns the burger name' do
    expect(JSON.parse(response.body)['name']).to eq('test_burger')
  end

  it 'returns the burger description' do
    expect(JSON.parse(response.body)['description']).to eq('test_description')
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end

describe "PUT /burgers/:id", :type => :request do

  let!(:burgers) {FactoryBot.create_list(:burger, 1)}
  let(:burger_id) {burgers.first.id}

  it 'returns success message' do
    put "/burgers/#{burger_id}", params: { :name => 'Michael', :description => 'test_description', :inspiration => "test_inspiration", :address => "test_address", :hours_of_availability => "test_hours", :drink_special => "test_drink_special" }
    expect(response.body).to match('This burger has been updated successfully.')
  end
end

describe 'DELETE /burgers/:id', :type => :request do
  let!(:burgers) {FactoryBot.create_list(:burger, 1)}
  let(:burger_id) {burgers.first.id}

  it 'returns a success message' do
    delete "/burgers/#{burger_id}"
    expect(response.body).to match('This burger has been successfully destroyed.')
  end
end
