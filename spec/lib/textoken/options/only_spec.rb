require 'spec_helper'

# only.tokenize(base) - base will be the mock
# object should be initialized with a value or Regexp

describe Textoken::Only do
  include_context 'base mock'
  it_behaves_like 'regexp dependent option'
  it_behaves_like 'module sharing option', 'phones'

  describe '#tokenize' do
    context 'when text is an empty array' do
      it 'does not raise an error & push nothing to findings' do
        init_mocks
        expect do
          Textoken::Only.new('dates').tokenize(base)
        end.to_not raise_error
      end
    end

    context 'when base class has expected structure' do
      it 'tokenize with a singular value from yml file' do
        init_mocks(%w(Alfonso 444-555-1234 246.555.8888))
        r = Textoken::Only.new('phones').tokenize(base)
        expect(r).to eq(%w(444-555-1234 246.555.8888))
      end

      it 'tokenize with many values from yml file' do
        init_mocks(%w(10 100.0 Alfa 5,700))
        r = Textoken::Only.new('numerics').tokenize(base)
        expect(r).to eq(%w(10 100.0 5,700))
      end
    end
  end
end
