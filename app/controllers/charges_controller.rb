class ChargesController < ApplicationController
  before_action :find_artwork, only: :create

  def new
  end

  def create # rubocop:disable Metrics/MethodLength
    @amount = (@artwork.price * 100)

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: @artwork.name,
      currency: 'gbp',
      application_fee: (@amount / 10)
    }, stripe_account: @artwork.artist.stripe_uid)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def find_artwork
    @artwork = Artwork.find(params[:format])
  end
end
