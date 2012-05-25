require 'test_helper'

class NoticesControllerTest < ActionController::TestCase
  include UnificationAssertion

  setup do
    @request.env["HTTP_X_UBIREGI_NOTICE_SECRET"] = "topsecret"
  end

  test "index with now" do
    Notice.create!(:close_at => Time.utc(2012,10,3), :messages_attributes => [
      { :subject => "English", :body => "English", :locale => "en" },
      { :subject => "Japanese", :body => "Japanese", :locale => "ja" },
      ])

    get(:index, :now => Time.utc(2012,1,1))
    assert_unifiable [:_], JSON.parse(response.body)["notices"]

    get(:index, :now => Time.utc(2013,1,1))
    assert_unifiable [], JSON.parse(response.body)["notices"]
  end

  test "index with locale" do
    Notice.create!(:close_at => Time.utc(2012,10,3), :messages_attributes => [
      { :subject => "English", :body => "English", :locale => "en" },
      { :subject => "Japanese", :body => "Japanese", :locale => "ja" },
      ])

    get(:index, :locale => "ja", :now => Time.utc(2012,1,1))

    assert_unifiable({
      "notices" => [{
        "id" => :_,
        "created_at" => :_,
        "updated_at" => :_,
        "close_at" => "2012-10-03T00:00:00Z",
        "messages" => [
          {
            "id" => :_, "created_at" => :_, "updated_at" => :_,
            "subject" => "Japanese",
            "body" => "Japanese",
            "locale" => "ja",
          }
        ]
      }]
    }, JSON.parse(response.body))

    get(:index, :locale => "en", :now => Time.utc(2012,1,1))

    assert_unifiable({
      "notices" => [{
        "id" => :_,
        "created_at" => :_,
        "updated_at" => :_,
        "close_at" => "2012-10-03T00:00:00Z",
        "messages" => [
          {
            "id" => :_, "created_at" => :_, "updated_at" => :_,
            "subject" => "English",
            "body" => "English",
            "locale" => "en",
          }
        ]
      }]
    }, JSON.parse(response.body))

    get(:index, :now => Time.utc(2012,1,1))

    assert_unifiable({
      "notices" => [{
        "id" => :_,
        "created_at" => :_,
        "updated_at" => :_,
        "close_at" => "2012-10-03T00:00:00Z",
        "messages" => [:_, :_]
      }]
    }, JSON.parse(response.body))
  end

  test "create" do
    post(:create, :notice =>
      { :messages_attributes =>
        [
          {
            :subject => "Hello world",
            :body => "This is body text.",
            :locale => "en",
          }
        ]
      })

    assert_response :created

    assert_unifiable({
      "notice" => {
        "id" => :_,
        "created_at" => :_,
        "updated_at" => :_,
        "close_at" => nil,
        "messages" => [
          {
            "id" => :_, "created_at" => :_, "updated_at" => :_,
            "subject" => "Hello world",
            "body" => "This is body text.",
            "locale" => "en",
          }
        ]
      }
    }, JSON.parse(response.body))
  end
end
