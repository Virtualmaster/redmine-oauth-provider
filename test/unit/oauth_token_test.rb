require File.expand_path(File.join(File.dirname(__FILE__), '/../test_helper'))

class RequestTokenTest < ActiveSupport::TestCase

  fixtures :client_applications, :users, :oauth_tokens

  def setup
    @token = RequestToken.create :client_application=>client_applications(:one)
  end

  def test_should_be_valid
    assert @token.valid?
  end

  def test_should_not_have_errors
    assert @token.errors.empty?
  end

  def test_should_have_a_token
    assert_not_nil @token.token
  end

  def test_should_have_a_secret
    assert_not_nil @token.secret
  end

  def test_should_not_be_authorized
    assert !@token.authorized?
  end

  def test_should_not_be_invalidated
    assert !@token.invalidated?
  end

  def test_should_authorize_request
    @token.authorize!(users(:users_001))
    assert @token.authorized?
    assert_not_nil @token.authorized_at
    assert_equal users(:users_001), @token.user
  end

  def test_should_not_exchange_without_approval
    assert_equal false, @token.exchange!
    assert_equal false, @token.invalidated?
  end

  def test_should_exchange_with_approval
    @token.authorize!(users(:users_001))
    @token.provided_oauth_verifier = @token.verifier
    @access = @token.exchange!
    assert_not_equal false, @access
    assert @token.invalidated?

    assert_equal users(:users_001), @access.user
    assert @access.authorized?
  end

end
