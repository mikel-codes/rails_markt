require 'spec_helper'
require './lib/api_constraints'

describe ApiConstraints do
    let(:api_constraints_v1) {ApiConstraints.new(version: 1, default: true)}
    let(:api_constraints_v2) {ApiConstraints.new(version: 2)}

    describe 'matches?' do
        it "returns true when the version matches the 'Accept' header"
        request = double(host: 'api.market.dev', headers: {'Accept': 'application/vnd.market.v1'})
        expect(api_constraints_v1.matches?(request)).to be_truthy
    end
end