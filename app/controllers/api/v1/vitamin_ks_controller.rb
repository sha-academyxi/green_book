class Api::V1::VitaminKsController < Api::V1::BaseController
    before_action :authentication_redirect, :only => [:index, :show]
    before_action :current_user
    before_action :set_vitamin_k, :only => [:show, :edit, :update, :destroy]

    def index
        @vitamin_ks = VitaminK.all
        if @vitamin_ks
            render json: @vitamin_ks.to_json(include: {
                child: {}
            })
        else
            render json:{
                status: 500,
                errors: ['no vitamin_ks found']
            }
        end
    end

    def create
        @vitamin_k = VitaminK.new(vitamin_k_params)
        @vitamin_k.save
        if @vitamin_k.save
            render json: {
                status: :created,
            }
        else
            render json: {
                status: 500,
                errors: @user.errors.full_messages
            }
        end
    end

    def update
        @vitamin_k.update(params.permit(:name, :address_line_1, :address_line_2, :address_suburb, :address_postcode, :address_state, :address_city, :address_country))
        if @vitamin_k.update
            render json: {
                status: :updated
            }
        else
            render json: {
                status: 500,
                errors: @user.errors.full_messages
            }
        end
    end

    def destroy
        @vitamin_k.destroy
    end

  private

    def set_vitamin_k
        @vitamin_k = VitaminK.find(params[:id])
    end

    def vitamin_k_params
        params.require(:vitamin_k).permit(:name, :address_line_1, :address_line_2, :address_suburb, :address_postcode, :address_state, :address_city, :address_country)
    end

  end