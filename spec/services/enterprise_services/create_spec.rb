require 'rails_helper'

RSpec.describe EnterpriseServices::Create, type: :service do
  subject { described_class.new(params: params) }

  let(:params) do
    {
      document_number: CNPJ.generate,
      email: FFaker::Internet.email,
      active: true,
      name: FFaker::Company.name,
      trade_name: FFaker::Company.name,
      opening_date: Date.today - 1.year,
      representative_name: FFaker::NameBR.name,
      representative_document_number: CPF.generate,
      cell_number: FFaker.numerify('###########'),
      telephone_number: FFaker.numerify('##########'),
      identity_document_type: ['rne', 'rg'].sample,
      identity_document_number: FFaker.numerify('#########'),
      identity_document_issuing_agency: 'SSP',
      birth_date: Date.today - 18.years,
      address: {
        street: FFaker::AddressBR.street,
        number: FFaker.numerify('###').to_i,
        neighborhood: FFaker::AddressBR.neighborhood,
        state: FFaker::AddressBR.state_abbr,
        city: FFaker::AddressBR.city,
        zip_code: FFaker.numerify('########'),
        country: 'Brasil',
        complement: FFaker::AddressBR.complement
      }
    }
  end

  shared_examples_for 'it creates a enterprise' do
    it do
      expect do
        subject.call
      end.to change { Enterprise.count }.by(1)

      enterprise = Enterprise.last
      address = enterprise.address

      expect(enterprise.document_number).to eq(params[:document_number])
      expect(enterprise.email).to eq(params[:email])
      expect(enterprise.active).to eq(params[:active])
      expect(enterprise.name).to eq(params[:name])
      expect(enterprise.trade_name).to eq(params[:trade_name])
      expect(enterprise.opening_date).to eq(params[:opening_date])
      expect(enterprise.representative_name).to eq(params[:representative_name])
      expect(enterprise.representative_document_number).to eq(params[:representative_document_number])
      expect(enterprise.cell_number).to eq(params[:cell_number])
      expect(enterprise.telephone_number).to eq(params[:telephone_number])
      expect(enterprise.identity_document_type).to eq(params[:identity_document_type])
      expect(enterprise.identity_document_number).to eq(params[:identity_document_number])
      expect(enterprise.identity_document_issuing_agency).to eq(params[:identity_document_issuing_agency])
      expect(enterprise.birth_date).to eq(params[:birth_date])

      expect(address.street).to eq(params[:address][:street])
      expect(address.number).to eq(params[:address][:number])
      expect(address.neighborhood).to eq(params[:address][:neighborhood])
      expect(address.state).to eq(params[:address][:state])
      expect(address.city).to eq(params[:address][:city])
      expect(address.zip_code).to eq(params[:address][:zip_code])
      expect(address.country).to eq(params[:address][:country])
      expect(address.complement).to eq(params[:address][:complement])
    end
  end

  describe '#call' do
    context 'when successful' do
      context 'when enterprise does not exists' do
        it_behaves_like 'it creates a enterprise'
      end

      context 'when enterprise exists' do
        let!(:enterprise) { create(:enterprise, document_number: params[:document_number]) }

        context 'when enterprise has same enterprise' do
          it 'returns existing enterprise' do
            expect do
              subject.call
            end.to change { Enterprise.count }.by(0)

            created_enterprise = subject.call

            expect(created_enterprise.document_number).to eq(params[:document_number])
          end
        end
      end
    end
  end
end
