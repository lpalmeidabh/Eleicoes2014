require 'test_helper'

class PartidosControllerTest < ActionController::TestCase
  test "should get listarPartidos" do
    get :listarPartidos
    assert_response :success
  end

end
