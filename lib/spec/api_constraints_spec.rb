require 'spec_helper'
require './lib/api_constraints'

describe ApiConstraints do
    context "with valid params" do
        let(:api_constraints_v1) {ApiConstraints.new(version: 1, default: true)}
        let(:api_constraints_v2) {ApiConstraints.new(version: 2, default: true)}

        describe 'matches?' do
            it "returns true when the version matches the 'Accept' header" do
                request = double(host: 'api.market.dev', headers: {'Accept': 'application/vnd.market.v1'})
                expect(api_constraints_v1.matches?(request)).to be_truthy
            end
            it "return default version for the api without the specified default param" do
                request = double(host: 'api.market.dev')
                #let the api match to route 
                expect(api_constraints_v2.matches?(request)).to be_truthy
            end
        end
    end
end