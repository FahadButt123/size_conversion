require 'rails_helper'

RSpec.describe SizeConversionService do
  let(:params) do
    {
      initial_national: 'US',
      size: '4',
      target_national: 'UK'
    }
  end

  let(:service) { SizeConversionService.new(params) }

  describe '#read_csv' do
    context 'when converting size from US to UK' do
      it 'returns the correct size' do
        expect(service.read_csv[:response]).to eq('8')
      end
    end

    context 'when size does not exist' do
      let(:params) do
        {
          initial_national: 'US',
          size: 'nonexistent',
          target_national: 'UK'
        }
      end
      it 'returns message' do
        expect(service.read_csv[:response]).to eq('Size not found in initial national environment')
      end
    end

    context 'when conversion failed' do
      let(:params) do
        {
          initial_national: 'AU',
          size: '2',
          target_national: 'ALPHA'
        }
      end
      it 'returns message' do
        expect(service.read_csv[:response]).to eq('Size not found in target national environment')
      end
    end

    context 'when invalid initial national' do
      let(:params) do
        {
          initial_national: 'UN',
          size: '2',
          target_national: 'ALPHA'
        }
      end
      it 'returns message' do
        expect(service.read_csv[:response]).to eq('Invalid initial national environment')
      end
    end

    context 'when invalid target national' do
      let(:params) do
        {
          initial_national: 'US',
          size: '2',
          target_national: 'UN'
        }
      end
      it 'returns message' do
        expect(service.read_csv[:response]).to eq('Invalid target national environment')
      end
    end
  end
end
