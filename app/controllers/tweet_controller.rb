class TweetController < ApplicationController
  respond_to :json, :js

  def push_cards
    twitter_account = (session[:my_twitter] = params[:my_twitter])[1..-1]
    Card.all.each do |card|
      #Twitter.update("#{card.word} - view card at http://localhost:3000/cards/#{card.id}")
      begin
        Twitter.d(twitter_account, "Learn '#{card.word}' - '#{card.translation}'. View full word card at http...")
      rescue Exception => e
        @error ||= ''
        @error += "Failed on card '#{card.word}' - #{e.message}. "
      end

    end

    #p "tweeting cards #{cards.inspect}"

    #Twitter.update("I'm tweeting with @gem!")

    #render :json => {:result => 'ok'}

    @result = 'Card tweets scheduled'


  end

end
