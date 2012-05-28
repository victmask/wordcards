class TweetController < ApplicationController
  respond_to :json, :js

  def push_cards
    twitter_account = (session[:my_twitter] = params[:my_twitter])[1..-1]
    Card.all.each do |card|
      #Twitter.update("#{card.word} - view card at http://localhost:3000/cards/#{card.id}")
      begin
        message = "Learn '#{card.word}' - '#{card.translation[0..40]}'. Go to http://#{request.host_with_port + cards_path(card.uuid)}"
        puts message
        Twitter.d(twitter_account, message)
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
