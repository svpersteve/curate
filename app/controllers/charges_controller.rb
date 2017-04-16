class ChargesController < ApplicationController
  before_action :find_artwork, only: :create

  def new
  end

  def create # rubocop:disable Metrics/MethodLength
    user = @artwork.artist
    amount = (@artwork.price * 100)
    fee = (amount * 0.25)

    begin
      charge_attrs = {
        amount: amount,
        currency: 'gbp',
        source: params[:token],
        description: "Purchase of #{@artwork.name}",
        application_fee: fee
      }

      case params[:charge_on]
      when 'connected'
        charge = Stripe::Charge.create( charge_attrs, user.access_code )
      when 'platform'
        charge_attrs[:destination] = user.stripe_uid
        charge = Stripe::Charge.create( charge_attrs )
      end

      flash[:notice] = "Charged successfully! <a target='_blank' rel='#{params[:charge_on]}-account' href='https://dashboard.stripe.com/test/payments/#{charge.id}'>View in dashboard &raquo;</a>"

    rescue Stripe::CardError => e
      error = e.json_body[:error][:message]
      flash[:error] = "Charge failed! #{error}"
    end

    redirect_to @artwork
  end

  private

  def find_artwork
    @artwork = Artwork.find(params[:format])
  end
end
