module EnterpriseServices
  class Create < ApplicationService
    def initialize(params:)
      @params = params
      @document_number = params[:document_number]
    end

    def call
      find_or_create!
    end

    private

    def enterprise
      Enterprise.find_by(document_number: @document_number)
    end

    def find_or_create!
      return enterprise if enterprise

      enterprise = Enterprise.create(
        document_number: @document_number,
        email: @params[:email],
        active: @params[:active],
        name: @params[:name],
        trade_name: @params[:trade_name],
        opening_date: @params[:opening_date],
        representative_name: @params[:representative_name],
        representative_document_number: @params[:representative_document_number],
        cell_number: @params[:cell_number],
        telephone_number: @params[:telephone_number],
        identity_document_type: @params[:identity_document_type],
        identity_document_number: @params[:identity_document_number],
        identity_document_issuing_agency: @params[:identity_document_issuing_agency],
        birth_date: @params[:birth_date],
        address_attributes: {
          street: @params[:address][:street],
          number: @params[:address][:number],
          neighborhood: @params[:address][:neighborhood],
          state: @params[:address][:state],
          city: @params[:address][:city],
          zip_code: @params[:address][:zip_code],
          country: @params[:address][:country],
          complement: @params[:address][:complement]
        }
      )

      enterprise.save
      enterprise
    end
  end
end
