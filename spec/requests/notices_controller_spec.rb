require 'spec_helper'

describe NoticesController do
  before :each do
    @notice = Notice.create
    @notice.messages.create({locale: 'en', subject: 'a', body: 'b'})
    @notice.messages.create({locale: 'ja', subject: 'a', body: 'b'})
  end

  it 'Get /notices.json?locale=ja' do
    get '/notices?locale=ja'
    res = JSON.parse(response.body)
    exp = JSON.parse(Notice.locale('ja').as_json(locale: 'ja').to_json)
    expect(res['notices']).to eq(exp)
  end

  it 'Get /notices.json' do
    get '/notices'
    res = JSON.parse(response.body)
    exp = JSON.parse(Notice.locale('en').as_json(locale: 'en').to_json)
    expect(res['notices']).to eq(exp)
  end
end
