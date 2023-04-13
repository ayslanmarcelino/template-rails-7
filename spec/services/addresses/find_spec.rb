require 'rails_helper'

RSpec.describe Addresses::Find, type: :service do
  subject { described_class.new(zip_code: zip_code) }

  describe '#call' do
    context 'when zip code is present' do
      context 'when zip code is valid' do
        let!(:response) {}
        let(:zip_code) { '57010-020' }

        it 'returns a parsed response' do
          response = subject.call

          expect(response['cep']).to eq('57010-020')
          expect(response['localidade']).to eq('Maceió')
          expect(response['uf']).to eq('AL')
          expect(response['bairro']).to eq('Prado')
          expect(response['complemento']).to eq('')
          expect(response['logradouro']).to eq('Praça da Faculdade')
        end
      end

      context 'when zip code is invalid' do
        let(:zip_code) { '12345-678' }

        it 'returns a error' do
          expect(subject.call).to eq({'erro' => true})
        end
      end
    end

    context 'when zip code is blank' do
      let(:zip_code) { '' }

      it 'returns an empty hash' do
        expect(subject.call).to eq({})
      end
    end
  end
end
