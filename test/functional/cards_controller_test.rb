require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  setup do
    @card = cards(:one)
  end

  test "should get index and default twitter" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cards)
    assert_equal('@mytwitter', assigns(:my_twitter))
    assert_nil(session[:my_twitter])
  end

  test "should get index and custom twitter in session" do
    get(:index, nil, {my_twitter: '@custom_twitter1'})
    assert_response :success
    assert_not_nil assigns(:cards)
    assert_equal('@custom_twitter1', assigns(:my_twitter))
    assert_equal('@custom_twitter1', session[:my_twitter])
  end


  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:card)
  end

  test "should get create" do
    get :create
    assert_response :success

    post :create, card: { word: 'street', translation: 'rue',
                          definition: 'a thoroughfare (usually including sidewalks) that is lined with buildings',
                          example: 'Street lighting for the first time',
                          image_src: 'http://someimage.com/123.png'}

    assert_not_nil Card.find_by_word('street')

    assert_redirected_to :root

  end

  test "should show word" do
    get :show, id: @card
    assert_response :success
  end


  test "should get edit" do
    get :edit, id: @card
    assert_response :success
  end

  test "should update card" do
    put :update, id: @card, card: { word: 'test card update' }
    assert_equal "Word card was successfully updated", flash[:notice]
    assert_not_nil Card.find_by_word('test card update')
    puts assigns(:card)
    #assert_redirected_to cards_path(assigns(:card).uuid)
  end

  test "should destroy card" do
    deleted_name = @card.word
    assert_difference('Card.count', -1) do
      delete :destroy, id: @card
    end

    assert_nil Card.find_by_word(deleted_name)
    assert_redirected_to cards_path
  end


end
