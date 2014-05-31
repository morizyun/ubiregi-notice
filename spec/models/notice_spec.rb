require 'spec_helper'

describe Notice do
  describe '#validation' do
    before :each do
      @notice = Notice.create
    end

    it 'no error with youtube plist_id' do
      @notice.messages.create({locale: 'ja', subject: 'subject1', body: 'body1'})
      expect(Notice.locale('ja')).to eq([@notice])
    end

    it 'no error with youtube plist_id' do
      @notice.messages.create({locale: 'en', subject: 'subject1', body: 'body1'})
      expect(Notice.locale('en')).to eq([@notice])
    end

    it 'no error with youtube plist_id' do
      @notice.messages.create({locale: 'ja', subject: 'subject1', body: 'body1'})
      @notice.messages.create({locale: 'en', subject: 'subject1', body: 'body1'})
      expect(Notice.locale('en')).to eq([@notice])
      expect(Notice.locale('ja')).to eq([@notice])
    end

    it 'no error with youtube plist_id' do
      @notice.messages.create({locale: 'ja', subject: 'subject1', body: 'body1'})
      expect(Notice.locale('en')).to eq([])
    end

    it 'no error with youtube plist_id' do
      expect(Notice.locale('en')).to eq([])
    end

    it 'no error with youtube plist_id' do
      @notice.messages.create({locale: 'ja', subject: 'subject1', body: 'body1'})
      @notice.messages.create({locale: 'en', subject: 'subject1', body: 'body1'})
      expect(Notice.locale('es')).to eq([@notice])
    end
  end
end